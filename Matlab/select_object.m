% Script file: select_object.m
%
%Purpose:
% This program illustrates the use of waitforbuttonpress and gco to select
% graphics objects. It creates a plot of sin(x) and cos(x), and then allows
% a uesr to select any object and examine its properties. The program
% terminates when a key press occurs.
%
%
%Record of revisions:
%Date           Programmer          Description of change
%=====          ==============      ===========================
%24-May-2018                        Original
% 
%Define variables:
%details    --Object details
% H1        --Handle of sine line
% H2        --Handle of cosine line
% Handle    --Handle of current object
% k         --result of waitforbuttonpress
% type      --Object type
% x         --Independent variable
% y1        --sin(x)
% y2        --cos(x)
% yn        --Yes/No
% Calculate sin(x) and cos(x)
x = -3*pi:pi/10:3*pi;
y1 = sin(x);
y2 = cos(x);
% Plot the functions.
H1 = plot(x,y1);
set(H1, 'LineWidth', 2);
hold on;
H2=plot(x,y2);
set(H2,'LineWidth',2,'LineStyle',':','Color','r');
title('\bf Plot of sin \it \rm\bf and cos \it x');
xlabel('\bf\it x');
ylabel('\bf sin \it x \rm\bf and cos \it x');
legend('sine','cosine');
hold off;
% Now set up a loop and wait for a mouse click.
k = waitforbuttonpress;
while k == 0
    % Get the handle of the project
    Handle = gco;
    % Get the type of this project
    type = get(Handle,'Type');
    % Display object type
    disp(('Object type = ')+ type + ('.'));
    % Do we display the details?
    yn = input('Do you want to display details?(y/n)','s');
    if yn == 'y'
        details = get(Handle);
        disp(details);
    end
    % Check for another mouse click
    k = waitforbuttonpress;
end

%Click on the object in the image to see the type
