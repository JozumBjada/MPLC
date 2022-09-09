function out = hermiteHJarda(n, mat)
% calculate Hermite polynomial of order n
% n - integer non-negative order
% mat - input matrix

    m = 0:floor(n/2);
    nn = n*ones(size(m));
    
    % coefficients of the polynomial
    coefs = factorial(n)*((-1).^m)./(factorial(m).*factorial(nn-2*m));

    % powers of the variable
    varpows = repmat((2*mat).^2, [1, 1, floor(n/2)]);
    varpows = cat(3, varpows, (2*mat).^(n-2*floor(n/2)));
    varpows = cumprod(varpows, 3, 'reverse');
    
    % create a lin. comb. of coefficients and powers of the variable
    out = lin_comb_mat(coefs, varpows);

end
