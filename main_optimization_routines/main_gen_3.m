%% parameters

% print additional info?
% verbose = false;
verbose = true;

parstrin.in_modetype  = 'QKDinND';
parstrin.out_modetype = 'QKDoutND';
parstrin.num_of_sweeps = 5;
parstrin.num_of_hols = 5;
parstrin.num_of_modes = 3;
    
beamparstr = getParameters('parfile.txt');
parstruct  = updateParameters(parstrin, beamparstr);

%% initialize reference patterns and perform optimization
[in_modes, out_modes, add_in_modes, add_out_modes] = ...
    initReferencePatterns(parstruct, verbose);
[for_modes, back_modes, holograms, fidarr] = optimizationRoutine(...
    parstruct, in_modes, out_modes, verbose);

%% analyze results
% propagate all input modes through the whole setup with final forms of
% holograms
performstruct = assessPerformance(parstruct, in_modes, out_modes,...
    holograms, verbose, add_in_modes, add_out_modes);
% plot(performstruct.fid_in_out)
