
n = 1024;
L = .1;
rad = .2*L/2;
gauss = true;

z1 = zernikeMode(0, 0, n, L, rad, 0,  0, gauss);
z2 = zernikeMode(0, 0, n, L, rad, 1, -1, gauss);
z3 = zernikeMode(0, 0, n, L, rad, 1,  1, gauss);

om = exp(2i*pi/3);
% plot_dataset(z1 + z2 + z3)
% plot_dataset(z1 + om * z2 + om^2 * z3)
plot_dataset(z1 + om^2 * z2 + om * z3)