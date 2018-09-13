function reference_point = find_intersection()
    clear all
    clear clc
    
    array_refpoint = zeros(1,2);
    
tic
    for  i = 1:1
        
        filename = strcat(num2str(i), '.jpg'); 
%        path_file = strcat('/Users/mac/Documents/MATLAB/pic/', filename);
%         filename = strcat('frame', num2str(i), '.jpg'); 
        path_file = strcat('/Users/mac/Documents/exp_pics/', filename);
      

%       filename = strcat('frame', num2str(i), '.jpg'); 
%        path_file = strcat('/Users/mac/Documents/MATLAB/frame_diff/', filename);
       
       intersections = zeros(2, 1);
      frame = imread(path_file);
      frame = rgb2gray(frame);    
      frame = crop_front_car_area(frame);
      lines = houghLines(frame);
        figure, imshow(frame), hold on
%         plot_hough_lines(lines, frame); 
      
     
       
      height = size(frame,1);
      width = size(frame,2);
      pos1 = (2*width)/7;
      pos2 = height/4;
      pos3 = (5*width)/7 - (2*width)/7;
      pos4 = (3*height)/4 -height/4 ;
      pos = [pos1 pos2 pos3 pos4];
%        boxBounding(pos, frame);


       
      for iindex=1: (length(lines)-1)
           [slope1, intercept1] = line_equation(lines(iindex).point1, lines(iindex).point2);
           for jindex=(iindex +1):length(lines)
               [slope2, intercept2] = line_equation(lines(jindex).point1, lines(jindex).point2);
               [x_intercept, y_intercept] = compute_interception_point([slope1, intercept1], [slope2, intercept2]);
               intersections = [ intersections, [x_intercept; y_intercept] ];
           end
      end
      intersections(:, 1) = []; % remove first element from array
      reference_point  = compute_final_centroid(transpose(intersections), frame);
     
%       plot_intersect_points(intersections);

            
       
       plot( 621,366,'x','LineWidth',8,'Color','green');
       plot( reference_point(1,1),reference_point(1,2),'x','LineWidth',8,'Color','red')
       array_refpoint = [array_refpoint; reference_point ];
    end
    
    array_refpoint(1,:) = []; 
    finding_error(array_refpoint, [621, 366]);% mean1 : [621, 366], mean2: [579, 358], mean3: [680, 206], mean4: [655, 195]
      
    toc
end
