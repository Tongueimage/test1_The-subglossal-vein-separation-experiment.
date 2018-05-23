function all_words = word(input_string)
%WORD Function turn the sentence into separate words.
% Script file: word.m
%
%Purpose:
% To rturn the sentence into separate words.
% 
%Record of revisions:
%Date           Programmer          Description of change
%=====          ==============      ===========================
%23-May-2018                        Original
% 
%Define variables:
%all_words  --words from the sentence which will be input
remainder = input_string
all_words = ' ' ;
while(any(remainder))
    [chopped,remainder] = stock(remainder);
    all_words = strvcat(all_words, chopped);
end
