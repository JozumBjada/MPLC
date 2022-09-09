function out = HG_beam(x0, y0, z, n, L, w0, lambda, rn, cn)
% generate Hermite-Gaussian beam
% generates square matrix
% x0 - x-position of the center
% y0 - y-position of the center
% z - z-position from the beamwaist
% n - number of pixels in x- and y-directions
% L - physical dimension of the square
% w0 - beamwaist
% lambda - wavelength
% rn - mode number in x-dir (?)
% cn - mode number in y-dir (?)

	% cartesian coordinates
	dx = L/n;
	[X, Y] = meshgrid((-L/2+dx):dx:L/2);
	X = X - x0;
	Y = Y - y0;
	rhoSq = X.^2+Y.^2;

	% Rayleigh range
	zR = pi*w0^2/lambda;

	% curvature
	Rz = z + zR^2/z;	

	% beam waist
	w = w0*sqrt(1+(z/zR)^2);

	% amplitude contribution
	out = exp(-rhoSq/w^2);

	% curvature contribution
	out = out.*exp(-1i*pi*rhoSq/(lambda*Rz));

	% Gouy phase contribution
	out = out.*exp(1i*(rn+cn+1)*atan2(z,zR));

	% Hermite-polynomial contribution
    out = out.*hermiteHJarda(rn,sqrt(2)*X/w);
    out = out.*hermiteHJarda(cn,sqrt(2)*Y/w);

    % normalize
    out = out/normCustom(out);
    
end
