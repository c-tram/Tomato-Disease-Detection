% Import images of sick tomatoes
images = imageDatastore('./', 'IncludeSubfolders', true, 'LabelSource', 'foldernames');

targetSize = [227 227];
% Loop, iterate through images to determine if sick.
for i = 1:numel(images.Files)

% Load a new image to classify
newImg = readimage(images,i);
img = imresize(newImg, targetSize);
    img = histeq(img); % apply histogram equalization to enhance contrast
    I = rgb2gray(img);
    I2 = imadjust(I);
    I3 = imfilter(I2, fspecial('sobel'));
    I4 = imopen(I3, strel('disk', 2));
    mask = imbinarize(I4, graythresh(I4));
    mask = imfill(mask, 'holes');
    mask = imerode(mask, strel('disk', 2));
    mask = imdilate(mask, strel('disk', 2));
    stats = regionprops('table',mask, features);
stats = regionprops('table', mask, {'Area', 'Perimeter', 'Eccentricity', 'ConvexArea', 'Solidity', 'EulerNumber'});
newFeatures = mean(stats{:,:});
% newFeaturesFilled = fillmissing(newFeatures,'next');

% Use the classifier to predict the label of the new image
load('Classifier.mat');
if any(isnan(newFeatures(:)))
    fprintf('missing features');
else
    predictedLabel = predict(ourClassifier, newFeatures);
    % Display results in terminal
    fileName = images.Files;
    fprintf('Image %s:  -> ', fileName{i});
    fprintf('Disease detected: %s\n', predictedLabel);
end



  
end
