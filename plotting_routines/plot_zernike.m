function plot_zernike(nmode, mmode, fighandle)
% plot Zernike polynomial

n = 1024;
L = .1;
% rad = .2*L;
rad = .1*L/2;
gauss = true;
% gauss = false;
% x0 = 2*rad;
% y0 = 4*rad;
x0 = 0;
y0 = 0;

if nargin == 2
    fighandle = figure();
end

set(fighandle, 'name',['n: ', num2str(nmode), ', m: ',num2str(mmode)], ...
    'NumberTitle', 'off');

imagesc(zernikeMode(x0,y0, n, L, rad, nmode, mmode, gauss));
colorbar;

end