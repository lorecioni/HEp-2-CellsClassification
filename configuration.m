%Project configuration file

classdef configuration
   properties (Constant)       
       
       %Paths for train and test dataset
       train_path = 'dataset/train/'; 
       train_labels = 'dataset/trnLabels.mat'; 
       test_path = 'dataset/test/'; 
       test_labels = 'dataset/tstLabels.mat'; 
       
       %Image path (for full images)
       image_path = 'dataset/images/';  
       image_prefix = 'Siero_';
       image_ext = 'bmp';
       
       %Validation file for training
       % Choose the validation format xls, xlsx, csv (xls not work on Unix,
       % use xlsx or cvs instead)
       validation_format = 'xlsx';      
       validation_file = 'dataset/Validation_set.xlsx';
       validation_file_worksheet_name = 'Lavoro';
       validation_file_image_ids_column = 3;
       validation_file_image_label_column = 6;
       
       %Patterns
        patterns = containers.Map( ...
            {1, 2, 3, 5, 6, 7}, ...
            {'Omogeneo', 'Punteggiato', 'Nucleolare', 'Citoplasmico', 'Negativo', 'Granulare'});
              
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
       delta = 5;
       
       %GMM K
       K = 16;
       
       %SVM kFolds for cross-validation
       kFolds = 8;
   end
end