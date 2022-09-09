function hols = init_holograms(nhol, xnum, ynum)
% initialize holograms
% nhol - number of planes/holograms
% xnum - number of elements in x-dir
% ynum - number of elements in y-dir
% hols - 1d array of matrices representing exp(i*phi...)

	hols = ones(xnum,ynum,nhol);

end
