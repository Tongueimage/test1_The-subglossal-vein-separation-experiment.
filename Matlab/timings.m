%Script file:timings.m
%
%Purpose:
%This program calculates the time requires to calculate the squares of all intefers   . %比较循环与向量执行速度
%from 1 to 10,000 in three different ways:
% 1. Using a for loop with an uninitialized output array
% 2. Using a for loop with an preallocated output array
% 2. Using vectors.
%
%Record of revision:
% Date         Programmer          Description of chage
% =====        ==========         ======================
%23-May-2018                        Original code
%
%Define variamaxcountles:
% ii,jj  --Loop index
% average1  --Average time for calculation 1
% average2  --Average time for calculation 2
% average3  --Average time for calculation 3
% maxcountcouunt --Nummaxcounter of times to loop calculation
% square    --Array of squares
% leap_day  --Extra day for leap year
% month     --Month(mm)
% year      --Year(yyyy)

%Perform calculation with an uninitialized array
% "square". This calcalation is done only once maxcountecause it is so slow.
maxcount = 1;  %One repetition
tic;  %Start timer
for jj = 1:maxcount
    clear square % Clear output array
    for ii = 1:10000
        square(ii)=ii^2; %Calculate square
    end
end
average1 = (toc)/maxcount; %Calculate average time


%Perform calculation with a preallocated array
%"square". This calculation is averaged over 10 loops
maxcount = 10; %One repetition
tic; %Start timer
for jj=1:maxcount
    clear square %clear output array
    square = zeros(1,10000); %Preinitialize array
    for ii = 1:10000
        square(ii)=ii^2; %Calcalate square
    end
end
average2=(toc)/maxcount; %Calculate average time


%Perform calculation with vectors.This calculation averaged over 100 executions.
maxcount = 100; %One repetition
tic; %Start time
for jj=1:maxcount
    clear square; %Clear output array
    ii = 1:10000; %Set up vector
    square = ii.^2;
end
average3=(toc)/maxcount; %Calculate square
%Display results
fprintf('Loop / uninitialized array = %8.4f\n',average1);
fprintf('Loop / initialized array = %8.4f\n',average2);
fprintf('Vectorized = %8.4f\n',average3);


Output:
test1
Loop / uninitialized array =   0.0029
Loop / initialized array =   0.0003
Vectorized =   0.0000


Conclution: logical arrays are much faster than loops (逻辑数组比循环快的多)
