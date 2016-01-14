%Project configuration file

classdef configuration
   properties (Constant)  
       
       %Extract image feature for train and test
       extract_train = true;
       extract_test = true;
       
       %Paths for train and test dataset
       train_path = 'dataset/train/'; 
       train_labels = 'dataset/trnLabels.mat'; 
       test_path = 'dataset/test/'; 
       test_labels = 'dataset/tstLabels.mat'; 
       
       %Patterns
       patterns = containers.Map( ...
            {1, 2, 3, 4, 5, 6}, ...
            {'homogeneous', 'coarse_speckled', 'fine_speckled', 'centromere', 'nucleolar', 'cytoplasmatic'}...
       );

       %Grayscale
       gray = true;
   
       %Image resize (if set to false image will not be resized)
       resize = true;
       resizeTo = 80;
       
       %Gabor Filter options
       Gabor_options = struct(...
           'Width', 11, ...
           'num_theta', 4, ...
           'num_scale', 3, ...
           'show_plot', false);
       
       %Window size and overlap
       block_size = 20;
       delta = 10;
       
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