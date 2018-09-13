function [slope, intercept] = line_equation(p1, p2)

    slope = (p1(1,2) - p2(1,2))/ (p1(1,1)-p2(1,1));
    intercept = (p1(1,2)- slope*p1(1,1));
%     stringname = strcat(num2str(slope),'X', '+', num2str(intercept)); 
   
end 