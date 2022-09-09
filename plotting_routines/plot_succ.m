function plot_succ(arr)
% plot slices of input array
% arr - 3D or 4D array

    arrsize=size(arr);
    
    nel=numel(arrsize);
    if nel>=4
        nrow=arrsize(3);
        ncol=arrsize(4);
    elseif nel==3
        nrow=arrsize(3);
        ncol=1;
    elseif nel==2
        nrow=1;
        ncol=1;
    else
        return;
    end

    figure;
    for irow=1:nrow
        for icol=1:ncol
            subplot(nrow,ncol,icol+(irow-1)*ncol);
%             contourf(abs(arr(:,:,irow,icol)).^2);
%             imshow(abs(arr(:,:,irow,icol)).^2);
            imagesc(abs(arr(:,:,irow,icol)).^2);
            set(gca,'xtick',[],'xticklabel',[]);
        end
    end
    
end
