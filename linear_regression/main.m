%% ================ Part 1: Data Loading ================

%% Clear and Close Figures
clear ; close all; clc

alpha = 0.01;
num_iters = 1000;

fprintf('Your data should be in the format\nx1 x2 x3 ... xn  y\n');
filename = input('What is the name of the data file? ',"s")
fprintf('Loading data ...\n');

%% Load Data
data = load(filename);
X = data(:, 1:length(data(1,:))-1);
y = data(:, length(data(1,:)));
m = length(y);
featureNo=length(X(1,:));

%m is the number of training examples
%featureNo is the number of example features

% Print out some data points
fprintf('First 10 examples from the dataset: \n');
fprintf(' x = [%.0f %.0f], y = %.0f \n', [X(1:10,:) y(1:10,:)]');

%% ================ Part 2: Algorithm selection ================
fprintf('Which algorithm do you want to use?\n 1. Gradient descent \n 2. Normal equations \n');
algorithm = input('');

if algorithm == 1
  alpha = input('What is the learning rate? (example: 0.01) :');
  num_iters = input('What is the number of iterations? (example: 1000) :');

% Scale features and set them to zero mean
  fprintf('Normalizing Features ...\n');
  [X mu sigma] = featureNormalize(X);

% Add intercept term to X
  X = [ones(m, 1) X];
%% ================ Part 3.1: Gradient Descent ================
  fprintf('Running gradient descent ...\n');

% Init Theta and Run Gradient Descent 
  theta = zeros(featureNo+1, 1);
  [theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters);

% Plot the convergence graph
  figure;
  plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
  xlabel('Number of iterations');
  ylabel('Cost J');

% Display gradient descent's result
  fprintf('Theta computed from gradient descent: \n');
  fprintf(' %f \n', theta);
  fprintf('\n');
else
%% ================ Part 3.2: Normal Equations ================
  fprintf('Solving with normal equations...\n');

% Add intercept term to X
  X = [ones(m, 1) X];

% Calculate the parameters from the normal equation
  theta = normalEqn(X, y);

% Display normal equation's result
  fprintf('Theta computed from the normal equations: \n');
  fprintf(' %f \n', theta);
  fprintf('\n');
endif

% ====================== Part 4: Predicting values ======================
saveTheta = input('Do you want to save the result?(y/n): ',"s");

if saveTheta == 'y'
  save -ascii resultTheta.txt theta;
  if algorithm == 1
      save -ascii -append resultTheta.txt mu;
      save -ascii -append resultTheta.txt sigma;
  end  
else
  fprintf('Result not saved\n');
end

% ====================== Part 5: Predicting values ======================
% Recall that the first column of X is all-ones. Thus, it does
% not need to be normalized.

exampleTry = input('Do you want to predict the value for a specific case?(y/n): ',"s");

values = zeros(1,featureNo);  
if exampleTry == 'y'
  fprintf('Input the features:\n');
  for i = 1:featureNo
        fprintf('Input the feature #%d:\n',i);
        values(1,i) = input("");
  endfor
  if algorithm == 1
    example = (values - mu) ./sigma;
  else
    example = values;
  endif
example = [1 example];
prediction = example * theta;
fprintf(['Prediction for the example:\n $%f\n'], prediction);
endif

fprintf('Program finished. Press enter to exit.\n');
pause;