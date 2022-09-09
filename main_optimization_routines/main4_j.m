%% parameters in meters

% beam parameters
lambda=808*10^-9;
w0 = 0.0001;%0.0001;
w0hg=0.0005;

% hologram parameters
xlen=0.03;%0.005;
ylen=xlen; % due to FFT, we assume square matrices
L=xlen;
xnum=1024;
ynum=xnum; % due to FFT, we assume square matrices
num_of_hols=15;
rad=0.001;%0.0003;

% free space parameters
dist=0.2;

% input/ouput mode parameters
num_of_modes=5;

% optimization parameters
num_of_sweeps=5;%20;

%% initialize reference patterns
disp('initialization of reference patterns...');

% input modes coming into the setup
inpars = [num_of_modes, rad, 0, xnum, L, w0hg, lambda, num_of_modes, 0];
in_modetype="HGmodes1";
% in_modetype="HGManuel";
in_modes  = gen_input_modes (in_modetype, inpars);

% desired output modes
outpars = [num_of_modes, rad, 0, xnum, L, w0, lambda];
out_modetype="Gaussians1";
% out_modetype="GaussManuel";
out_modes = gen_output_modes(out_modetype, outpars);

%% initialize holograms etc.
disp('initialization...');

% phase hologram in each plane (arrays of exp(1I.*phase...))
holograms = init_holograms(num_of_hols,xnum,ynum);

% arrays of forward and backward propagating modes 
for_modes  = init_forward_modes (in_modes , num_of_hols + 2);
back_modes = init_backward_modes(out_modes, num_of_hols + 2, dist, L, lambda);

% array of interference patterns
overlaps   = zeros(xnum,ynum,num_of_modes);

% beam parameters
pars=[dist, L, lambda];

%% optimization loop

for step=1:num_of_sweeps
    
    % forward sweep
    disp(['forward sweep no. ' int2str(step) ' out of ' int2str(num_of_sweeps) ' ...']);

    [for_modes, back_modes, overlaps, holograms] = optimize_forward(...
        for_modes, back_modes, overlaps, holograms, pars);

    % backward sweep
    disp(['backward sweep no. ' int2str(step) ' out of ' int2str(num_of_sweeps) ' ...']);

    [for_modes, back_modes, overlaps, holograms] = optimize_backward(...
        for_modes, back_modes, overlaps, holograms, pars);
    
end

%% post-processing...

% calculate also those patterns that are not used in the optimization just
% to avoid confusion when plotting for_modes and back_modes arrays
for mode=1:num_of_modes
    for_modes(:,:,num_of_hols + 2,mode) = propagate(...
        for_modes(:,:,num_of_hols + 1,mode), dist, L, lambda);
    back_modes(:,:,1,mode) = propagate(...
        back_modes(:,:,2,mode),-dist, L, lambda);
end

% propagate all input modes through the whole setup with final forms of
% holograms
results=zeros(size(in_modes));
fidelities=zeros(1,num_of_modes);
for mode=1:num_of_modes
    results(:,:,mode)=sweep_forward(in_modes(:,:,mode),holograms,dist,L,lambda);
    fidelities(mode)=fidelity(results(:,:,mode),out_modes(:,:,mode));
end

% display fidelities between propagated modes and the reference modes
disp(['fidelities: ' num2str(fidelities)]);

% plot some things...
plot_ampl(sum(results,3));
plot_dataset(for_modes(:,:,:,1),"for_modes");
plot_dataset(back_modes(:,:,:,1),"back_modes");

