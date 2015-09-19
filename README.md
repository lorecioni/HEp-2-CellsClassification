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

- `image_path` image folder path.
- `image_prefix` images filename prefix.
- `image_ext` images extension.
- `validation_format` validation file format (_xls_, _xlsx_, _csv_). _xls_ format may not be read correctly on Unix systems.
- `validation_file_worksheet_name` worksheet namenome del foglio di lavoro utilizzato nel file di validazione.
- `validation_file` file in formato CSV per la creazione del _training set_.
- `validation_file_image_ids_column` indice di colonna della tabella in cui è presente l'id dell'immagine.
- `validation_file_image_label_column` indice di colonna della tabella che contiene la \emph{label} assegnata all'immagine.
- `patterns` mappa le varie classi con gli identificativi del file di validazione.
- `Gabor_options` impostazioni utilizzate per la creazione del banco di filtri di Gabor.
- `block_size` dimensione della finestra di scansione dell'immagine (in pixels).
- `delta` passo (in pixels) di traslazione della finestra.
- `resize` _true/false_, se vero le immagini verranno ridimensionate. Permette un'esecuzione più rapida del programma, ma viene meno l'accuratezza finale.
- `resizeTo` imposta la dimensione alla quale ridimensionare l'immagine (se impostato il _resize_ a _true_).
- `K` numero di gaussiane per la creazione del modello a mistura.
- `kFolds` numero di suddivisioni per la cross-validazione.

###Running###

Prepare first your training set, running `loadTrainingSet`. This will you you a table containing image id, label and filename.

Than run the code as follows: 

- `extractImages` extracts Covariance Descriptor from each image in dataset.
- `runGMM` execute GMM.
- `saveSignatures` save signatures for images, fisher tensors.
- `runSVM` run SVM classifier.
