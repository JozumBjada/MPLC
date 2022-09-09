function outmode = propagate(inmode, dist, L, lambda)
% free-space-propagate mode inmode through distance dist
% assumes inmode is a square matrix
% inmode - input mode pattern
% dist - propagation distance
% L - hologram width/height
% lambda - wavelenght

	[n,~] = size(inmode);
	dx = L/n;
	k  = -1/(2*dx):1/L:1/(2*dx)-1/L;
	[KX,KY]  = meshgrid(k,k);

%     norm1=normCustom(inmode);
    
	transfun = exp(-1i*pi*dist*lambda*(KX.^2+KY.^2));
	transfun = fftshift(transfun);
	ftmode   = fft2(fftshift(inmode));
	outmode  = ifftshift(ifft2(transfun.*ftmode));

%     norm2=normCustom(outmode);
	% outmode  = outmode/normCustom(outmode);

% 	disp(['norms of the propagated state ', num2str(norm1), ' -> ', num2str(norm2)]);
end
