function mat = lin_comb_mat(coefs, matarr)
% return linear combination of matrices
% coefs - 1D array of coefficients
% matarr - array of matrices

    [xdim, ydim, num_of_mats] = size(matarr);
    if num_of_mats ~= length(coefs)
        error('Number of coefficients must equal the number of matrices.');
    end
    
    mat = zeros(xdim, ydim);
    for ind = 1:num_of_mats
        mat = mat + coefs(ind)*matarr(:,:,ind);
    end
    
end