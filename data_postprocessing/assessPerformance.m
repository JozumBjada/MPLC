function performstruct = assessPerformance(...
    parstruct, in_modes, out_modes, holograms, verbose, ...
    add_in_modes, add_out_modes)
% assess performance of the setup in terms of fidelitites of different
% input and output modes

    if nargin <= 4
        verbose = true;
    end

    if verbose
        disp('performance assessment...');
    end
    
    % fidelities between input modes propagated through the resulting setup
    % and corresponding reference output modes
    [prop_modes, fidelities] = sweep_modes(...
        parstruct, in_modes, out_modes, holograms);
    performstruct.fid_in_out = fidelities;
    performstruct.prop_in_out = prop_modes;
    
    if verbose
        disp(['fidelities (in/out): ' num2str(fidelities)]);
    end

    % fidelitites for other sets of input and output states
    if isempty(add_in_modes)
        return
    end
    
    [prop_modes, fidelities] = sweep_modes(...
        parstruct, add_in_modes, add_out_modes, holograms);
    performstruct.fid_add1 = fidelities;
    performstruct.prop_add1 = prop_modes;

    if verbose
        disp(['fidelities (add1): ' num2str(fidelities)]);
    end

end
