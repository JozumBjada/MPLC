function [for_modes, back_modes, holograms, fidarr] = optimizationRoutine(...
    parstruct, in_modes, out_modes, verbose)
% perform the back-and-forth optimization to find holograms
% parstruct - structure with input parameters
% in_modes - input modes
% out_modes - desired output modes
% verbose - if true, additional information is printed; may be omitted

    if nargin <= 3
        verbose = true;
    end

    %% get input parameters
    [xnum, ynum, num_of_modes] = size(in_modes);
    
    num_of_hols     = parstruct.num_of_hols;
    num_of_sweeps   = parstruct.num_of_sweeps;
    proppars        = parstruct.proppars;
    aux = num2cell(proppars);
    [dist, L, lambda] = aux{:};
    
    %% initialize holograms etc.
    if verbose
        disp('initialization of auxiliary arrays...');
    end
    
    % phase hologram in each plane (arrays of exp(1I.*phase...))
    holograms  = init_holograms(num_of_hols, xnum, ynum);

    % arrays of forward and backward propagating modes 
    for_modes  = init_forward_modes (in_modes , num_of_hols + 2);
    back_modes = init_backward_modes(out_modes, num_of_hols + 2, proppars);

    % array of interference patterns
    overlaps = zeros(xnum, ynum, num_of_modes);

    % convergence of fidelities
    fidarr = zeros(num_of_sweeps, num_of_modes);

    %% optimization loop

    for step=1:num_of_sweeps

        % forward sweep
        if verbose
            disp(['forward sweep no. ' int2str(step) ' out of '...
                int2str(num_of_sweeps) ' ...']);
        end
        
        [for_modes, back_modes, overlaps, holograms] = optimize_forward(...
            for_modes, back_modes, overlaps, holograms, proppars);

        % backward sweep
        if verbose
            disp(['backward sweep no. ' int2str(step) ' out of '...
                int2str(num_of_sweeps) ' ...']);
        end
            
        [for_modes, back_modes, overlaps, holograms] = optimize_backward(...
            for_modes, back_modes, overlaps, holograms, proppars);

        % calculate also the last step of backward propagation to calculate
        % fidelity with the input states; this last step is not used for
        % the optimization though
        for mode=1:num_of_modes
            back_modes(:,:,1,mode) = propagate(back_modes(:,:,2,mode),-dist, L, lambda);
            fidarr(step,mode) = fidelity(back_modes(:,:,1,mode),in_modes(:,:,mode));
        end
    end

    %% post-processing...

    % calculate also those patterns that are not used in the optimization
    % just to avoid confusion when plotting for_modes and back_modes arrays
    for mode=1:num_of_modes
        for_modes(:,:,num_of_hols + 2,mode) = propagate(...
            for_modes(:,:,num_of_hols + 1,mode), dist, L, lambda);
    %     back_modes(:,:,1,mode) = propagate(...
    %         back_modes(:,:,2,mode),-dist, L, lambda);
    end

end