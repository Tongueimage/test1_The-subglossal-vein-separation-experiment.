%Script file:microphone.m
%
%Purpose:
%This program plots the gain pattern of a cardioid. This is a test program for matlab
%microphone.  %❤ 麦克风?
%
%Record of revision:
% Date         Programmer          Description of chage
% =====        ==========         ======================
%23-May-2018                    The sublingual vein is divided.
%
%Define variables:
% g  --Microphone gain constant 
%gain --Gain as a function of angle
%theta  -- Angle from microphone axis(radians)
%Calculate gain versus angle
g=0.5;
theta = 0 :pi/20 : 2*pi;
gain = 2*g*(1+cos(theta));
%Plot gain
polar(theta,gain,'r-');
title('Gain versus angle \it\theta');



%打印一个心形麦克风 （❤️ 🎤）
