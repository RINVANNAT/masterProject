function kalmanFiltering_1(xt, x_true, constructNewTrueValue)

I = eye(4);
x_o = [
    317;
    223;
    0;
    0
];
deltaT = 5;
H_k = [
    1, 0, 0, 0;
    0, 1, 0, 0
];

B_k = [
    0, 0;
    0, 0;
    1, 0;
    0, 1
 ];

W_k = [15; 20.5; 1.5; 1.5];
Q_k = W_k*transpose(W_k);
Q_k = [
    Q_k(1,1), 0, 0, 0;
    0, Q_k(2,2), 0, 0;
    0, 0, Q_k(3,3), 0;
    0, 0, 0, Q_k(4,4)
];
P_o = [
    16^2, 0, 0, 0;
    0, 25^2, 0, 0;
    0, 0, 1.5^2, 0;
    0, 0, 0, 1.5^2
];
F_k = [
    1, 0, deltaT, 0;
    0, 1, 0, deltaT;
    0, 0, 1, 0;
    0, 0, 0, 1
];
V_k = [4.3454; 37.1589];
R_k = V_k*transpose(V_k);
 R_k(1,2)=0;
 R_k(2,1)=0;
xt = transpose(xt);
n= length(xt);
t = (1:n);
    
R_k

    %compute for measurement input
%     z = H_k*xt ; % noisy measurement

    %% Perform the Kalman filter estimation
    % Initialize the state vector (estimated state)
    x = zeros(4, n); % prediction state vector
    x(:, 1) = x_o; % Guess for initial state
    estimated_value = zeros(4, n);
    

    % Loop through and perform the Kalman filter equations recursively
%     updated_state = zeros(2, 5);
%     predicted_val(:, 1 )= [Pox; Poy];


    for k = 1:n
     % Predict the state vector
     x(:, k) = F_k*x_o;
     
     pre = x(:,k);
    
%      predicted_val(:, k ) = x(:, k) ;
     % Predict the covariance
     
     P = F_k*P_o*transpose(F_k) + Q_k;
     P = [
        P(1,1), 0, 0, 0;
        0, P(2,2), 0, 0;
        0, 0, P(3,3), 0;
        0, 0, 0, P(4,4)
     ];
     P
     
     % Calculate the Kalman gain matrix
     cov_p_r =H_k*P*transpose(H_k) + R_k;
     cov_p_r
     K =  P * transpose(H_k) / (cov_p_r);
     K
     % Update the state vector
%      check =xt(:,k) - H_k*x(:,k)
     mes = xt(:,k)
     pre
     
     %--- update prediction from measurement---
        
        %---update state vector of prediction
        
        x_o =   x(:,k) + K*( xt(:,k) - H_k*x(:,k) );
        estimated_value(:,k) = x_o;
        x_o
     
        % Update the covariance
        P_o = (I - K*H_k)*P;
        P_o = [
            P_o(1,1), 0, 0, 0;
            0, P_o(2,2), 0, 0;
            0, 0, P_o(3,3), 0;
            0, 0, 0, P_o(4,4)
        ];
        P_o
    end
    

    %% Plot the results
    % Plot the states
    
    figure(1);
    subplot(211);
    plot(t, x(1,:), 'g-', t, x_true(:,1), 'b', 'LineWidth', 2);
    xlabel('t (Frames)'); ylabel('Position in x direction'); grid on;
    legend('Prediction-Value', 'True-Value');
    subplot(212);
    plot(t, x(2,:), 'g-', t, x_true(:,2), 'b', 'LineWidth', 2);
    xlabel('t (Frames)'); ylabel('Position in y direction'); grid on;
    legend('Prediction-Value', 'True-Value');
    
    
    figure(2);
    subplot(211);
    scatter(t,x(1,:), 'r','LineWidth', 2);
    hold on;
    scatter(t, x_true(:,1), 'b', 'LineWidth', 1);
    xlabel('t (Frames)'); ylabel('Position in x direction'); grid on;
    legend('Prediction-Value', 'True-Value');
    subplot(212);
    scatter(t,x(2,:), 'r','LineWidth', 2);
    hold on;
    scatter(t, x_true(:,2), 'b', 'LineWidth', 1);
    xlabel('t (Frames)'); ylabel('Position in y directioin'); grid on;
    legend('Prediction-Value', 'True-Value');
    
    
    
   figure(3);
    subplot(211);
    scatter(t,x(3,:), 'r','LineWidth', 2);
%     hold on;
%     scatter(t, constructNewTrueValue(3,:), 'b', 'LineWidth', 1);
    xlabel('t (Frames)'); ylabel('Velocity in x direction'); grid on;
    legend('Prediction-Value');
    subplot(212);
    scatter(t,x(4,:), 'r','LineWidth', 2);
%     hold on;
%     scatter(t, constructNewTrueValue(4,:), 'b', 'LineWidth', 1);
    xlabel('t (Frames)'); ylabel('Velocity in y directioin'); grid on;
    legend('Prediction-Value');
     x
    estimated_value
   
    xt
    x_true
   constructNewTrueValue
end