# Density-estimation-1
Codes corresponding to Geometric framework for nonparametric density estimation.
The main file is finaldensityestimator.m
It calls GenerateData.m to generate the samples. One can modify the file GenerateData.m to generate simulated samples from the desired disributions, for checking. For applications, one can directly load the data in the main file and comment out the line.
If using Meyer basis set for tangent space representation, the main function calls the function meyerbasisgenerator.m to generate the basis sets. The function meyerbasisgenerator.m itself calls the function meyerwavelet.m
Finally the main file calls the function densitygenerator.m which returns the final density estimate.
The role of the main file is to set the desired grid points, grid size, desired basis set, density boundaries, and whether a fized number of basis elements is to be used, or employ Algorithm 1(with desired initial #basis elements, and step size) to obtain the number of basis elements.
The function densitygenerator.m calls the function FormGammaFromC.m to obtain the corresponding \gamma from its tangent space representation.
The function densitygenerator.m calls the function FormLikeihoodFromC.m to obtain the unpenalized log likelihood function. Alternatively, one can obtain a penalized version by calling FormpenLikeihoodFromC.m. One can also insert their desired penalized version in that file instead od the AIC used by default.
