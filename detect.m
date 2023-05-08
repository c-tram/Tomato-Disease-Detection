% Load all images of tomatoes
images = imageDatastore('./', 'IncludeSubfolders', true, 'LabelSource', 'foldernames');

targetSize = [256 256];

% Loop, iterate through images to determine if sick.
for i = 1:numel(images.Files)


    % Load a new image to classify
    newImg = readimage(images,i);

    img = imresize(newImg, targetSize);

    % Extract statistical features from the image

    gray_img = rgb2gray(img);
    color_img = double(img);
    color_img = color_img ./ 255;
    red = color_img(:, :, 1);
    green = color_img(:, :, 2);
    blue = color_img(:, :, 3);
    stats_gray = [mean2(gray_img), std2(gray_img), skewness(gray_img(:)), kurtosis(gray_img(:))];
    stats_color = [mean2(red), mean2(green), mean2(blue), std2(red), std2(green), std2(blue), skewness(red(:)), skewness(green(:)), skewness(blue(:)), kurtosis(red(:)), kurtosis(green(:)), kurtosis(blue(:))];

    % Combine the grayscale and color features
    features = [stats_gray, stats_color];

    % Use the classifier to predict the label of the new image
    load('Classifier.mat');
    if any(isnan(features(:)))
        %%do nothing. failsafe in case of a bad image.
    else
        predictedLabel = predict(ourClassifier, features);
        % Display results in terminal
        fileName = images.Files;
        fprintf('Image %s:  -> ', fileName{i});
        fprintf('Classification: %s\n', predictedLabel);
    end



  
end
