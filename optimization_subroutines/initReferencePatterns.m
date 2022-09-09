function [in_modes, out_modes, add_in_modes, add_out_modes] = ...
    initReferencePatterns(parstruct, verbose)
% initialize reference patterns, i.e. input modes and desired output modes
% parstruct - structure containing parameters 
% verbose - if true, then additional info is printed; may be omitted
% return:
% in_modes - input modes used for optimization
% out_modes - output reference modes used for optimization
% add_in_modes - additional reference input modes, not used for optim.
% add_out_modes - additional reference output modes, not used for optim.

    % print additional information
    if nargin==1
        verbose = true;
    end

    if verbose
        disp('initialization of reference patterns...');
    end

    % input modes coming into the setup
    inpars = parstruct.inpars;
    in_modetype = parstruct.in_modetype;
    [in_modes, add_in_modes] = gen_input_modes(in_modetype, inpars);

    % desired output modes
    outpars = parstruct.outpars;
    out_modetype = parstruct.out_modetype;
    [out_modes, add_out_modes] = gen_output_modes(out_modetype, outpars);

end
