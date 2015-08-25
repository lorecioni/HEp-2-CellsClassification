%################ Image and Video Analysis #################
%## Fisher Tensors for Classifying Human Epithelial Cells ##
%###########################################################

%Import configuration class
import configuration.*;

addpath('./utils');

%Read validation set
validation_set = readCSV(configuration.validation_file, ';');
validation_set = validation_set(2:end, 5);

%Read image loop
for id = 1:configuration.image_number
    
    %Generate image filename
    filename = [configuration.image_path ...
        configuration.image_file_prefix int2str(id) '.' ...
        configuration.image_ext]
    
    %img = rgb2gray(imread(filename)); %Read image
    

    %imshow(imagesc(imtophat(imadjust(img), strel('disk',12))));
    %imshow(img);
    
    validation_set(id)
end
