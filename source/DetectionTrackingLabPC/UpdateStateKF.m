function [K, P_o, x_o, estimated_value] = UpdateStateKF(I, mes_val, x, P, R_k, H_k, estimated_value)

     % Calculate the Kalman gain matrix
     cov_p_r =H_k*P*transpose(H_k) + R_k;
     K =  P * transpose(H_k) / (cov_p_r);
     % Update the state vector
     
     %--- update prediction from measurement---
        %---update state vector of prediction
        
        x_o =   x + K*( mes_val - H_k*x );
        
        estimated_value =[estimated_value,x_o] ;
        estimated_value(:,1) = [];
        % Update the covariance
        P_o = (I - K*H_k)*P;
    

end