function out = fidelity(mat1,mat2)
% scalar product of matrices mat1 and mat2

    out = dot(mat1(:),mat2(:));
    out = abs(out)^2;
    
end