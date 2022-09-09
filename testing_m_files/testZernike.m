% parameters
n = 1024;
L = 0.1;
scalefac = 1;
x0 = 0;
y0 = 0;

% cartesian coordinates
dx = L/n;
[X, Y] = meshgrid((-L/2+dx):dx:L/2);
X = X - x0;
Y = Y - y0;
[theta, rho] = cart2pol(X, Y);
rho = rho * scalefac;

% specifications and reference
nums = [0 0; 1 1; 2 0; 2 2; 3 1; 3 3; 4 0; 4 2; 4 4];
refs = {
    ones(size(rho)),
    rho,
    2*rho.^2-1,
    rho.^2,
    3*rho.^3 - 2*rho,
    rho.^3,
    6*rho.^4 - 6*rho.^2 + 1,
    4*rho.^4 - 3*rho.^2,
    rho.^4 ...
    };

% testing
difflist = zeros(1, length(nums));
for ind = 1:length(nums)
    % assumes, that zernikeMode returns only the RADIAL PART!
    arr = zernikeMode(0, 0, n, L, scalefac, nums(ind, 1), nums(ind, 2));
    ref = refs{ind};
    aux = arr - ref;
    difflist(ind) = max(aux(:));
end
