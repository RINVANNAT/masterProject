function [I, x_o, H_k, Q_k, F_k, R_k, P_o] = setUpParametersKF()


I = eye(8);
x_o = [
    310;
    233;
    65;
    38
    0;
    0;
    0;
    0
];
deltaT = 0.2;
H_k = [
    1, 0, 0, 0, 0, 0, 0, 0
    0, 1, 0, 0, 0, 0, 0, 0
    0, 0, 1, 0, 0, 0, 0, 0
    0, 0, 0, 1, 0, 0, 0, 0
];

W_k = [15; 10.5; 12.5; 13.5; 2.5; 2.5; 1.5; 1.75];
Q_k = W_k*transpose(W_k);

Q_k = [
    Q_k(1,1), 0, 0, 0, 0, 0, 0, 0;
    
    0, Q_k(2,2), 0, 0, 0, 0, 0, 0;
    
    0, 0, Q_k(3,3), 0, 0, 0, 0, 0;
    
    0, 0, 0, Q_k(4,4), 0, 0, 0, 0;
    
    0, 0, 0, 0, Q_k(5,5), 0, 0, 0;
    
    0, 0, 0, 0, 0, Q_k(6,6), 0, 0;
    
    0, 0, 0, 0, 0, 0, Q_k(7,7), 0;
    
    0, 0, 0, 0, 0, 0, 0, Q_k(8,8)
];
P_o = [
    12^2, 0, 0, 0, 0, 0, 0, 0;
    0, 15^2, 0, 0, 0, 0, 0, 0;
    0, 0, 12^2, 0, 0, 0, 0, 0;
    0, 0, 0, 11^2, 0, 0, 0, 0;
    0, 0, 0, 0, 3^2, 0, 0, 0;
    0, 0, 0, 0, 0, 3^2, 0, 0;
    0, 0, 0, 0, 0, 0, 2.5^2, 0;
    0, 0, 0, 0, 0, 0, 0, 2^2;
];
F_k = [
    1, 0, 0, 0, deltaT, 0, 0, 0;
    0, 1, 0, 0, 0, deltaT, 0, 0;
    0, 0, 1, 0, 0, 0, deltaT, 0;
    0, 0, 0, 1, 0, 0, 0, deltaT;
    0, 0, 0, 0, 1, 0, 0, 0;
    0, 0, 0, 0, 0, 1, 0, 0;
    0, 0, 0, 0, 0, 0, 1, 0;
    0, 0, 0, 0, 0, 0, 0, 1
];
V_k = [10.3454; 7.1589; 9.32; 8.83];
R_k = V_k*transpose(V_k);
R_k = [
    R_k(1,1), 0, 0, 0;
    0, R_k(2,2), 0, 0;
    0, 0, R_k(3,3), 0;
    0, 0, 0, R_k(4,4)
];


end