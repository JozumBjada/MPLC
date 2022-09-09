function [inmodes, addmodes] = gen_input_modes(modetype, pars)
% generate input reference modes
% modetype - type of input modes
% pars - vector of parameters

    % addmodes ARE FOR FUTURE PURPOSES, IF WE SHOULD CHECK ALSO PROPAGATION
    % OF MODES FOR WHICH THE SETUP WAS NOT OPTIMIZED
    addmodes = [];
    
	switch modetype
        
        case 'paritySorter'
			pars=num2cell(pars);
			[nmode, rad, z, n, L, w0, lambda, pmode, lmode] = pars{:};
            pmode = 0;
            
			inmodes = zeros(n, n, nmode);
			for m = 1:nmode
				inmodes(:,:,m) = LG_beam(0, 0, z, n, L, w0, lambda,...
                    pmode, m - 1);
            end
            
            addnmode = 4;
            addmodes = zeros(n, n, addnmode);
            for m = 1:addnmode
				addmodes(:, :, m) = LG_beam(0, 0, z, n, L, w0, lambda,...
                    pmode, nmode + m - 1);
            end

        case {'zernike', 'zernikePhase'}
            pars=num2cell(pars);
			[nmode, rad, z, n, L, w0, lambda, nnum, mnum] = pars{:};
            
            gauss = true;
            inmodes = getZernikePols(n, L, rad, nmode, gauss);
            addmodes = generateMUB(inmodes, true);
        
        case 'beamsplitter'
            pars=num2cell(pars);
			[nmode, rad, z, n, L, w0, lambda, pmode, lmode] = pars{:};
            inmodes = zeros(n,n,nmode);

            for m = 1:nmode
				x = rad*sin(2*pi*m/nmode);
				y = rad*cos(2*pi*m/nmode);
                inmodes(:,:,m) = gaussian_beam(x, y, z, n, L, w0, lambda);
            end
            
		case {'LGmodes1', 'QKDin1', 'QKDinND'}
			pars=num2cell(pars);
			[nmode, rad, z, n, L, w0, lambda, pmode, lmode] = pars{:};

			inmodes = zeros(n,n,nmode);
			for m = 1:nmode
				inmodes(:,:,m) = LG_beam(0, 0, z, n, L, w0, lambda, pmode, m-1);
			end            
		    
		case 'HGmodes1'

			pars=num2cell(pars);
			[nmode, rad, z, n, L, w0, lambda, rn, cn] = pars{:};
				
            marr = zeros(nmode);
            narr = zeros(nmode);
			for ii=1:nmode
				marr(ii)=ii-1;
				narr(ii)=nmode-ii;
			end

			inmodes = zeros(n,n,nmode);
            for m = 1:nmode
	% 				inmodes(:,:,m) = herm_gauss_beam(0, 0, z, n, L, w0, lambda, marr(m), narr(m));
		        	inmodes(:,:,m) = HG_beam(0, 0, z, n, L, w0, lambda, marr(m), narr(m));
            end

		case 'HGManuel'
		   
			pars=num2cell(pars);
			[nmode, rad, z, n, L, w0, lambda, rn, cn] = pars{:};
			if nmode~=3
				error('For mode GaussManuel the number of modes has to be 3.');
			end
				
			inmodes = zeros(n,n,3);
			%             inmodes(:,:,1) = herm_gauss_beam(0, 0, z, n, L, w0, lambda, 0, 0);
			%             inmodes(:,:,2) = herm_gauss_beam(0, 0, z, n, L, w0, lambda, 0, 1);
			%             inmodes(:,:,3) = herm_gauss_beam(0, 0, z, n, L, w0, lambda, 1, 0);
			inmodes(:,:,1) = HG_beam(0, 0, z, n, L, w0, lambda, 0, 0);
			inmodes(:,:,2) = HG_beam(0, 0, z, n, L, w0, lambda, 0, 1);
			inmodes(:,:,3) = HG_beam(0, 0, z, n, L, w0, lambda, 1, 0);
				 			
		otherwise
			inmodes = zeros(0,0,0);
            error(['Unknown input mode: ', modetype]);

end
