classdef Soloist < Motor
    %AerotechSoloist subclass of motor for the communication with the AerotechSoloist motor
    % make sure the path is added : 
    % addpath('C:\Program Files (x86)\Aerotech\Soloist\Matlab\x64');
    
    properties
        defaultSpeed
    end
    
    methods
        function obj = Soloist()
            %AerotechSoloist contructor : inits the communication with the motor
            disp('Connecting to the Soloist motor.')
            obj.handle = SoloistConnect;
            obj.defaultSettings()
        end
        
        function defaultSettings(obj)
            disp('Enabling and homing the axis.')
            SoloistMotionEnable(obj.handle)
            obj.home();
            obj.defaultSpeed = 10; % speed of movement to a certain point
        end
        
        function setSoftLimits(obj, min, max)
            % TODO
        end
        
        % --- the following functions could be generalized to the motor
        
        function moveAbs(obj, angle)
            SoloistMotionMoveAbs(obj.handle, angle, obj.defaultSpeed)
        end
        
        function moveRel(obj, angle)
            SoloistMotionMoveInc(obj.handle, angle, obj.defaultSpeed)
        end
        
        function setSpeed(obj, speed)
            SoloistMotionFreeRun(obj.handle, speed)
        end
        
        function startProgram(obj)
            % start program loaded in task 1
            SoloistProgramStart( obj.handle, 1 )
        end
        
        function stop(obj)
            SoloistMotionAbort(obj.handle)
        end
        
        function home(obj)
            obj.moveAbs(0)
        end
        
        function pow(obj, state)
            % disable the motor axis (or enable it if 'true' as argument)
            if ~exist('state', 'var')
                state = false;
            end
            if state
                SoloistMotionEnable(obj.handle)
            else
                SoloistMotionDisable(obj.handle)
            end
        end
        
        function setZero(obj)
            % todo
        end
            
        function pos = readPos(obj)
            pos = SoloistStatusGetItem(obj.handle, SoloistStatusItem.PositionFeedback);
        end
        
        % --- this function reads a text file and programs the motor
        function program(obj, file)
            % load file.ab in task 1
            SoloistProgramLoad(obj.handle, 1, file)
        end
    end   
end
