function out = laguerreLJarda(n, alpha, mat)
% laguerreLJarda - generalized Laugerre polynomial
% n - integer non-negative order
% alpha - second parameter
% mat - input matrix

    m = 0:n;
    [xdim, ydim] = size(mat);    
    
    % coefficients of the polynomial
    coefs = arrayfun(@(j) nchoosek(n+alpha, n-j), m);
    coefs = ((-1).^m)./factorial(m).*coefs;
    
    % powers of the variable
    varpows = repmat(mat, [1, 1, n]);
    varpows = cat(3, ones(xdim, ydim, 1), varpows);
    varpows = cumprod(varpows, 3);
    
    % create a lin. comb. of coefficients and powers of the variable
    out = lin_comb_mat(coefs, varpows);
    
end