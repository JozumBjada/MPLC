function [holograms, for_modes, back_modes, overlaps, fidarr] = initAuxiliaryArrays()
% initialize arrays needed for intermediate calculations as well as
% resulting patterns

    disp('initialization of auxiliary arrays...');

    % phase hologram in each plane (arrays of exp(1I.*phase...))
    holograms  = init_holograms(num_of_hols,xnum,ynum);

    % arrays of forward and backward propagating modes 
    for_modes  = init_forward_modes (in_modes , num_of_hols + 2);
    back_modes = init_backward_modes(out_modes, num_of_hols + 2, dist, L, lambda);

    % array of interference patterns
    overlaps   = zeros(xnum,ynum,num_of_modes);

    % beam parameters
    pars=[dist, L, lambda];

    % convergence of fidelities
    fidarr=zeros(num_of_sweeps,num_of_modes);
    
end