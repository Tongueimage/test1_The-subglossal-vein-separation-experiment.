//
//  ViewController.swift
//  CoreMLDemo
//
//  Created by W on 2018/05
//  Copyright © 2017 AppCoda. All rights reserved.
//

//add
import CoreML
import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var classifier: UILabel!
    
    var model: test2!  //import test2(test 2 is the model name you train)

    override func viewWillAppear(_ animated: Bool) {
        model = test2()   //Initialize the model
        //the key is when your app tries to identify objects in an image
        //it's much faster
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func camera(_ sender: Any) {
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            return
        }
        
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
        cameraPicker.allowsEditing = false
        
        present(cameraPicker, animated: true)
    }
    
    @IBAction func openLibrary(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }

}

extension ViewController: UIImagePickerControllerDelegate {
    //Advanced Core Image code, and this is not covered by this tutorial. You just need to know that we have converted the image into a format that the data model can accept. I suggest that you modify the numbers and observe the resulting results to better understand the above code.
    //高级 Core Image 代码，而这并不在本教程所涵盖的范围内。你只需要知道，我们将图像转换成了数据模型可以接受的格式。我建议你修改其中的数字并观察最终的生成结果，来更好地理解上述代码。
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true)
        
        classifier.text = "Analyzing Image now..."
        
        //We retrieve the selected image from the info dictionary (using the UIImagePickerControllerOriginalImage key) and, once we have selected it, close the UIImagePickerController.
        //我们从 info 字典中获取所选择的图片（使用 UIImagePickerControllerOriginalImage 键），另外，一旦我们选择完毕，就关闭 UIImagePickerController。
        guard let image = info["UIImagePickerControllerOriginalImage"] as? UIImage else { return }
        
        //Since the data model only accepts images with a size of 224 * 224, we convert the selected image into a square. Next, we assign this square image to another constant, newImage.
        //由于数据模型仅接受尺寸为 224 * 224 的图片，所以我们把所选图片转换成方形，接着，我们把这个方形图片赋值给另一个常量 newImage
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 224, height: 224), true, 2.0)
        image.draw(in: CGRect(x: 0, y: 0, width: 224, height: 224))
        
        //Now we convert newImage to CVPixelBuffer. You may not be familiar with CVPixelBuffer, in fact, it is an image memory area that holds pixels in memory. You can learn more about it at https://developer.apple.com/documentation/corevideo/cvpixelbuffer-q2e
        //现在，我们把 newImage 转换成 CVPixelBuffer。你可能不太熟悉 CVPixelBuffer，其实，它就是内存中一块保存像素的图像缓存区。你可以 https://developer.apple.com/documentation/corevideo/cvpixelbuffer-q2e 了解更多关于它的信息
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
                     kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        
        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault,
                                         Int(newImage.size.width),
                                         Int(newImage.size.height),
                                         kCVPixelFormatType_32ARGB,
                                         attrs,
                                         &pixelBuffer)
        
        guard status == kCVReturnSuccess else { return }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData,
                                width: Int(newImage.size.width),
                                height: Int(newImage.size.height),
                                bitsPerComponent: 8,
                                bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!),
                                space: rgbColorSpace,
                                bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        //我们使用所有呈现图片的像素，并将其转化为依赖设备的 RGB 色彩空间。接着，使用所有数据创建 CGContext，当我们打算渲染（或更改）一些底层参数时，可以很轻松的调用它，也就是接下来两行代码所做的——转换和缩放图片
        //We use all pixels that render the image and convert it into a device-dependent RGB color space. Then, using all the data to create a CGContext, when we intend to render (or change) some of the underlying parameters, it can be easily called, which is what the next two lines of code do - converting and scaling the image.
        context?.translateBy(x: 0, y: newImage.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context!)
        newImage.draw(in: CGRect(x: 0, y: 0, width: newImage.size.width, height: newImage.size.height))
        
        //Finally, generate the image, remove the context content on top of the stack, and set the value of imageView.image to newImage
        //最后，生成图像，移除栈顶的上下文内容，并将 imageView.image 的值设置为 newImage
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        imageView.image = newImage
        
        
        //Use the prediction(image:) method in the test2 class to predict objects in the image. We pass pixelBuffer as a parameter to the method. Once the prediction is completed, the prediction result will be returned as a string. We only need to update classifier's text property to display the recognition result.
        //使用 test2 类中的 prediction(image:) 方法来预测图像中的物体。我们将 pixelBuffer（重置大小的图像）作为参数传递给方法，一旦预测完成，预测结果会以字符串的形式返回，我们只要更新 classifier 的 text 属性，即可显示识别结果
        guard let prediction = try? model.prediction(image: pixelBuffer!) else { return }
        classifier.text = "I think this is \(prediction.label)."
        //& featureNames     labelProbability   featurevalue
        
    }
    
}
