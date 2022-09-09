function [arrdur, arrsw, arrcomp] = retrieveData(resstr)
% retrieve arrays of data from input structure
% resstr - 3D structure array containing (meta)data about optimization

    dims = size(resstr);
    
    function arr = processArray(s, field)
        arr = [s.(field)];
        auxsize = size(arr);
        arr = reshape(arr, auxsize(1), [], dims(1), dims(2), dims(3));
        arr = permute(arr, [3 4 5 1 2]);
    end
    
    arrdur  = processArray(resstr, 'duration');
    arrsw   = processArray(resstr, 'fidsweep');
    arrcomp = processArray(resstr, 'fidcomp');

end