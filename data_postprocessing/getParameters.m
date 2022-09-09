function parstruct = getParameters(filename)
% import beam and geometry parameters from external file
% data are returned as a structure parstruct
% filename - name of a file with parameters, in which each row is of the
%   form: 'nameOfParameter' numericValueOfParameter; i.e. two columns, (the
%   rest of the row is ignored)

    file = fopen(filename);
    if file == -1
        error('Unable to open the file with parameters.');
    end
    parcell = textscan(file, '%s %f %*[^\n]');
    fclose(file);
    
    % parcell{1} is now a list of cells with parameter names
    % parcell{2} is a numeric array with parameter values
    namesOfParams = parcell{1};
    valsOfParams  = parcell{2};
    
%     THE FOLLOWING CODE ONLY PICKS PARAMETERS WITH SPECIFIED VALUES GIVEN
%     BY namesOfParams CELL ARRAY.
%     % for given parameter name find its value
%     namesOfParams = {'dist', 'xnum', 'L', 'lambda', 'rad', 'w0hg', 'w0'};
%     valsOfParams = zeros(size(namesOfParams));
%     for ind=1:length(namesOfParams)
%         valsOfParams(ind) = parcell{2}(...
%             ismember(parcell{1},namesOfParams(ind))...
%             );
%     end
    
    % create the structure with parameters
    parstruct = cell2struct(num2cell(valsOfParams),namesOfParams,1);
    
end