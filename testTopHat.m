close all; clc;
filename = [configuration.image_path 'Siero_2.bmp'];

img = imread(filename);

img = img(500:750, 500:750, :);
img = img(:, :, 2);

imshow(img);

img_th = imtophat(img, strel('disk', 20));

figure; imshow(img_th);