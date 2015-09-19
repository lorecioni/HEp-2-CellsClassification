#HEp-2 Cells Classification#

Matlab code implementing [Fisher tensors for classifying human epithelial cells](http://www.sciencedirect.com/science/article/pii/S0031320313004214) for ICPR 2012 Contest on HEp-2 Cells Classification. Here you can find the [dataset](http://mivia.unisa.it/datasets/biomedical-image-datasets/hep2-image-dataset/).

###Configuration###

Before launching the program edit configuration file.

- `image_path` image folder path.
- `image_prefix` images filename prefix.
- `image_ext` images extension.
- `validation_format` validation file format (_xls_, _xlsx_, _csv_). _xls_ format may not be read correctly on Unix systems.
- `validation_file_worksheet_name` worksheet name.
- `validation_file` file for creating the _training set_.
- `validation_file_image_ids_column` column index of image ID.
- `validation_file_image_label_column` column index of labels.
- `patterns` map the patterns with ids.
- `Gabor_options` Gabor filters settings.
- `block_size` sliding window size.
- `delta` sliding window ste
- `resize` _true/false_, if true images will be resized. 
- `K` number of gaussians in GMM.
- `kFolds` number of folds for cross-validation.

###Running###

Prepare first your training set, running `loadTrainingSet`. This will you you a table containing image id, label and filename.

Than run the code as follows: 

- `extractImages` extracts Covariance Descriptor from each image in dataset.
- `runGMM` execute GMM.
- `saveSignatures` save signatures for images, fisher tensors.
- `runSVM` run SVM classifier.
