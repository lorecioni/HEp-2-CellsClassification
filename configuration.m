%Project configuration file

classdef configuration
   properties (Constant)
       %Number of image to be processed
       image_number = 149; 
       
       image_path = 'dataset/immagini_contest/';       
       image_ext = 'bmp';
       
       %Validation file for training
       validation_file = 'dataset/Validation.csv';  
       
       %Patterns
       classes = {'Punteggiato', 'Nucleolare', 'Citoplasmico', 'Omogeneo', 'Granulare', 'Negativo', 'Altro'};
       
       %Image resize (if set to false image will not be resized)
       resize = true;
       resizeTo = 1100;
       
       %GMM K
       K = 16;
   end
end