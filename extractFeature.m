clear; clc;
addpath('./gabor');
addpath('./utils');
load('./mat/trainSet.mat');
load('./mat/testSet.mat');

fprintf('-- Images : Feature Extraction --\n\n');
            
[GR, GI] = Create_GaborFilters (configuration.Gabor_options);

%Processed images counter
counter = 1;

block_size = configuration.block_size;
delta = configuration.delta;

start_time = clock;

train_size = size(trainSet, 1);
test_size = size(testSet, 1);

% Number of images found
image_number = 0;
if configuration.extract_train
    image_number = image_number + train_size;
end
if configuration.extract_test
    image_number = image_number + test_size;
end

fprintf('Processing %d images\n\n', image_number);
fprintf('Image processed: 0 / 0.00 %% - Elapsed Time: 0.00 s\n');

%% Extract features from Train Set %%
if configuration.extract_train
    for i = 1:train_size
        filename = char(trainSet(i, 1));
        mask = char(trainSet(i, 2));

        if(exist(filename, 'file') ~= 2)
           warning('Image %s not found. Will not be processed', filename);
           continue;      
        end

        I = imread(filename);
        M = imread(mask);

        %Resize images
        if(configuration.resize)
            I = imresize(I, [configuration.resizeTo configuration.resizeTo]);
            M = imresize(M, [configuration.resizeTo configuration.resizeTo]);
        end

        block_ind = 1;
        for rs = 1:delta:1 + size(I,1) - block_size
            for cs = 1:delta:1 + size(I,2) - block_size
                temp1 = rs:rs + block_size - 1;
                temp2 = cs:cs + block_size - 1;
                block = I(temp1, temp2, :);
                mskBlock = M(temp1, temp2);

                %Considering only green level or rgb2gray(block)
                if configuration.gray
                    block = block(:, :, 2);
                end

                [features, flag] = Compute_Gabor_Cov_Features(block, GR, GI, mskBlock, 0.1);
                if flag == 1
                    cov_Sample.X(:, block_ind, i) = features;                       
                    block_ind = block_ind + 1;                              
                end
             end
        end
        cov_Sample.y(i) = cell2mat(trainSet(i, 3));
        cov_Sample.Nblocks(i) = block_ind - 1;
        fprintf('Image processed: %d / %.2f %%', counter, ...
            (counter * 100/image_number));
        fprintf(' - Elapsed time: %.2f s\n', etime(clock, start_time));
        counter = counter + 1;  
    end

    TrainSet.Nblocks = cov_Sample.Nblocks;
    TrainSet.X = cov_Sample.X;
    TrainSet.labels = cov_Sample.y;
    save('./mat/Cov_Gabor_Train','TrainSet');
end
%% Extract features from Test Set %%

clear cov_Sample;
if configuration.extract_test
    for i = 1:test_size
        filename = char(testSet(i, 1));
        mask = char(testSet(i, 2));

        if(exist(filename, 'file') ~= 2)
           warning('Image %s not found. Will not be processed', filename);
           continue;      
        end

        I = imread(filename);
        M = imread(mask);

        %Resize images
        if(configuration.resize)
            I = imresize(I, [configuration.resizeTo configuration.resizeTo]);
            M = imresize(M, [configuration.resizeTo configuration.resizeTo]);
        end

        block_ind = 1;
        for rs = 1:delta:1 + size(I,1) - block_size
            for cs = 1:delta:1 + size(I,2) - block_size
                temp1 = rs:rs + block_size - 1;
                temp2 = cs:cs + block_size - 1;
                block = I(temp1, temp2, :);
                mskBlock = M(temp1, temp2);

                %Considering only green level or rgb2gray(block)
                if configuration.gray
                    block = block(:, :, 2);
                end

                [features, flag] = Compute_Gabor_Cov_Features(block, GR, GI, mskBlock, 0.1);
                if flag == 1
                    cov_Sample.X(:, block_ind, i) = features;                       
                    block_ind = block_ind + 1;                              
                end
             end
        end
        cov_Sample.y(i) = cell2mat(testSet(i, 3));
        cov_Sample.Nblocks(i) = block_ind - 1;
        fprintf('Image processed: %d / %.2f %%', counter, ...
            (counter * 100/image_number));
        fprintf(' - Elapsed time: %.2f s\n', etime(clock, start_time));
        counter = counter + 1;  
    end

    TestSet.Nblocks = cov_Sample.Nblocks;
    TestSet.X = cov_Sample.X;
    TestSet.labels = cov_Sample.y;
    save('./mat/Cov_Gabor_Test','TestSet');
end
