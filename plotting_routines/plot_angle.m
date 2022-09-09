function plot_angle(arr)
% plot complex argument of input matrix mat
% arr - input matrix

    figure;
    aux=angle(arr);
%     imshow(aux/max(aux(:)));
%     imagesc(aux/max(aux(:)));    
    imagesc(aux);    

end