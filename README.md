# machine-learning
Octave/Matlab implementations of common learning algorithms

# Linear regression
This is a rather simple ML algorithm, best used for simple prediction problems ex. house prices.
The data for the algorithm should be a simple text file with space separated values into columns and the last column is your label column. 
The supported algorithms are gradient descent and normal equations. Keep in mind that the time complexity of g.d. is O(n^2 logn) while the complexity for n.e. is O(n^3), making it better suitable for small data sets. If your algorithm fails to converge, try setting a smaller alpha.
Good luck :D
