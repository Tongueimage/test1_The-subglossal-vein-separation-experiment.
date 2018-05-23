%
% Script file: Different_graphics.m
%
%Purpose:
% To draw different graphics
%  1. Neddle figure
%  2. pie figure
% 
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
