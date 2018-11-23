%% --- define the parameters (limit angle) specific for tilting

motor.home()
% motor.setSoftLimits(-60, 60)

% all the handles in one structure

% proj.translate(0,-20)
% handles.camera = camera;
% handles.proj = proj;
% handles.motor = motor;

%% launches the experiment

clc % clear command line

% chose the record path
recordpath= 'S:\Hugo\default\';

% creates the directory if possible
[s,mess,~] = mkdir(recordpath);
if strcmp(mess,'Directory already exists.')
    disp('please change the path or delete the existing folder')
    return
else    
    disp(['directory "' recordpath '" created'])
end

disp('      ___________________________________________________________')
disp('      |                                                         |')
disp('      |                                                         |')
disp('      |                  EXPERIMENT IN PROGRESS                 |')
disp('      |                                                         |')
disp('      |_________________________________________________________|')

% % % % % % % % % % % % protocol { type, duration (minutes), [options] }
repetitions = 1;        % number of times the protocol will be repeated
protocol = {
    
    'static', 1, {};  
    'rollFeedback', 1, {};
% % % % % % % % % % % % % % % % % % % % % % % % % % % %  end of protocol
    };

% save the protocol
save([recordpath 'protocol'], 'protocol', 'repetitions');

% main loop
h=tic;
for i=1:repetitions
    for j = 1:size(protocol, 1)
        exp = protocol{j,1};                            % type of experiment (static, retro, omr...)
        duration = protocol{j,2};                       % duration of experiment
        path = [recordpath int2str(i) '-' int2str(j) '-' exp];     % full path of file plus name. ex : D:\Hugo\2017-xx\1-3-static
        handles.StartTime = toc(h);                     % start time of experiment
        kwargs = protocol{j,3};                         % keyword arguments (speed, correct)
        % expCaller( exp, duration, path, handles, varargin )
        expCaller( exp, duration, path, handles, kwargs{:});
    end
end

% creates a figure to view the detail of the experiment and saves it
% view_experiment;
% 
% savefig([recordpath 'trace']);
% saveas(gcf,[recordpath 'trace.png']);

clc % clear command line

disp('      ___________________________________________________________')
disp('      |                                                         |')
disp('      |                  *                    *                 |')
disp('      |                    EXPERIMENT FINISHED                  |')
disp('      |                  *                    *                 |')
disp('      |_________________________________________________________|')


%% sample protocols

