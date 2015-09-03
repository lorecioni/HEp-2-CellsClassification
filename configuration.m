%Project configuration file

classdef configuration
   properties (Constant)
       %Image path
       image_path = 'dataset/immagini_contest/';       
       image_ext = 'bmp';
       
       %Validation file for training
       validation_file = 'dataset/Validation.csv';  
              
       %Image resize (if set to false image will not be resized)
       resize = true;
       resizeTo = 1000;
       
       %GMM K
       K = 16;
   end
end