function holarr = update_holograms(holarr, ind, patt, updatetype)
% update holograms based on values of the interference pattern
% holarr - array of holograms to be updated
% ind - index of the plane in which pattern patt is taken
% patt - interference pattern
% updatetype - type of the hologram update procedure

    switch updatetype

        case 'forward'

            holarr(:,:,ind) = holarr(:,:,ind).*exp(1i*angle(patt));

        case 'halfforward'
            [~, ydim, num_of_planes] = size(holarr);
            edgeind = round(ydim/2); 
            % for odd value of ydim, the code below should not work... TODO?

            if ind == 1
                holarr(:,:,ind) = holarr(:,:,ind).*exp(1i*angle(patt));
            else
                holarr(:,edgeind+1:end,ind) = holarr(:,edgeind+1:end,ind).*exp(1i*angle(patt(:,edgeind+1:end)));    
            end

            if ind ~= num_of_planes
%                 holarr(:,1:edgeind,ind+1) = holarr(:,1:edgeind,ind+1).*exp(1i*angle(patt(:,1:edgeind)));
                holarr(:,1:edgeind,ind+1) = holarr(:,1:edgeind,ind+1).*exp(1i*angle(patt(:,edgeind+1:end)));
            end
            
        case 'halfbackward'
            [~, ydim, num_of_planes] = size(holarr);
            edgeind = round(ydim/2);
            % for odd value of ydim, the code below should not work... TODO?

            if ind == num_of_planes
                holarr(:,:,ind) = holarr(:,:,ind).*exp(1i*angle(patt));
            else
                holarr(:,1:edgeind,ind) = holarr(:,1:edgeind,ind).*exp(1i*angle(patt(:,1:edgeind)));    
            end

            if ind ~= 1
%                 holarr(:,edgeind+1:end,ind-1) = holarr(:,edgeind+1:end,ind-1).*exp(1i*angle(patt(:,edgeind+1:end)));
                holarr(:,edgeind+1:end,ind-1) = holarr(:,edgeind+1:end,ind-1).*exp(1i*angle(patt(:,1:edgeind)));
            end

        otherwise
            error('unknown direction specification');
            
    end

end
