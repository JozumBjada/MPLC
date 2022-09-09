function [outmodes, addmodes] = gen_output_modes(modetype, pars)
% generate output reference modes
% modetype - type of input modes
% pars - vector of parameters
% return:
% outmodes - output reference modes used for optimization
% addmodes - additional reference modes not used for optimization

    addmodes = [];

	switch modetype
        
        case 'paritySorter'
    
            pars=num2cell(pars);
			[nmode, rad, z, n, L, w0, lambda] = pars{:};
			outmodes = zeros(n, n, nmode);
            
			rad =  1.5*rad;
            pmode = 0;
            
            for m = 1:nmode
                sgn = (-1)^(mod(m, 2));
				outmodes(:, :, m) = LG_beam(sgn * rad, 0, z, n, L, w0, lambda, pmode, m-1);
            end
            
            addnmode = 4;
            addmodes = zeros(n, n, addnmode);
            for m = 1:addnmode
                sgn = (-1)^(mod(nmode + m, 2));
				addmodes(:, :, m) = LG_beam(sgn * rad, 0, z, n, L, w0, lambda, pmode, nmode + m - 1);
            end

        case 'beamsplitter'
            
			pars=num2cell(pars);
			[nmode, rad, z, n, L, w0, lambda] = pars{:};
			outmodes = zeros(n,n,nmode);

			for m = 1:nmode
				x = rad*sin(2*pi*m/nmode);
				y = rad*cos(2*pi*m/nmode);
				outmodes(:,:,m) = gaussian_beam(x, y, z, n, L, w0, lambda);
            end
            
            outmodes = generateMUB(outmodes);
        
        case {'QKDoutND', 'zernikePhase'}
            
            % get parameters
			pars=num2cell(pars);
			[nmode, rad, z, n, L, w0, lambda] = pars{:};

			auxmodes = zeros(n,n,nmode,4);
			outmodes = zeros(n,n,nmode);
            addmodes = zeros(n,n,nmode);

			x1 =  1.5*rad;
			x2 = -1.5*rad;
			ratio = 0.7;

            % create basis vectors for two bases
            for m = 1:nmode
				x = rad*sin(2*pi*m/nmode);
				y = rad*cos(2*pi*m/nmode);
                auxmodes(:,:,m,1) = gaussian_beam(x + x1, y, z, n, L, w0, lambda);
				auxmodes(:,:,m,2) = gaussian_beam(x + x2, y, z, n, L, w0, lambda);
            end
            auxmodes(:,:,:,3) = generateMUB(auxmodes(:,:,:,2), false);
            auxmodes(:,:,:,4) = generateMUB(auxmodes(:,:,:,1), true);
            
            % create superpositions of vectors from the two MUB bases
            for m = 1:nmode
				auxmode1 = auxmodes(:,:,m,1);                
                auxmode2 = auxmodes(:,:,m,3);
				outmodes(:,:,m) = sqrt(ratio)*auxmode1 + sqrt(1 - ratio)*auxmode2;
            end

            % create additional reference modes 
            for m = 1:nmode
				auxmode1 = auxmodes(:,:,m,4);                
                auxmode2 = auxmodes(:,:,m,2);
				addmodes(:,:,m) = sqrt(ratio)*auxmode1 + sqrt(1 - ratio)*auxmode2;
            end
            
        case 'QKDout2'
			pars=num2cell(pars);
			[nmode, rad, z, n, L, w0, lambda] = pars{:};

			if nmode~=3
				error('For mode QKDout2 the number of modes has to be 3.');
            end
            
			gaussmod = zeros(n,n,nmode);
			outmodes = zeros(n,n,nmode);

			x1 =  1.5*rad;
			x2 = -1.5*rad;
			ratio = 0.7;

            for m = 1:nmode
				x = rad*sin(2*pi*m/nmode);
				y = rad*cos(2*pi*m/nmode);
				gaussmod(:,:,m) = gaussian_beam(x + x2, y, z, n, L, w0, lambda);
            end

            om = exp(1i*2*pi/3);
            locphases=[1,1; om,conj(om); conj(om),om];
            
			for m = 1:nmode
				x = rad*sin(2*pi*m/nmode);
				y = rad*cos(2*pi*m/nmode);
				auxmode1 = gaussian_beam(x + x1, y, z, n, L, w0, lambda);
                phi1 = locphases(m,1);
                phi2 = locphases(m,2);
                auxmode2 = 1/sqrt(3)*(gaussmod(:,:,1) + phi1*gaussmod(:,:,2) + phi2*gaussmod(:,:,3));
				outmodes(:,:,m) = sqrt(ratio)*auxmode1 + sqrt(1 - ratio)*auxmode2;
            end

		case 'QKDout1'
			pars=num2cell(pars);
			[nmode, rad, z, n, L, w0, lambda] = pars{:};
			outmodes = zeros(n,n,nmode);

			x1 =  1.5*rad;
			x2 = -1.5*rad;
			ratio = 0.7;

			for m = 1:nmode
				x = rad*sin(2*pi*m/nmode);
				y = rad*cos(2*pi*m/nmode);
				auxmode1 = gaussian_beam(x + x1, y, z, n, L, w0, lambda);
				auxmode2 = gaussian_beam(x + x2, y, z, n, L, w0, lambda);

				outmodes(:,:,m) = sqrt(ratio)*auxmode1 + sqrt(1 - ratio)*auxmode2;
            end

		case {'Gaussians1','zernike'}

            pars=num2cell(pars);
			[nmode, rad, z, n, L, w0, lambda] = pars{:};

			outmodes = zeros(n,n,nmode);
			for m = 1:nmode
				x = rad*sin(2*pi*m/nmode);
				y = rad*cos(2*pi*m/nmode);
				outmodes(:,:,m) = gaussian_beam(x, y, z, n, L, w0, lambda);
      		end
            
		case 'GaussManuel'

			pars=num2cell(pars);
			[nmode, rad, z, n, L, w0, lambda] = pars{:};
			if nmode~=3
				error('For mode GaussManuel the number of modes has to be 3.');
			end
            
			outmodes = zeros(n,n,3);
%             outmodes(:,:,1) = gaussian_beam(0, rad, z, n, L, w0, lambda);
%             outmodes(:,:,2) = gaussian_beam(rad, -rad, z, n, L, w0, lambda);
%             outmodes(:,:,3) = gaussian_beam(-rad, -rad, z, n, L, w0, lambda);
			outmodes(:,:,1) = gaussian_beam(0, -rad, z, n, L, w0, lambda);
			outmodes(:,:,2) = gaussian_beam(-rad, rad, z, n, L, w0, lambda);
			outmodes(:,:,3) = gaussian_beam(rad, rad, z, n, L, w0, lambda);

		otherwise
			outmodes = zeros(0,0,0);
            error(['Unknown output mode: ', modetype]);

end
