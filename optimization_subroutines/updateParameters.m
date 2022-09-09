function parstruct = updateParameters(parstrin, beamparstr)
% update parameters according to values in structures parstrin and beamparstr

rad  = beamparstr.rad;
xnum = beamparstr.xnum;
L    = beamparstr.L;
dist = beamparstr.dist;
lambda = beamparstr.lambda;

parstruct = struct(...
    'inpars', [parstrin.num_of_modes, rad, 0, xnum, L, beamparstr.w0hg, lambda, parstrin.mode1, parstrin.mode2],...
    'outpars',[parstrin.num_of_modes, rad, 0, xnum, L, beamparstr.w0,   lambda],...
    'proppars',     [dist, L, lambda],...    
    'num_of_sweeps',parstrin.num_of_sweeps,...
    'in_modetype',  parstrin.in_modetype,...
    'out_modetype', parstrin.out_modetype,...
    ... % following fields are used also for retrieving numeric array out of structure array
    'num_of_hols',      parstrin.num_of_hols,...
    'num_of_modes',     parstrin.num_of_modes,...    
    'num_of_pixels',    xnum,...
    'distance',         dist...
    );

end