%Project configuration file

classdef configuration
   properties (Constant)  
       
       %Extract image feature for train and test
       extract_train = false;
       extract_test = true;
       
       %Paths for train and test dataset
       train_path = '/Volumes/KINGSTONE/Task2TrainingSet/train/'; 
       train_labels = '/Volumes/KINGSTONE/Task2TrainingSet/gt_train.csv'; 
       test_path = '/Volumes/KINGSTONE/ICIP2013_training_1.0/train/'; 
       test_labels = '/Volumes/KINGSTONE/ICIP2013_training_1.0/gt_test.csv'; 
       
       %Patterns
       patterns = containers.Map( ...
            {1, 2, 3, 4, 5, 6, 7}, ...
            {'homogeneous', 'speckled', 'nucleolar', 'centromere', 'golgi', 'numem', 'mitsp'}...
       );

       %Grayscale
       gray = true;
   
       %Image resize (if set to false image will not be resized)
       resize = true;
       resizeTo = 500;
       
       %Gabor Filter options
       Gabor_options = struct(...
           'Width', 11, ...
           'num_theta', 4, ...
           'num_scale', 3, ...
           'show_plot', false);
       
       %Window size and overlap
       block_size = 80;
       delta = 40;
       
       %GMM K
       K = 16;
       
       %Classification
       use_NN_classifier = true;
       use_SVM_classifier = true;
       crossvalidate = false;
       crossvalidate_SVM_parameters = false;
       kFolds = 10;
       showConfusionMatrix = true;
   end
end