function [x, estimated_value, P_o] = realKF(measurement, I, x_o, H_k, Q_k, F_k, R_k, P_o, x,estimated_value, k)


mes_val = (measurement);

    %% Perform the Kalman filter estimation
    % Initialize the state vector (estimated state)
%     x = zeros(8, n); % prediction state vector
%     x(:, 1) = x_o; % Guess for initial state
%     estimated_value = zeros(8, n);
    % Predict the state vector
     x(:, k) = F_k*x_o;
    
%      predicted_val(:, k ) = x(:, k) ;
     % Predict the covariance
     
     P = F_k*P_o*transpose(F_k) + Q_k;
%         P = [
%            P(1,1), 0, 0, 0;
%            0, P(2,2), 0, 0;
%            0, 0, P(3,3), 0;
%            0, 0, 0, P(4,4)
%         ];
     
     
     % Calculate the Kalman gain matrix
     cov_p_r =H_k*P*transpose(H_k) + R_k;
     K =  P * transpose(H_k) / (cov_p_r);
     % Update the state vector
     
     %--- update prediction from measurement---
        
        %---update state vector of prediction
%         xt(:,k) = xt(:,k) + [0; -5];
        x_o =   x(:,k) + K*( mes_val(:,k) - H_k*x(:,k) );
        estimated_value(:,k) = x_o;
        x_o
     
        % Update the covariance
        P_o = (I - K*H_k)*P;
%            P_o = [
%                P_o(1,1), 0, 0, 0;
%                0, P_o(2,2), 0, 0;
%                0, 0, P_o(3,3), 0;
%                0, 0, 0, P_o(4,4)
%            ];
    

    

end