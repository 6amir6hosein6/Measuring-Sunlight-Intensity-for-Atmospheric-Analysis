% Puts up an ellipse and masks and crops the image to the ellipse.
clc;	% Clear command window.
% clear;	% Delete all variables.
close all;	% Close all figure windows except those created by imtool.
imtool close all;	% Close all figure windows created by imtool.
workspace;	% Make sure the workspace panel is showing.
fontSize = 14;
% Change the current folder to the folder of this m-file.
% (The line of code below is from Brett Shoelson of The Mathworks.)
cd 'C:\Users\Ebrahim\Desktop\SharpCap Captures\2022-04-23\Capture\13_45_07'
%%
% Change the current folder to the folder of this m-file.
%%
% Display images to prepare for the demo.
monochromeImage = imread('Capture_00023.png');
subplot(2, 3, 1);
imshow(monochromeImage);
title('Original Image', 'FontSize', fontSize);
subplot(2, 3, 2);
imshow(monochromeImage);
title('Original Image with Circle in overlay', 'FontSize', fontSize);
set(gcf, 'units','normalized','outerposition',[0 0 1 1]); % Maximize figure.
set(gcf,'name','Image Analysis Demo','numbertitle','off') 

%----- Burn ellipse into image -----
% Create elliptical mask, h, as an ROI object over the second image.
subplot(2, 3, 3);
hEllipse = Capture_00023>1000; % Second argument defines ellipse shape and position.
% Create a binary image ("mask") from the ROI object.
maskImage = hEllipse;
% Display the ellipse mask.
subplot(2, 3, 4);
imshow(maskImage);
title('Binary mask of the ellipse', 'FontSize', fontSize);
% Mask the image with the ellipse.
maskedImage = monochromeImage .* cast(maskImage, class(monochromeImage));
% Display the image with the "burned in" ellipse.
subplot(2, 3, 5);
imshow(maskedImage);
title('New image masked by the ellipse', 'FontSize', fontSize);
% Find the bounding box
column1 = find(sum(maskImage, 1), 1, 'first')
column2 = find(sum(maskImage, 1), 1, 'last')
row1 = find(sum(maskImage, 2), 1, 'first')
row2 = find(sum(maskImage, 2), 1, 'last')
croppedImage = maskedImage(row1:row2, column1:column2);
subplot(2, 3, 6);
imshow(croppedImage);
title('Ellipse portion cropped out', 'FontSize', fontSize);
% Get the mean of the grayscale image in the elliptical area.
meanInsideEllipse = mean(monochromeImage(maskImage))

