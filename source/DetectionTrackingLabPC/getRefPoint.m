function [reference_point, RightLine, leftLine, frame_] = getRefPoint(frame) % grayscale image frame 
    frame_ = frame;
    intersections = zeros(2, 1);
    lines = houghLines(frame); % perform-hough-tranformation # Hough-Peak = 25; LineWidth: 150
    
    
    height = size(frame,1);
    width = size(frame,2);
    baseP1 = [1, height];
    baseP2 = [width, height];
    
    
    first_point = lines(1).point1;
    minDis1 = sqrt(  (first_point(1,1) - baseP1(1,1))^2 + (first_point(1,2) - baseP1(1,2))^2 );
    final_point1 = first_point;
    final_point2 = first_point;
    minDis2 = sqrt(  (first_point(1,1) - baseP2(1,1))^2 + (first_point(1,2) - baseP2(1,2))^2 );
    
    leftLine = [];
    RightLine =[];
    
    
 
    % ------ main loop for calculating interception-----%
    for iindex = 1: (length(lines)-1)
        
           if lines(iindex).point1(1,1) < width/2 && lines(iindex).point2(1,1) < width/2
               leftLine = lines(iindex);
           end
           if lines(iindex).point1(1,1) > width/2 && lines(iindex).point2(1,1) > width/2
               RightLine = lines(iindex);
           end
           
           [slope1, intercept1] = line_equation(lines(iindex).point1, lines(iindex).point2);    
           for jindex=(iindex +1):length(lines)
               
               
               if lines(jindex).point1(1,1) < width/2 && lines(jindex).point2(1,1) < width/2
               leftLine = lines(jindex);
               end
               if lines(jindex).point1(1,1) > width/2 && lines(jindex).point2(1,1) > width/2
                   RightLine = lines(jindex);
               end
               [slope2, intercept2] = line_equation(lines(jindex).point1, lines(jindex).point2);
               [x_intercept, y_intercept] = compute_interception_point([slope1, intercept1], [slope2, intercept2]);
               intersections = [ intersections, [x_intercept; y_intercept] ];
           end
           
%            eachDis1 = sqrt(  (lines(iindex+1).point1(1,1) - baseP1(1,1))^2 + (lines(iindex+1).point1(1,2) - baseP1(1,2))^2 );
%            eachDis2 = sqrt(  (lines(iindex+1).point2(1,1) - baseP2(1,1))^2 + (lines(iindex+1).point2(1,2) - baseP2(1,2))^2 );
%            if minDis1 > eachDis1
%                minDis1 = eachDis1;
%                final_point1 = lines(iindex+1).point1;
%            end
%            
%            if minDis2 > eachDis2
%                minDis2 = eachDis2;
%                final_point2 = lines(iindex+1).point2;
%            end
           
          
    end
    intersections(:, 1) = []; % remove first element from array
    reference_point  = compute_final_centroid(transpose(intersections), frame);
%     [frame_, point] = remove_non_roi(frame, reference_point);
    
%       plot_hough_lines(lines, frame); 

%     imshow(mat);
%      hold on 
%       plot_intersect_points(intersections);
% %     
%       plot( reference_point(1,1),reference_point(1,2),'x','LineWidth',8,'Color','blue');
%      pause;
     
%      plot( baseP2(1,1),baseP2(1,2),'x','LineWidth',8,'Color','green');
%      plot( baseP1(1,1),baseP1(1,2),'x','LineWidth',8,'Color','blue');
%      plot( final_point1(1,1),final_point1(1,2),'x','LineWidth',8,'Color','black');
%      plot( final_point2(1,1),final_point2(1,2),'x','LineWidth',8,'Color','black');
    
       
end
