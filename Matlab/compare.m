% Script file: compare.m
%
%Purpose:
% To compare binary and formatted I/O operations.
% This program generates an array of 10,000 random values and
% write it to disk both as a binary and as a formatted file.
% 
%Record of revisions:
%Date           Programmer          Description of change
%=====          ==============      ===========================
%24-May-2018                        Original
% 
%Define variables:
%count      --Number of values read/written
%fid        --File id
%in_array   --input array
%msg        --Output array
%out_array  --Operation status
%time       --Elapsed time in seconds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate the data array.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
out_array = randn(1,10000);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% First ,time the binary output operation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reset timer
tic;
% Loop for 10 times
for ii = 1:10
    % Open the binary output file for writing.
    [fid,msg] = fopen('unformatted.dat','w');
    % Write the data
    count = fwrite(fid,out_array,'float64');
    % Close the file
    status = fclose(fid);
end
% Get the average time
time = toc/10;
fprintf('Write time for unformatted file = %6.3f\n',time);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Next, time the formatted output operation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reset timer
tic;
% Loop for 10 times
for ii = 1:10
    % Open the formatted output file for writing.
    [fid,msg] = fopen('formatted.dat','wt');
    % Write the data
    count = fprintf(fid, '%23.15e\n',out_array);
    % Close the file
    status = fclose(fid);
end
% Get the average time
time = toc/10;
fprintf('Write time for formatted file = %6.3f\n',time);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Time the binary input operation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reset timer
tic;
%Loop for 10 times;
for ii = 1:10
    % Open the binarh file for reading.
    [fid,msg] = fopen('unformatted.dat','r');
    % Read the data
    [in_array,count] = fread(fid,Inf,'float64');
    % Close the file
    status = fclose(fid);
end
% Get the average time
time = toc/10;
fprintf('Read time for unformatted file = %6.3f\n',time);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Time the formatted input operation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reset timer
tic;
% Loop for 10 times
for ii = 1:10
    % Open the formatted file for reading.
    [fid,msg] = fopen('formatted.dat','rt');
    % Read the data
    [in_array, count]=fscanf(fid,'%f',Inf);
    % Clost the file
    status = fclose(fid);
end
% Get the average time
time = toc / 10;
fprintf('Read time for formatted file = %6.3f\n',time)



Output:
Write time for unformatted file =  0.001
Write time for formatted file =  0.011
Read time for unformatted file =  0.000
Read time for formatted file =  0.009



%
%Formatted and binary I/O (unformatted file) comparison, the formatless file is faster, takes up less space, 
%does not produce truncation errors, but it cannot be ported and cannot be displayed on the output device.
%格式化和二进制I/O（无格式文件 unformatted file）的比较，无格式文件较快，占用空间小，不会产生截断误差，但是不能移植，不能在输出设备显示文件。 
