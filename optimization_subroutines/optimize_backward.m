function [for_modes, back_modes, overlaps, holograms] = ...
    optimize_backward(for_modes, back_modes, overlaps, holograms, pars)
% perform optimization in forward sweep 

    % get parameters
    pars=num2cell(pars);
    [dist, L, lambda] = pars{:};
    [~, ~, num_of_hols,num_of_modes] = size(for_modes);
    num_of_hols = num_of_hols - 2;
    
   % for each plane in backward sweep...
    for hol = num_of_hols:-1:1

        % for each pair of in/out modes calculate overlap
        for mode = 1:num_of_modes
            back_modes(:,:,hol+1,mode) = propagate(back_modes(:,:,hol+2,mode), -dist, L, lambda);
            overlaps(:,:,mode) = mode_overlap(for_modes(:,:,hol+1,mode), back_modes(:,:,hol+1,mode));
        end

        % use total overlap to update the current hologram
        tot_overlap = sum(overlaps,3);
%         holograms(:,:,hol) = update_hologram(holograms(:,:,hol), tot_overlap, 'forward');
        holograms = update_holograms(holograms, hol, tot_overlap, 'forward');
%         holograms = update_holograms(holograms, hol, tot_overlap, 'halfbackward');
        
        % apply updated hologram to backward modes
        for mode = 1:num_of_modes
            back_modes(:,:,hol+1,mode) = back_modes(:,:,hol+1,mode).*conj(holograms(:,:,hol));
        end

    end

end