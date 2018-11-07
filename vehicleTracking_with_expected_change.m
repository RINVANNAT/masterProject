function vehicleTracking_with_expected_change()

close all;
clear all;
clc;
%% testing with two dimension

% Define the system
N = 28; % number of time steps
t = 1:28; % time vector (s)


dt = 4/15; % Sampling time (s)
% t = dt*(1:N); % time vector (s)
F = [ 
       1, 0, dt, 0;
       0, 1, 0, dt;
       0, 0, 1, 0
       0, 0, 0, 1
    
    ]; % system matrix - state

H = eye(4);
B_t = eye(4);
U_o = [0;0;0;0];
% H = [
%         1, 0, 0, 0; 
%         0, 1, 0, 0;
%      ]; % observation matrix
Q = [   0, 0, 0, 0;
        0, 0, 0, 0;
        0, 0, 0, 0;
        0, 0, 0, 0
        ]; % process noise covariance
    
I = eye(4); % identity matrix
% Define the initial position and velocity                              
Pox = 308; % position in x direction
Poy = 238; % position in y 

%observation input
xt = [ 
          304  242 0 0;
          305  242 0 0;
          305  242 0 0;
          306  242 0 0;
          305  242 0 0;
          305  242 0 0;
          306  241 0 0;
          306  240 0 0;
          305  240 0 0;
          305  239 0 0;
          306  238 0 0;
          305  239 0 0;
          306  239 0 0;
          307  239 0 0;
          306  239 0 0;
          307  240 0 0;
          307  240 0 0;
          308  240 0 0;
          309  239 0 0;
          309  240 0 0;
          308  240 0 0;
          308  239 0 0;
          310  238 0 0;
          308  238 0 0;
          310  239 0 0;
          310  239 0 0;
          310  238 0 0;
          309  240 0 0;
      ];

 xt = transpose(xt);

% uncertainty matric associated with a noisy set of measurement
deltaPox = 4;
deltaPoy = 4;
R = [   
        16, 0, 0, 0;
        0, 16, 0, 0;
        0, 0, 16, 0;
        0, 0, 0, 16
     ];

% process error in process covariance matrice
deltaPx = 7; % the stadard deviation of Position in x direction
deltaPy = 7; % the stadard deviation of Position in y direction


%compute for measurement input

z = H * xt; % noisy measurement

%% Perform the Kalman filter estimation
% Initialize the state vector (estimated state)
x = zeros(4, N); % Estimated state vector
x(:, 1) = [ Pox; Poy; 4/15 ; 4/15 ]; % Guess for initial statex

% Initialize the covariance matrix
P = [   
        deltaPx^2, 0, 0, 0;
        0, deltaPy^2, 0, 0;
        0, 0, 0, 0;
        0, 0, 0, 0
     ]; % Covariance for initial state error

% Loop through and perform the Kalman filter equations recursively
predicted_val = zeros(4, N);
predicted_val(:, 1 )= [Pox; Poy; 0; 0];

for k = 2:N
 % Predict the state vector
 x(:, k) = F*x(:, k-1) + B_t*U_o;

 predicted_val(:, k ) = x(:, k) ;
 
 
 
 % Predict the covariance
 
 P = F*P*F' + Q;
 
 %P = [P(1,1),0; 0, P(2,2)];
 
 
 % Calculate the Kalman gain matrix
 
 K = P*H'/(H*P*H' + R);
 K
 
 % Update the state vector

 pred = x(:,k);
 pred
 U_o = z(:,k) - z(:,k-1);
 x(:,k) = x(:,k) + K*(z(:,k) - H*x(:,k));

 update = x(:,k);
 
 update
 % Update the covariance
 P = (I - K*H)*P;
 
 
end

%% Plot the results



for i=1: length(x)
    es = x(:,i);
    pre = predicted_val(:,i);
    mes = z(:, i);
    plot(es(1),es(2),'x','LineWidth',2,'Color','red');hold on
    plot(pre(1),pre(2),'x','LineWidth',1,'Color','green'); hold on
    plot(mes(1),mes(2),'x','LineWidth',1,'Color','blue'); hold on
end
xlabel('X'); ylabel('Y'); grid on;
legend('Estimated','Predicted', 'Measured');

z
(predicted_val)

(x)


figure();

% Plot the states
   figure(1);
   subplot(211);
   plot(t, (predicted_val(1,:)), 'g-', t, (x(1,:)), 'b--', 'LineWidth', 2);
    hold on; plot(t, z(1,:), 'r:', 'LineWidth', 1.5)
   xlabel('t (s)'); ylabel('position in x direction =  (m)'); grid on;
   legend('Predicted Value', 'Estimated','Measured');
   subplot(212);
   plot(t, (predicted_val(2,:)), 'g-', t, (x(2,:)), 'b--', 'LineWidth', 2);
    hold on; plot(t, z(2,:), 'r:', 'LineWidth', 1.5)
   xlabel('t (s)'); ylabel('position in y direction = (m)'); grid on;
   legend('Predicted Value', 'Estimated','Measured');




end
