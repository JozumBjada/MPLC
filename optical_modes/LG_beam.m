function out = LG_beam(x0, y0, z, n, L, w0, lambda, pmode, lmode)
% generate Hermite-Gaussian beam
% generates square matrix
% x0 - x-position of the center
% y0 - y-position of the center
% z - z-position from the beamwaist
% n - number of pixels in x- and y-directions
% L - physical dimension of the square
% w0 - beamwaist
% lambda - wavelength
% pmode - radial mode number
% lmode - angular mode number

	% cartesian coordinates
	dx = L/n;
	[X, Y] = meshgrid((-L/2+dx):dx:L/2);
	X = X - x0;
	Y = Y - y0;

    % polar coordinates
    [phase, rho] = cart2pol(X,Y);
    rhoSq=rho.^2;
    
	% Rayleigh range
	zR = pi*w0^2/lambda;

	% curvature
	Rz = z + zR^2/z;	

	% beam waist
	w = w0*sqrt(1+(z/zR)^2);

	% amplitude contribution
	out = (rho.^abs(lmode)).*exp(-rhoSq/w^2);

	% curvature contribution
	out = out.*exp(-1i*pi*rhoSq/(lambda*Rz));

	% Gouy phase contribution
	out = out.*exp(1i*(2*pmode+abs(lmode)+1)*atan2(z,zR));

	% Laguerre-polynomial contribution
    out = out.*laguerreLJarda(pmode,abs(lmode),2*rhoSq/w^2);
        
    % OAM contribution
    out = out.*exp(-1i*lmode*phase);

    % normalize
    out = out/normCustom(out);
    
end
