function out = getZernikePols(n, L, rad, nmode, gauss)
% return first nmode Zernike polynomials
% n - number of pixels in x- and y-directions
% L - physical length of the edges in x- and y-directions
% rad - Gaussian 'cutoff' of Zernike polynomials
% nmode - number of modes

out = zeros(n, n, nmode);
num_of_nmodes = 1 + floor((sqrt(1+8*nmode)-1)/2);
ind = 1;

if nargin == 2
    gauss = true;
end

for nn = 1:num_of_nmodes
    for nm = 1:2:2*nn
        
        if ind > nmode
            break
        end
        n_num = nn - 1;
        m_num = nm - nn;
        
        out(:,:,ind) = zernikeMode(0, 0, n, L, rad, ...
            n_num, m_num, gauss);
        
        ind = ind + 1;
    end
    
end

end