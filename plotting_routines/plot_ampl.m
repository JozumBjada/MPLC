function plot_ampl(arr)
% plot amplitude of the input matrix
% arr - input matrix

    figure;
    aux=abs(arr).^2;
%     imshow(aux/max(aux(:)));
    imagesc(aux/max(aux(:)));    

end
