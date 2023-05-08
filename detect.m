% Import images of tomatoes
images = imageDatastore('./', 'IncludeSubfolders', true, 'LabelSource', 'foldernames');

targetSize = [100 100];

features = {'Area', 'Perimeter', 'Eccentricity', 'ConvexArea', 'Solidity', 'EulerNumber'};
% Loop, iterate through images to determine if sick.
for i = 1:numel(images.Files)

% Load a new image to classify
newImg = readimage(images,i);

img = imresize(newImg, targetSize);

% do feature extraction here
    
stats = regionprops('table',mask, features);
features = mean(stats{:,:});

% Use the classifier to predict the label of the new image
load('Classifier.mat');
if any(isnan(features(:)))
    %%do nothing
else
    predictedLabel = predict(ourClassifier, features);
    % Display results in terminal
    fileName = images.Files;
    fprintf('Image %s:  -> ', fileName{i});
    fprintf('Disease detected: %s\n', predictedLabel);
end



  
end
