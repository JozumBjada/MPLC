function outbeam = sweep_forward(inbeam, holograms, pars)
% sweep the input beam through the setup and return resulting beam profile
% inbeam - input beam profile
% holograms - list of holograms
% dist - propagation distance between holograms
% L - physical dimension of a side of holograms
% lambda - wavelength

    pars = num2cell(pars);
    [dist, L, lambda] = pars{:};

    outbeam = inbeam;
    [~, ~, num_of_hols] = size(holograms);
    
    % for each plane in forward sweep...
    for hol=1:num_of_hols
        outbeam = propagate(outbeam, dist, L, lambda);
        outbeam = outbeam.*holograms(:,:,hol);
    end
    outbeam = propagate(outbeam, dist, L, lambda);

end