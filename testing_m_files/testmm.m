for i = 1:7
    for j = 1:3
        for k = 1:5
            mystr(i,j,k).ahoj = ...
                [...
                str2num([int2str(i) int2str(j) int2str(k) int2str(1) int2str(1)]),...
                str2num([int2str(i) int2str(j) int2str(k) int2str(1) int2str(2)]),...
                str2num([int2str(i) int2str(j) int2str(k) int2str(1) int2str(3)]);
                str2num([int2str(i) int2str(j) int2str(k) int2str(2) int2str(1)]),...
                str2num([int2str(i) int2str(j) int2str(k) int2str(2) int2str(2)]),...
                str2num([int2str(i) int2str(j) int2str(k) int2str(2) int2str(3)])...
                ];
        end
    end
end


mystr
arr=[mystr.ahoj];

rearr=reshape(arr, 2, [], 7, 3, 5);
parr=permute(rearr, [3 4 5 1 2]);