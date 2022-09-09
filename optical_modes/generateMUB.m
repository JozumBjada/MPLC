function outbas = generateMUB(inbas, inv)
% for given first basis inbas generates MUB basis
% the output basis is basically Fourier transform of the input basis
% inbas - 3D array, ''array of matrices''
% inv - if true, then inverse Fourier transform is used; by default it is false

    if nargin == 1
        inv = false;
    end

    [~,~,nmode] = size(inbas);
    outbas = zeros(size(inbas));
    
    om = exp(1i*2*pi/nmode);
    if inv
        om = conj(om);
    end
    
    for m = 1:nmode
        aux = inbas(:,:,1);
        for j = 2:nmode
            aux = aux + (om^((m-1)*(j-1)))*inbas(:,:,j);
        end
        outbas(:,:,m) = 1/sqrt(nmode)*aux;
    end
        
end