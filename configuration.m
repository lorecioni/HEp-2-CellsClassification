%Project configuration file

classdef configuration
   properties (Constant)  
       
       %Extract image feature for train and test
       extract_train = true;
       extract_test = false;
       
       %Paths for train and test dataset
       train_path = '/Volumes/KINGSTONE/Task2TrainingSet/train/'; 
       train_labels = '/Volumes/KINGSTONE/Task2TrainingSet/gt_train.csv'; 
       test_path = ''; 
       test_labels = ''; 
       
       %Patterns
       patterns = containers.Map( ...
            {1, 2, 3, 4, 5, 6, 7}, ...
            {'homogeneous', 'speckled', 'nucleolar', 'centromere', 'golgi', 'numem', 'mitsp'}...
       );

       %Grayscale
       gray = false;
   
       %Image resize (if set to false image will not be resized)
       resize = true;
       resizeTo = 1000;
       
       %Gabor Filter options
       Gabor_options = struct(...
           'Width', 11, ...
           'num_theta', 4, ...
           'num_scale', 3, ...
           'show_plot', false);
       
       %Window size and overlap
       block_size = 80;
       delta = 20;
       
       %GMM K
       K = 16;
       
       %Classification
       use_NN_classifier = true;
       use_SVM_classifier = true;
       crossvalidate = true;
       crossvalidate_SVM_parameters = false;
       kFolds = 10;
       showConfusionMatrix = true;
   end
end