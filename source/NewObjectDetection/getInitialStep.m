function [sPL, ePL, sPR, ePR, x_intercept, y_intercept, botEndPR, botIntx, botInty] = getInitialStep(mean_point, frame1) 





%        sPL = [0, 490]; %startPointLeft% 
%        ePL = [ceil(mean_point(1,1)), ceil(mean_point(1,2)) ]; %endPointLeft 
%        sPR = [1040, size(frame1, 1)-50]; %startPointRight 
%        ePR = [ceil(mean_point(1,1)), ceil(mean_point(1,2))]; % endPointRight
%        botEndPR = [size(frame1, 2), 280];
%       [slope1, intercept1] = line_equation( sPL, ePL);
%       [slope2, intercept2] = line_equation( sPR, ePR);
%       [x_intercept, y_intercept] = compute_interception_point([slope1, intercept1], [slope2, intercept2]);
%       
%       [botSlope1, botIntercept1] = line_equation( sPL, botEndPR);
%       [botIntx, botInty] = compute_interception_point([botSlope1, botIntercept1], [slope2, intercept2]);

%==========================================
         sPL = [0, ceil(mean_point(1,2)) + 50]; %startPointLeft% 
         ePL = [ceil(mean_point(1,1))-10, ceil(mean_point(1,2))-10 ]; %endPointLeft 
         sPR = [size(frame1, 2), ceil(mean_point(1,2)) + 50]; %startPointRight 
         ePR = [ceil(mean_point(1,1))+10, ceil(mean_point(1,2))-10]; % endPointRight
         botEndPR = [size(frame1, 2), 280];
        [slope1, intercept1] = line_equation( sPL, ePL);
        [slope2, intercept2] = line_equation( sPR, ePR);
        [x_intercept, y_intercept] = compute_interception_point([slope1, intercept1], [slope2, intercept2]);
        
        [botSlope1, botIntercept1] = line_equation( sPL, botEndPR);
        [botIntx, botInty] = compute_interception_point([botSlope1, botIntercept1], [slope2, intercept2]);
%================================another init step 



%         sPL = [130, 310]; %startPointLeft% 
%         ePL = [ceil(mean_point(1,1))-50, ceil(mean_point(1,2)) ]; %endPointLeft 
%         sPR = [size(frame1, 2), size(frame1, 1)-50]; %startPointRight 
%         ePR = [ceil(mean_point(1,1))-50, ceil(mean_point(1,2))]; % endPointRight
%         botEndPR = [size(frame1, 2), 280];
%        [slope1, intercept1] = line_equation( sPL, ePL);
%        [slope2, intercept2] = line_equation( sPR, ePR);
%        [x_intercept, y_intercept] = compute_interception_point([slope1, intercept1], [slope2, intercept2]);
%        
%        [botSlope1, botIntercept1] = line_equation( sPL, botEndPR);
%        [botIntx, botInty] = compute_interception_point([botSlope1, botIntercept1], [slope2, intercept2]);
end















