%% set path
addpath(genpath('..'));

%% optimization parameters
debug_mode = false;
% debug_mode = true;

% print additional info?
verbose = false;
% verbose = true;

parstrin.in_modetype  = 'QKDinND';
parstrin.out_modetype = 'QKDoutND';
parstrin.num_of_sweeps = 60;
parstrin.num_of_modes = 3;
parstrin.num_of_hols = 5;
    
beamparstr = getParameters('parameter_files/parfile.txt');
parstruct  = updateParameters(parstrin, beamparstr);

%% scanning loop parameters

min_nhols = 1;
max_nhols = 6;
min_powpix = 6;
max_powpix = 10;
% dist_list = 0.3/6*[1:6];
% dist_list = [0.2];
dist_list = 0.3/6*[1:7];

% if in debugging mode, perform only one sweep
if debug_mode
    min_nhols = max_nhols;
    min_powpix = max_powpix;
    dist_list = [0.2];
end

%% preparation of parameter values

num_samples_hol  = max_nhols - min_nhols + 1;
num_samples_pix  = max_powpix - min_powpix + 1;
num_samples_dist = length(dist_list);
num_samples_tot  = num_samples_hol * num_samples_pix * num_samples_dist;

pixs_list = 2.^[min_powpix:max_powpix];
hols_list = min_nhols:max_nhols;
dist_list = dist_list;

k = 0;
l = 0;
m = 0;
sample_no = 0;

disp(['total number of samples: ', num2str(num_samples_tot)]);

resultstruct = struct(...
    'duration',0,...
    'parstruct',parstruct,...
    'fidsweep',[],...
    'fidcomp',[]...
    );
resultstruct = repmat(resultstruct,...
    [num_samples_pix, num_samples_hol, num_samples_dist]);
    
%% scanning loop

total_duration = tic;

% different number of pixels
for xnum = pixs_list

    beamparstr.xnum = xnum;
    k = k + 1;
    l = 0;
    
    % input and output patterns actually do not depend on number of
    % holograms and propagation distance so we can update them only when
    % the number of pixels is changed
    parstruct = updateParameters(parstrin, beamparstr);
    [in_modes, out_modes, add_in_modes, add_out_modes] = ...
        initReferencePatterns(parstruct, verbose);
    
    % different number of holograms
    for num_of_hols = hols_list
    
        parstrin.num_of_hols = num_of_hols;
        l = l + 1;
        m = 0;

        % different propagation distance
        for dist = dist_list

            beamparstr.dist = dist;
            m = m + 1;
            sample_no = sample_no + 1;

            disp(['calculation of sample no.: ', int2str(sample_no),...
                ' (out of ', num2str(num_samples_tot),')...']);

            % update parameter values
            parstruct = updateParameters(parstrin, beamparstr);
            
            % perform optimization
            duration = tic;
            [for_modes, back_modes, holograms, fidarr] = ...
                optimizationRoutine(...
                parstruct, in_modes, out_modes, verbose);
            duration = toc(duration);

            % compare propagated input states and reference output states
            performstruct = assessPerformance(parstruct, ...
                in_modes, out_modes, holograms, verbose, ...
                add_in_modes, add_out_modes);
            
            % store important results
            % k, l, m - pix, hol, dist
            resultstruct(k,l,m).duration  = duration;
            resultstruct(k,l,m).parstruct = parstruct;
            resultstruct(k,l,m).fidsweep  = fidarr;
            resultstruct(k,l,m).fidcomp   = performstruct.fid_in_out;
            
        end
        
    end

end

%% execution time
total_duration = toc(total_duration);
[hour, min, sec] = getDuration(total_duration);
disp(['total duration of the loop: ', num2str(hour), ' hours ',...
    num2str(min), ' mins ', int2str(sec), ' secs.']);