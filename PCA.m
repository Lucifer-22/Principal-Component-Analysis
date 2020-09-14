clear, close all, clc;

% Reading data from excel file
filename=input('ENTER EXCEL FILE LOCATION WITH FILENAME\n','s');
raw_x = xlsread(filename);

%Display Raw data
disp('Displaying Raw Data:');
raw_x

%Calculating Mean, Covariance from raw data
mean_x = mean(raw_x);
cov_x = cov(raw_x);

%size from raw data (m * n) size matrix
size_x = size(raw_x); 
m = size_x(1,1)
n = size_x(1,2)

%calculating sum of{ ((x1 - meanx1)(x2-meanx2)) }/(m-1)
adjust_x = zeros(m,n);
for row = 1:m;
    for col = 1:n;
        adjust_x(row, col) = raw_x(row, col) - mean_x(col);
    end
end
cov_new = cov(adjust_x);

%calculation of eigen vector and eigen value
[eig_vector, eig_value] = eig(cov_x);

%finding PC1
diag_eig = diag(eig_value);
[emax_val, emax_index] = max(diag_eig);
feature_vector = eig_vector(:, emax_index);
sum1 = 0;
for i = 1:n;
    sum1 = sum1 + diag_eig(i);
end
sum2 = 0;

%Transform Data
disp('Final Data')
final_data = adjust_x * feature_vector;
final_data = -final_data

% Decoding Data
disp('Decoded Data')
Y = final_data * feature_vector'
alsoY = (final_data * feature_vector') + mean_x;
rawOriginalData = alsoY

[coef,score]=pca(raw_x);
coef = -coef;
score = -score

%Plot Results
figure;
scatter(raw_x(:,1), raw_x(:,2));
hold on;
scatter(alsoY(:,1), alsoY(:,2),'filled','red');
%hold on;
%scatter(Y(:,1), Y(:,2),'filled','d', 'black');