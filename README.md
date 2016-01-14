#HEp-2 Cells Classification#

Matlab code implementing [Fisher tensors for classifying human epithelial cells](http://www.sciencedirect.com/science/article/pii/S0031320313004214) for ICPR 2014 Contest on HEp-2 Cells Classification. Here you can find the [dataset](http://mivia.unisa.it/datasets/biomedical-image-datasets/hep2-image-dataset/).

###Configuration###

Before launching the program edit configuration file.

- `extract_train` for extracting features from train images
- `extract_train` for extracting features from test images

Single cell configuration

- `train_path` train image path
- `train_labels` train labels groundtruth
- `test_path` test images path
- `test_labels` test images groundtruth

Full image configuration

- `train_path` train images folder path.
- `train_labels` train images groundtruth (mat file).
- `test_path` test images folder path.
- `test_labels` test images groundtruth (mat file).

Patterns

- `patterns` maps patterns names into ids.

Feature extraction option

- `Gabor_options` Gabor filters settings.
- `block_size` sliding window size.
- `delta` sliding window step
- `gray` convert images in grayscale (if they are not).
- `resize` _true/false_, if true images will be resized. 
- `resizeTo` if `resize` is true set the width of the resized images.

Classification options

- `use_NN_classifier` evaluate results with NN classifier.
- `use_SVM_classifier` evaluate results with SVM classifier.
- `K` number of gaussians in GMM.
- `crossvalidate` for evaluate dataset with crossvalidation.
- `crossvalidate_SVM_parameters` for tuning SVM parameters with crossvalidation (slow).
- `kFolds` number of folds for cross-validation. 
- `showConfusionMatrix` display confusion matrix.

###Running###

Prepare first your training set. You can choose between:

- `loadDataset` loads dataset images and groundtruth. Creates a mat file for associating image filename, mask filename and pattern id.

This will show you a table containing image id, label and filename.

Run the code as follows: 

- `extractFeature` extracts Covariance Descriptor from each image in dataset.
- `runGMM` execute GMM.
- `saveSignatures` save signatures for images, fisher tensors.
- `runClassifier` run SVM classifier.