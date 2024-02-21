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




![Screenshot 2024-02-21 223354](https://github.com/princesharma-10/R-Dashboard/assets/68159436/fdb82ea9-887d-40c2-bdbc-a8365988160b)


![Screenshot 2024-02-21 223405](https://github.com/princesharma-10/R-Dashboard/assets/68159436/161d01ce-8e2f-46ad-a61c-b172ed932d81)





![Screenshot 2024-02-21 223414](https://github.com/princesharma-10/R-Dashboard/assets/68159436/545941d2-1943-4c28-a3c9-3c4d4ec371fd)


![Screenshot 2024-02-21 223423](https://github.com/princesharma-10/R-Dashboard/assets/68159436/0d52c9de-4ec6-4d19-b06c-59587d523bbe)



![Screenshot 2024-02-21 223431](https://github.com/princesharma-10/R-Dashboard/assets/68159436/62a6b656-7199-4023-9919-2da4ead8e415)

Conclusion-

i) There are 8 molecule type 1JHC,1JHN,2JHC,2JHH,2JHN,3JHC,3JHH,3JHN
ii) For 1JHC-The peak is between 75 and 100
iii) 1JHN is scattered
iv) 2JHC peak is around 0
v) 2JHN peak is around -10
vi) 2JHN is around 0
vii) 3JHC peak is at 0
viii) 3JHH is between 0 and 5
ix) 3JHN is between 0 and 2.5
The peak shows the Scaling Coupling Constant



The goal is to predict the scalar coupling constant between atom pairs in molecules, given the atom types, coupling type, and features created from the molecule structure files.

Using NMR to gain insight into a molecule’s structure and dynamics depends on the ability to accurately predict so-called “scalar couplings”. These are effectively the magnetic interactions between a pair of atoms. The strength of this magnetic interaction depends on intervening electrons and chemical bonds that make up a molecule’s three-dimensional structure.

Using state-of-the-art methods from quantum mechanics, it is possible to accurately calculate scalar coupling constants given only a 3D molecular structure as input. However, these quantum mechanics calculations are extremely expensive (days or weeks per molecule), and therefore have limited applicability in day-to-day workflows.

A fast and reliable method to predict these interactions will allow medicinal chemists to gain structural insights faster and cheaper, enabling scientists to understand how the 3D chemical structure of a molecule affects its properties and behavior.


Ultimately, such tools will enable researchers to make progress in a range of important problems, like designing molecules to carry out specific cellular tasks, or designing better drug molecules to fight disease.















