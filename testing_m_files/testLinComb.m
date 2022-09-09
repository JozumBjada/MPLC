%% generate matrices
numOfMats = 300;
xdim = 500;
ydim = 600;
aux = cell(1,numOfMats);
for ind = 1:numOfMats
    aux{ind} = rand(xdim,ydim);
end
coefs = rand(1, numOfMats);

% aux = rand(50,50,3);
% aux = num2cell(aux);
% [m1, m2, m3] = aux{:};
% matarr = {m1, m2, m3};

%% naive approach
time1 = tic;
res = zeros(xdim, ydim);
for ind = 1:length(coefs)
    res = res + coefs(ind)*aux{ind};
end
time1 = toc(time1);
mat1 = res;

%% procedure
time2 = tic;
% mat2 = lin_comb_mat(coefs, aux{1}, aux{2}, aux{3});
mat2 = lin_comb_mat2(coefs, aux{:});
time2 = toc(time2);

%% multiplication
time3 = tic;
auxmat = squeeze(reshape([aux{:}], xdim, [], 1, numOfMats));
cc = coef_array(coefs, xdim, ydim);
mat3 = sum(cc.*auxmat, 3);
time3 = toc(time3);

%% results
disp(['naive: ', num2str(time1), ', proc: ', num2str(time2), ', mult: ', num2str(time3), ', naive/proc: ', num2str(time1/time2), ', naive/mult: ', num2str(time1/time3)]);
[isequal(mat1, mat2), isequal(mat1, mat3)]