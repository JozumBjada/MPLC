function [prop_modes, fidelities] = sweep_modes(...
    parstruct, in_modes, out_modes, holograms)
% sweep all supplied modes through the setup

    [~,~,num_of_modes] = size(in_modes);    
    prop_modes=zeros(size(in_modes));
    fidelities=zeros(1,num_of_modes);
    proppars = parstruct.proppars;

    for mode=1:num_of_modes
        aux = sweep_forward(in_modes(:,:,mode), holograms, proppars);
        fidelities(mode) = fidelity(aux, out_modes(:,:,mode));
        prop_modes(:,:,mode) = aux;
    end

end