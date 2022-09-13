function out = gaussian_beam(x0, y0, z, n, L, w0, lambda)
% generate Gaussian beam
% generates square matrix
% x0 - x-coordinate of the center 
% y0 - y-coordinate of the center 
% z - z-coordinate of the center 
% n - number of pixels in x- and y-direction of the square
% L - physical dimension of the square
% w0 - beam waist
% lambda - wavelength

	% cartesian coordinates
	dx = L/n;
	[X, Y] = meshgrid((-L/2+dx):dx:L/2);
	rhoSq = ((X - x0).^2+(Y - y0).^2);

	% Rayleigh range
	zR = pi*w0^2/lambda;

	% curvature
	Rz = z + zR^2/z;	

	% beam waist
	w = w0*sqrt(1+(z/zR)^2);

	% amplitude contribution
	out = w0/w*exp(-rhoSq/w^2);

	% curvature contribution
	out = out.*exp(-1i*pi*rhoSq/(lambda*Rz));

	% Gouy phase contribution
	out = out.*exp(1i*1*atan2(z,zR));
    
        % normalize
        out = out/normCustom(out);
    
end
