function plot_dataset(arr,figname)
% plot dataset
% arr - 3D array
% figname - name of the figure (optional)

    % determine number and layout of subplots
    [~,~,num]=size(arr);

    if num>5
       aux = floor(sqrt(num));
       nrow = aux;
       if sqrt(num) - aux > 2*eps
           nrow = nrow + 1;
       end
       ncol = floor(num/aux);
       if (nrow - 1) * ncol >= num
           nrow = nrow - 1;
       end
    else
       nrow = 1;
       ncol = num;
    end

    % determine the figure name
    if nargin==2
       ifigname=figname;
    else
       ifigname="";
    end
    
    % generate individual plots
    figure('Name',ifigname);
    for irow=1:nrow
        for icol=1:ncol
            ind = icol+(irow-1)*ncol;
            subplot(nrow,ncol,ind);
            axis square;
            if ind>num
                continue
            else
                aux=abs(arr(:,:,ind)).^2;
                imagesc(aux/max(aux(:)));
            end
            title(['plot no. ',int2str(ind)]);
            set(gca,'xtick',[],'xticklabel',[]);
        end
    end
    
end