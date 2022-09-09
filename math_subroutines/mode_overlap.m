function patt = mode_overlap(mode1, mode2)
% interfere mode1 and mode2

% 	patt = mode1.*mode2;
    patt = conj(mode1).*mode2;

end
