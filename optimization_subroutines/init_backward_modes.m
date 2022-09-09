function outmodes = init_backward_modes(refmodes, num, proppars)
% initialize 2d array of matrices, where each matrix is a
% reference mode from refmodes backward-propagated to
% specific plane
% refmodes - 1d array of matrices representing reference modes
% num - number of planes
% proppars - triple of parameters: [dist, L, lambda], where:
%   dist - propagation distance
%   L - hologram width/height
%   lambda - wavelength

    proppars = num2cell(proppars);
    [dist, L, lambda] = proppars{:};

	[nrow, ncol, nmode] = size(refmodes);
	outmodes = zeros(nrow, ncol, num, nmode);
	outmodes(:,:,end,:) = refmodes;
	
	for hol = num-1:-1:1
		for m = 1:nmode
			outmodes(:,:, hol, m) = propagate(outmodes(:,:, hol+1, m), -dist, L, lambda);
		end
	end

end
