1. Pre-reqs for running project:

  	MATLAB environment with following add-ons:
	
	
	I.
	Statistics and Machine Learning Toolbox

	https://www.mathworks.com/help/stats/index.html
	
	II.
	Computer Vision Toolbox

	https://www.mathworks.com/help/vision/index.html

	III.
	ROS Toolbox

	https://www.mathworks.com/products/ros.html

2. How-to

	1. Make sure all images are in the current directory of the project. Also folder titles will 	
	be used to determine labels/classification of images inside folders.

	2. After images are imported, Run classify.m to generate a Classifier for the images given.

	3. After a classifier is generated, run the detect.m file. The detect.m file will print to 		
	terminal with a classification of every image in the root directory of the project based on 	
	the pre-trained classifier that we generated.


3. Notes

	Classifier only has been generated to produce an accuracy of 40-50% when tested.

