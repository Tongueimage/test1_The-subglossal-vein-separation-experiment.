%
% Script file: Different_graphics.m
%
%Purpose:
% To draw different graphics
%  1. Neddle figure
%  2. pie figure
%  3. Three-dimensional curve 
%Record of revisions:
%Date           Programmer          Description of change
%=====          ==============      ===========================
%23-May-2018                        Original
% 
%Define variables:
%data     --Input data array


% Neddle figure
x= [1 2 3 4 5 6];
y=[ 2 6 8 7 8 5];
stem(x,y);
title('\bfExample of a Stem Plot');
xlabel('\bf\itx');
ylabel('\bf\ity');
axis([0 7 0 10]);

% pie figure
data =[10 37  5 6  6];
explode = [0 1 0 0 0];
pie(data,explode);
title('\bfExample of  a Pie Plot');
legend('One ', 'Two','Three','Four','Five');

% Three-dimensional curve
% x(t)=e^(-0.2t) * cos(2t)
% y(t) = e^(-0.2t) * sin(2t)
% 函数表示二维机械系统振动衰退情况，x,y代表在时刻t系统位置。
t = 0:0.1:10;
x=exp(-0.2*t).*cos(2*t);
y = exp(-0.2*t).*sin(2*t);
plot3(x,y,t);
title('\bfThree-Dimensional LIne Plot');
xlabel('\bfx');
ylabel('\bfy');
zlabel('\bfTime');
axis square;
grid on;
