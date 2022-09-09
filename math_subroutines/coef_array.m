function carr = coef_array(coefs, xdim, ydim)
% take 1D array of coefficients and return 3D array where 3rd dimension
% corresponds to varying coefficients
% coefs - 1D array of coefficients
% xdim - x-direction dimension
% ydim - y-direction dimension

    carr = repmat(coefs, [xdim, 1, ydim]);
    carr = permute(carr, [1, 3, 2]);
    
    % alternative code having the same result and approximately the same 
    % time consumption:
    % [~, ~, carr] = meshgrid(1:xdim, 1:ydim, coefs);
    
end
