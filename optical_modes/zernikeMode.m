function out = zernikeMode(x0, y0, n, L, rad, nmode, mmode, gauss)
% generate Zernike polynomial
% x0 - x-coordinate of the center
% y0 - y-coordinate of the center
% n - number of pixels in both dimensions
% L - length of the hologram edge
% rad - defines the radius of the unit circle; beware, rad is compared with
%   L/2, not just L!
% nmode - n mode number
% mmode - m mode number
% gauss - if true, then Zernike mode is multiplied by a Gaussian profile
%     and normalized (optional)

    if nargin == 7
        gauss = false;
    end

    % odd or even Zernike polynomial?
    odd_parity = false;
    if mmode < 0
        mmode = -mmode;
        odd_parity = true;
%         warning('odd mode');
    end
    
    if nmode < 0 || nmode < mmode || mod(nmode - mmode,2)==1
        out = zeros(n,n);
        warning('Mode numbers out of bounds. Array of zeros returned.');
        return
    end
    
	% cartesian coordinates
	dx = L/n;
	[X, Y] = meshgrid((-L/2+dx):dx:L/2);
    X = X - x0;
    Y = Y - y0;
    [theta, rho] = cart2pol(X, Y);
    
    % rescale rho such that unit radius for Zernike polynomial corresponds
    % to physical radius rad
    rho = rho / rad;
    
    % coefficients
    kind = 0:((nmode - mmode)/2);
    
    numer = ((-1).^kind) .* factorial(nmode - kind);
    denom = factorial(kind);
    denom = denom .* factorial(((nmode + mmode)/2)-kind);
    denom = denom .* factorial(((nmode - mmode)/2)-kind);
    
    coefs = numer./denom;
    
    % powers of the variable
    varpows = repmat(rho.^2, [1, 1, (nmode - mmode)/2]);
    varpows = cat(3, varpows, rho.^mmode);
    varpows = cumprod(varpows, 3, 'reverse');
    
    % create a lin. comb. of coefficients and powers of the variable
    % radial part
    radpart = lin_comb_mat(coefs, varpows);
    
    % angular part
    if odd_parity
        anglepart = sin(mmode * theta);
    else
        anglepart = cos(mmode * theta);
    end
    
    % put everything together
    out = radpart .* anglepart;
    
    if gauss
        sigma = 1.5; % ...chosen basically at random
        out = out .* exp(-(rho/sigma).^2);
        out = out/normCustom(out);
    end

end