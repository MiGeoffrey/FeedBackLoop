function [output] = rollFeedback(params, handles)
%rollFeedback does a vestibular feedback on tail angle
% params.duration is the duration of the loop or the maximum duration if params.sleepTime is defined
% handles.vid,.vwriter,.motor are the handles

% memory allocation
Nimg = params.duration * 60 * 50;
TimeStamp = NaN(1,Nimg);
TailAngle = NaN(1,Nimg);
MotorAngle = NaN(1,Nimg);

% initialisation
n = 1;

stop(handles.camera.handle)    % makes sure that the vid object is stopped (optionnal)
start(handles.camera.handle)   %

% loop

tic;    % timer for the whole experiment

while toc < params.duration * 60
    [~, timeStamp, ex, theta] = Fish(handles.camera);    % gets the fish and timestamp
    
    writeVideo(handles.vwriter, uint8(ex)*255);
    TimeStamp(n) = timeStamp;
    TailAngle(n) = theta;
    MotorAngle(n) = handles.motor.readPos();
    
    handles.motor.setSpeed(theta * params.gain); % set the speed of the motor according to the tail angle
    
    n = n+1;
end


% stop
handles.motor.home()
stop(handles.camera.handle)

% save

TimeStamp = TimeStamp-TimeStamp(1);
TimeStamp(isnan(TimeStamp))=[]; % get rid of the unnecessary pre-allocated space
output.TimeStamp = TimeStamp;

TailAngle=TailAngle(1:length(TimeStamp)); % idem
output.TailAngle = TailAngle;

MotorAngle = MotorAngle(1:length(TimeStamp)); % idem
output.MotorAngle = MotorAngle;

end
