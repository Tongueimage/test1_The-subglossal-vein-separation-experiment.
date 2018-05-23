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
% ii,jj     --Loop index
% average1  --Average time for calculation 1
% average2  --Average time for calculation 2
% average3  --Average time for calculation 3
% average4  --Average time for calculation 4
% average5  --Average time for calculation 5
% maxcountcouunt --Nummaxcounter of times to loop calculation
% square    --Array of squares
% leap_day  --Extra day for leap year
% month     --Month(mm)
% year      --Year(yyyy)
% a         --Array of input values
% b         --Logical array to serve as a mask

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

%Perform calculation using loops and branches
maxcount = 1; %One repetition
tic; %Start timer
for jj=1:maxcount
    a=1:10000;
    for ii = 1:10000
        if a(ii) > 5000
            a(ii) = sqrt(a(ii));
        end
      
    end
end
average4=(toc)/maxcount; %Calculate average time


%Perform calculation using logical arrays.
maxcount = 10; %One repetition
tic; %Start time
for jj=1:maxcount
   a=1:10000;  %Declare array a
   b=a>5000;   %Create mask
   a(b)=sqrt(a(b));  %Take square root
end
average5=(toc)/maxcount; %Calculate square

%Display results
fprintf('Loop / uninitialized array = %8.4f\n',average1);
fprintf('Loop / initialized array = %8.4f\n',average2);
fprintf('Vectorized = %8.4f\n',average3);
fprintf('Loop / if approach = %8.4f\n',average4);
fprintf('Logical array approach = %8.4f\n',average5);

Output:

test1
Loop / uninitialized array =   0.0029
Loop / initialized array =   0.0003
Vectorized =   0.0000
Loop / if approach =   0.0037
Logical array approach =   0.0003

Conclution: logical arrays are much faster than loops (逻辑数组比循环快的多)
