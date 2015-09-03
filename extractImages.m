clear; clc;
addpath('./gabor');
addpath('./utils');
load('./mat/trainSet.mat');

fprintf('-- Gabor Features Extraction --\n\n');

%Gabor Filter options
Gabor_options.Width = 11;
Gabor_options.num_theta = 4;
Gabor_options.num_scale = 3; 
%Gabor shows plot
Gabor_options.show_plot = false;
            
[GR, GI] = Create_GaborFilters (Gabor_options);

%Processed images counter
counter = 1;

block_size = 80;
delta = 20;
threshold = 0.1;

start_time = clock;

imagefiles = dir([configuration.image_path '*.' configuration.image_ext]);      
image_number = length(imagefiles);    % Number of files found

fprintf('Processing %d images\n\n', image_number);
fprintf('Image processed: 0 / 0.00 %% - Elapsed Time: 0.00 s\n');

for image_id = 1:image_number
    filename = [configuration.image_path imagefiles(image_id).name];
    
    I = imread(filename);
    
    %Resize images
    if(configuration.resize)
        I = imresize(I, [configuration.resizeTo configuration.resizeTo]);
    end
        
    mask = im2bw(rgb2gray(I), graythresh(I));
    block_ind = 1;
    for rs = 1:delta:1 + size(I,1) - block_size
        for cs = 1:delta:1 + size(I,2) - block_size
            temp1 = rs:rs + block_size - 1;
            temp2 = cs:cs + block_size - 1;
            block = I(temp1, temp2, :);
            mskBlock = mask(temp1, temp2);
            
            %Considering only green level or rgb2gray(block)
            block = block(:, :, 2);
            
            %Features vector {[(num_theta * num_scale) + 3] * [(num_theta *
            %num_scale) + 2]}/2
            [features, flag] = Compute_Gabor_Cov_Features(block, GR, GI, mskBlock, threshold);
            if flag == 1
                cov_Sample.X(:, block_ind, counter) = features;                       
                block_ind = block_ind + 1;                              
            end
         end
    end
    cov_Sample.y(counter) = trainSet(image_id, 2);
    cov_Sample.Nblocks(counter) = block_ind - 1;
    fprintf('Image processed: %d / %.2f %%', counter, ...
        (counter * 100/image_number));
    fprintf(' - Elapsed time: %.2f s\n', etime(clock, start_time));
    counter = counter + 1;  
end
 
TrainSet.Nblocks = cov_Sample.Nblocks;
TrainSet.X = cov_Sample.X;
TrainSet.labels = cov_Sample.y;

save('./mat/Cov_Gabor','TrainSet');
