#HEp-2 Cells Classification#

Matlab code implementing [Fisher tensors for classifying human epithelial cells](http://www.sciencedirect.com/science/article/pii/S0031320313004214) for ICPR 2012 Contest on HEp-2 Cells Classification. Here you can find the [dataset](http://mivia.unisa.it/datasets/biomedical-image-datasets/hep2-image-dataset/).

###Configuration###

Before launching the program edit configuration file.

- `image_path`  images folder path.
- `image_file_prefix` images filename prefix.
- `image_ext` images extension.
- `resize` true/false, resize images before processing (faster).
- `resizeTo` resize dimension.
- `K` values of K used in GMM.

###Running###

Prepare first your training set, running `loadTrainingSet`. This will you you a table containing image id, label and filename.

Than run the code as follows: 

- `extractImages` extracts Covariance Descriptor from each image in dataset.
- `runGMM` execute GMM.
- `saveSignatures` save signatures for images, fisher tensors.
- `runSVM` run SVM classifier.
