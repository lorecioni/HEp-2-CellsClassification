%Project configuration file

classdef configuration
   properties (Constant)  
       
       % Set full images or single cells classification (mutually
       % exclusive)
       full_images = false;
       cell_images = true;
       
       %Paths for train and test dataset
       train_path = 'dataset/train/'; 
       train_labels = 'dataset/trnLabels.mat'; 
       test_path = 'dataset/test/'; 
       test_labels = 'dataset/tstLabels.mat'; 
       
       %Image path (for full images)
       full_image_path = 'dataset/images/';  
       full_image_prefix = 'Siero_';
       full_image_ext = 'bmp';
       
       %Validation file for training
       % Choose the validation format xls, xlsx, csv (xls not work on Unix,
       % use xlsx or cvs instead)
       full_validation_format = 'xlsx';      
       full_validation_file = 'dataset/Validation_set.xlsx';
       full_validation_file_worksheet_name = 'Lavoro';
       full_validation_file_image_ids_column = 3;
       full_validation_file_image_label_column = 6;
       
       %Patterns
       patterns = containers.Map( ...
            {1, 2, 3, 4, 5, 6}, ...
            {'homogeneous', 'coarse_speckled', 'fine_speckled', 'centromere', 'nucleolar', 'cytoplasmatic'}...
       );
   
       %Full patterns
       %{1, 2, 3, 5, 6, 7}
       %{'Omogeneo', 'Punteggiato', 'Nucleolare', 'Citoplasmico', 'Negativo', 'Granulare'}
              
       %Image resize (if set to false image will not be resized)
       resize = true;
       resizeTo = 90;
       
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