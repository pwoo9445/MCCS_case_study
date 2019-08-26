%==========================================================================
%   TP :            Case study: Exercse 4
%   Contact:        ezequiel.gonzalezdebada@epfl.ch
%==========================================================================
classdef solEx4
    %Class gathering the solutions of exercise 4. 
    methods(Static)
        %
        function varargout = select_reference_path
            % OUTPUT = select_reference_path returns a string with the name
            % of the mat file containing the path to be tracked that is
            % wanted to be used. 
            options = {'circle', 'path_1', 'path_2', 'path_3'};
            varargout = {options{4}};
        end   
        %
        function varargout = getSystemParameters
            % PARAMETERS = getSystemParameters() returns a 5-elements
            % column vector PARAMETERS containing the parameters value
            % characterizing the system and the linearization point.
            % Specifically it should contain (in the presented order):
            %   - k : vlue of the reference curvature. 
            %   - car_length : length of the car in meters.  
            %   - sigma_a : sigma_a characterizing the dynamic of the
            %   actuator tracking the inputed acceleration. 
            %   - sigma_S : sigma_s characterizing the dynamic of the
            %   actuator tracking the inputed reference speed. 
            %   - spReg : value of the speed reference. 
            parameters = zeros(5,1);
            %
            parameters(1) = 0.1; %not relevant in exercise 3
            parameters(2) = 4;
            %
            parameters(3) = 5;
            parameters(4) = 2;
            %
            parameters(5) = 3;
            
            varargout = {parameters};
        end  
        %
        function varargout = getInitialState
            %[X0] = getInitialState(NOMINAL_TRAJECTORY_X)
            % returns the initial state X0 of the non linear system given
            % the information on the exercise handout and the 
            % NOMINAL_TRAJECTORY_X.
            %
            % The outputs should be column vectors. 
            x0 = zeros(5,1);
            varargout = {x0};
        end       
        %
        function varargout = getObstaclePosition
            % [OBSTACLE_POSITION] = getObstacle()
            % returns a row vector showing the OBSTACLE_POSITION (in
            % cartasian coordinates) that is to be taken into account. 
            % 
            % You can freely set the position of the obstacle. 
            
            varargout = {[]};
            
            %SOLUTION
            %varargout = {[0,82]}; %circle
            varargout = {[-40,80]}; %path_1
            varargout = {[0,25]}; %path_2
            varargout = {[0,25]}; %path_2
            varargout = {[20,50]}; %path_4
            
        end
        %
        function varargout = getAttractiveField
            % ATTRACTIVE_FIELD = getAttractiveField()
            % returns a handle to an anonymus function that returns the
            % value of the attractive term of the artificial potential
            % field as a function of x_1, x_2. 
            % 
            % Notice that the function must be written in such a way that
            % column vectors are accepted as inputs.
            %
            % We propose an attractive field of the form 
            % attractive_field(x1,x2) = 40 x1 + 1000 exp( -x2^2/(2*7^2))
            % which includes a term pushing the car forward, and a second
            % one attracting it to the center of the lane (with a
            % gaussian-shaped function. 
            % Even though a function is proposed, you are free to change
            % the function and/or the value of its parameters. 
            varargout = {@(s,d)s.*0}; 
            
            %SOLUTION
            sigma_da = 7;
            B = 1000;
            attractive_field = @(s,d)40.*s + B .* exp(-(d).^2/(2*sigma_da^2));
            varargout = {attractive_field};
        end
        %
        function varargout = getRepulsiveField(s_d_obstacle_coordinates)
            % REPULSIVE_FIELD =
            % getAttractiveField(S_D_OBSTACLE_COORDINATES) returns a handle
            % to an anonymus function that returns the value of the
            % repulsive term of the artificial potential field as a
            % function of x_1, x_2 and the position of the static obstacle
            % to be taken into account.
            % 
            % Notice that the function must be written in such a way that
            % column vectors are accepted as inputs.
            %
            % We propose a repulsive field which takes the form of a 3D
            % gaussian function as follows: 
            % REPULSIVE_FIELD(x1,x2) = 8000 exp( - (  (s-s_obstacle_coordinates)^2/(2*15^2) + (d-d_obstacle_coordinates)^2/(2*4^2)) )
            % Even though a function is proposed, you are free to change
            % the function and/or the value of its parameters. 
            varargout = {@(s,d)s.*0};
            
            %SOLUTION
            A = 8000;
            sigma_s = 15;
            sigma_d = 4;
            repulsive_field = @(s,d)A.*exp( - (  (s-s_d_obstacle_coordinates(1)).^2/(2*sigma_s^2) + (d-s_d_obstacle_coordinates(2)).^2/(2*(sigma_d)^2)) );
            varargout = {repulsive_field};
        end
        %        
        function varargout = calculateGradient(potential_field, s, d)
            % [fs,fd] = calculateGradient(POTENTIAL_FIELD, S, D) returns
            % the gradient of the POTENTIAL_FIELD function along s and d
            % coordinates approximated numerically. S and D inputs
            % are the vectors w.r.t. whcih the potential_field array was
            % created. 
            %
            % To calculate the numerical gradient of the function, use the
            % Matlab function GRADIENT.
            [fs,fd] = gradient(potential_field, s, d);
            varargout = {fs,fd};
        end
        %
    end
end

