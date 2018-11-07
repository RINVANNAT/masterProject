function [x_intercept, y_intercept] = compute_interception_point(prop1, prop2) 

% prop1 : has slope and intercept of line equation
% equation1 = strcat('Y', '=', num2str(prop1(1,1)),'X', '+', num2str(prop1(1,2))); 
% equation2 = strcat('Y', '=', num2str(prop2(1,1)),'X', '+', num2str(prop2(1,2)));
tourX = prop1(1,1) - prop2(1,1);
tourB = prop1(1,2) - prop2(1,2);
x_intercept = -(tourB)/tourX;
y_intercept = prop2(1,1) * x_intercept + prop2(1,2);



end
