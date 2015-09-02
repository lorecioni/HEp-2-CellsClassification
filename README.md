#HEp-2 Cells Classification

*Configuration*

Before launching the program edit configuration file.

- `image_path`:  images folder path.
- `image_number`: number of images in path to be processed.
- `image_file_prefix`: images filename prefix.
- `image_ext`: images extension.
- `classes`: classification patterns.
- `resize`: true/false, resize images before processing (faster).
- `resizeTo`: resize dimension.
- `K`: values of K used in GMM.

*Running*

Run the code as follows: 

- `extractImages`: extracts Covariance Descriptor from each image in dataset.
- `runGMM`: execute GMM.
- `saveSignatures`: save signatures for images, fisher tensors.
- `runSVM`: run SVM classifier.
