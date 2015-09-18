%Project configuration file

classdef configuration
   properties (Constant)       
       %Image path
       image_path = 'dataset/immagini_contest/';  
       image_prefix = 'Siero_';
       image_ext = 'bmp';
       
       %Validation file for training
       validation_file = 'dataset/Validation.csv';
       validation_file_xls = 'dataset/Validation.xls';
              
       %Image resize (if set to false image will not be resized)
       resize = false;
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
   end
end