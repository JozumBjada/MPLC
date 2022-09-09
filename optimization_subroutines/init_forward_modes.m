function outmodes = init_forward_modes(refmodes, num)
% initialize 2d array of matrices, where the first matrix is a
% reference mode from refmodes and all other matrices are just
% filled with zeros
% refmodes - reference modes
% num - number of planes

	[nrow, ncol, nmode] = size(refmodes);
	outmodes = zeros(nrow, ncol, num, nmode);
	outmodes(:,:,1,:) = refmodes;
	
end
