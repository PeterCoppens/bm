%% template for bm usage
% author: Peter Coppens

%% experiment configuration
% the experiment is configured using an array of structs
% execution happens as follows:
%   for i=1:length(params)
%       table = [table, run(mgr, params(i))];
%   end
params = [...
    struct('a', 2, 'b', 3), ...
    struct('a', 3, 'b', 4) ...
];

%% execute experiment
mgr = bm.mgr('test');           % load bm manager
res = mgr.exec(@run, params);   % execute the run

%% parse results
% res is an instance of BMResult, with some helper functions
% you can load the result in a different script by using 
%   res = BMResult('test');

% we can load all values of returned structs
disp('result:');
disp([res.table.sum]);            

% we can load exported values
disp('exports:');
for i=1:length(params)
    fprintf('run-%03d:\n', i);
    disp(res.load('val', i));   
end

%% experiment method
function res = run(mgr, params)
% RUN defines one run of the experiment
% signature should always be:
%   mgr:        instance of bm.BM (used for exporting).
%   params:     params struct, will be an element of params above.
    
    % displays are captured and put into log files (log.txt)
    disp(params);
    
    % we can export values.
    %   syntax: mgr.export(key, content)
    %   - results in key.mat with the content stored
    mgr.export('val', randn(params.a));
    
    % the outputs of the method should always be structs with the 
    % same fields.
    res = struct('sum', params.a + params.b);
end
