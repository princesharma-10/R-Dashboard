# R-Dashboard
Name-Prince Sharma
Roll No- 27A
MBA BA

![download](https://github.com/princesharma-10/R-Dashboard/assets/68159436/3f60293e-b5b3-4af4-9e3f-a0de2b667c61)

train.csv - the training set, where the first column (molecule_name) is the name of the molecule where the coupling constant originates (the corresponding XYZ file is located at ./structures/.xyz), the second (atom_index_0) and third column (atom_index_1) is the atom indices of the atom-pair creating the coupling and the fourth column (scalar_coupling_constant) is the scalar coupling constant that we want to be able to predict


test.csv - the test set; same info as train, without the target variable


sample_submission.csv - a sample submission file in the correct format


structures.zip - folder containing molecular structure (xyz) files, where the first line is the number of atoms in the molecule, followed by a blank line, and then a line for every atom, where the first column 


contains the atomic element (H for hydrogen, C for carbon etc.) and the remaining columns contain the X, Y and Z cartesian coordinates (a standard format for chemists and molecular visualization programs)


structures.csv - this file contains the same information as the individual xyz structure files, but in a single file




