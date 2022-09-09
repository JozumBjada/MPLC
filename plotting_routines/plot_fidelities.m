function plot_fidelities(arr)
% plot fidelitites as a function of given parameter
% arr - input array as given by retrieveData from result structure
%    returned by optimization routine

% TODO...

    arr = squeeze(arr);
    figure('Name','Fidelities');   
    plot(arr);
    legend('show');

end