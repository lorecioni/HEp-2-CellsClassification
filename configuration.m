%Project configuration file

classdef configuration
   properties (Constant)
       image_path = 'dataset/immagini_contest/';
       image_number = 149;
       image_file_prefix = 'Siero_';
       image_ext = 'bmp';
       validation_file = 'dataset/Validation.csv';      
       classes = {'Punteggiato', 'Nucleolare', 'Citoplasmico', 'Omogeneo', 'Granulare', 'Negativo', 'Altro'};
   end
end