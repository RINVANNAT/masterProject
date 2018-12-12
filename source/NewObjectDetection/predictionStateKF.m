function [x, P] = predictionStateKF(F_k, x_o, P_o, Q_k)

 x = F_k*x_o;
 P = F_k*P_o*transpose(F_k) + Q_k;
 
 
end