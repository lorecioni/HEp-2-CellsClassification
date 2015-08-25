function [gabordata]=Apply_Gabor_Transform(img,Gabor_downsampling_value,GaborReal, GaborImg)

A = im2double(img);
[Sx,Sy]=size(A);
B = [];
for j = 1 : size(GaborReal,3)
    face_real   =   conv2( A, GaborReal(:,:,j), 'same' );
    face_img    =   conv2( A, GaborImg(:,:,j), 'same' );
    face_mode   =   sqrt(face_real.^2+face_img.^2);
%     face_mode = abs(conv2(A, GaborReal(:,:,j)+GaborImg(:,:,j)*i,'same'));
    face_mode   =   imresize( face_mode, [floor(Sx/Gabor_downsampling_value), floor(Sy/Gabor_downsampling_value)], 'bilinear' );
    face_mode   =   face_mode(:);
    tmean       =   mean( face_mode );
    tstd        =   std( face_mode );
    face_mode   =   ( face_mode - tmean )/tstd;
    B           =   [ B, face_mode];
end
gabordata=B;
