#HEp-2 Cells Classification#

Matlab code implementing [Fisher tensors for classifying human epithelial cells](http://www.sciencedirect.com/science/article/pii/S0031320313004214) for ICPR 2014 Contest on HEp-2 Cells Classification. Here you can find the [dataset](http://mivia.unisa.it/datasets/biomedical-image-datasets/hep2-image-dataset/).

###Configuration###

Before launching the program edit configuration file.

- `full_imags` for processing dataset with full images (more than one cell for each image)
- `cell_images` for processing cells image (single cell for each image)

Single cell configuration

- `train_path` train image path
- `train_labels` train labels groundtruth
- `test_path` test images path
- `test_labels` test images groundtruth

Full image configuration

- `full_image_path` full image folder path.
- `full_image_prefix` full images filename prefix.
- `full_image_ext` full images extension.
- `full_validation_format` full images validation file format (_xls_, _xlsx_, _csv_). _xls_ format may not be read correctly on Unix systems.
- `full_validation_file_worksheet_name` full images worksheet name.
- `full_validation_file` full images file for creating the _training set_.
- `full_validation_file_image_ids_column` full images column index of image ID.
- `full_validation_file_image_label_column` full images column index of labels.

Feature extraction option

- `Gabor_options` Gabor filters settings.
- `block_size` sliding window size.
- `delta` sliding window ste
- `resize` _true/false_, if true images will be resized. 

Classification options

- `use_NN_classifier` evaluate results with NN classifier.
- `use_SVM_classifier` evaluate results with SVM classifier.
- `K` number of gaussians in GMM.
- `K` number of gaussians in GMM.
- `patterns` map the patterns with ids.
- `crossvalidate` for evaluate dataset with crossvalidation
- `crossvalidate_SVM_parameters` for tuning SVM parameters with crossvalidation (slow)
- `kFolds` number of folds for cross-validation. 
- `showConfusionMatrix` display confusion matrix.

###Running###

Prepare first your training set. You can choose between:

- `loadCellDataset` loads single cells dataset
- `loadImageDataset` loads full image dataset

This will show you a table containing image id, label and filename.

Run the code as follows: 

- `extractImages/extractImagesCells` extracts Covariance Descriptor from each cells/image in dataset.
- `runGMM` execute GMM.
- `saveSignatures` save signatures for images, fisher tensors.
- `runSVM` run SVM classifier.
