%% testing with two dimension

% Define the system
N = 5; % number of time steps
t = [1,2,3,4,5]; % time vector (s)

% random initial acceleration
acceleration = 2; %(8-4).*rand(5,1) + 4; %input = acceleration (m/s^2)

dt = 1; % Sampling time (s)
% t = dt*(1:N); % time vector (s)
F = [1, dt; 0, 1]; % system matrix - state
G = [1/2*dt^2; dt]; % system matrix - input
H = [1, 0; 0,1]; % observation matrix

Q = [0, 0; 0, 0]; % process noise covariance
I = eye(2); % identity matrix
% Define the initial position and velocity
y0 = 4000; % m
v0 = 280; % m/s

%observation input
xt = [ 4000, 280;  
       4260, 282; 
       4550, 285; 
       4860, 286; 
       5110, 290
];
xt = transpose(xt);

xt

pause;


%generate error in measurement
R_position = 4;
R_velocity = 2.5;
v_R = sqrt(R_position)*randn(1, N); % measurement noise for position
v_V = sqrt(R_velocity)*randn(1, N); % measurement noise for velocity
v = [v_R; v_V];

%compute for measurement input
z = H*xt ; % noisy measurement

%% Perform the Kalman filter estimation
% Initialize the state vector (estimated state)
x = zeros(2, N); % Estimated state vector
x(:, 1) = [4000; 280]; % Guess for initial state
% Initialize the covariance matrix
delta_Px = 20; % the stadard deviation of Position m
delta_Pv = 5; % the stadard deviation of Velocity m/s^2
P = [delta_Px^2, 0; 0, delta_Pv^2]; % Covariance for initial state error

% initialize of measurement noise covariance matrix/ observation error
% covaraince matrx
delta_x = 25; % m 
delta_v = 6; %m/s^2
% => measurement noise covariance matrix
R = [delta_x^2, 0; 0, delta_v^2];

% Loop through and perform the Kalman filter equations recursively
predicted_val = zeros(2, N);
predicted_val(:, 1 )= [4000; 280];

for k = 2:N
 % Predict the state vector
 x(:, k) = F*x(:, k-1) + G*acceleration;
 predicted_val(:, k ) = x(:, k) ;
 
 
 
 % Predict the covariance
 
 P = F*P*F' + Q;
 
 %P = [P(1,1),0; 0, P(2,2)];
 
 
 % Calculate the Kalman gain matrix
 K = P*H'/(H*P*H' + R);
 
 
 % Update the state vector
 
 x(:,k) = x(:,k) + K*(z(:,k) - H*x(:,k));
 
 % Update the covariance
 P = (I - K*H)*P;
 
end

%% Plot the results
% Plot the states
figure(1);
subplot(211);
plot(t, predicted_val(1,:), 'g-', t, x(1,:), 'b--', 'LineWidth', 2);
 hold on; plot(t, z(1,:), 'r:', 'LineWidth', 1.5)
xlabel('t (s)'); ylabel('x_1 = h (m)'); grid on;
legend('Predicted Value', 'Estimated','Measured');
subplot(212);
plot(t, predicted_val(2,:), 'g-', t, x(2,:), 'b--', 'LineWidth', 2);
 hold on; plot(t, z(2,:), 'r:', 'LineWidth', 1.5)
xlabel('t (s)'); ylabel('x_2 = v (m/s)'); grid on;
legend('Predicted Value', 'Estimated','Measured');


