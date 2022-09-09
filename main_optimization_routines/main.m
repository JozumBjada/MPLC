%% set path
addpath(genpath('..'));

%% parameters

% print additional info?
% verbose = false;
verbose = true;

parstrin.in_modetype  = 'paritySorter';%'zernikePhase';%'zernike';
parstrin.out_modetype = 'paritySorter';%'zernikePhase';%'zernike';
% parstrin.in_modetype  = 'beamsplitter';%'QKDinND';
% parstrin.out_modetype = 'beamsplitter';%'QKDoutND';
parstrin.num_of_sweeps = 15;
parstrin.num_of_hols = 7;
parstrin.num_of_modes = 4;
parstrin.mode1 = 0;
parstrin.mode2 = 0;
    
beamparstr = getParameters('parfileSorter.txt');
parstruct  = updateParameters(parstrin, beamparstr);

%% initialize reference patterns
[in_modes, out_modes, add_in_modes, add_out_modes] = ...
    initReferencePatterns(parstruct, verbose);

%% perform optimization
[for_modes, back_modes, holograms, fidarr] = optimizationRoutine(...
    parstruct, in_modes, out_modes, verbose);

%% analyze results
% propagate all input modes through the whole setup with final forms of
% holograms
performstruct = assessPerformance(parstruct, in_modes, out_modes,...
    holograms, verbose, add_in_modes, add_out_modes);
% plot(performstruct.fid_in_out)
