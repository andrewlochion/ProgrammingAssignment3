## Merging Samsung Datasets

* The run_analysis.R program ingests the data contained in test X_test, Y_test, subject_test, X_train, Y_train and subject_train.
* It then merges the corresponding test and training datasets.

## Producing a Tidy Dataset

* After merging, those columns containing means and standard deviations in the merged X dataset are selected.
* The program will combine these columns with the activity information in the merged Y dataset and the subject information in the merged subject dataset to produce a tidy dataset.

## Calculating the Average

* From the tidy dataset, average of all variables for each activity and person are obtained and put together in another table. 