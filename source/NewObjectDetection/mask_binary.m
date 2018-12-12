function frame = mask_binary(img, p1, p2, p3, p4, vanishingPoint, propRight, propLeft, footCut)

[imgHeight, imgWidth] = size(img);
sub_result = zeros(size(img, 1), size(img, 2));

if p3(1,2) < p2(1,2)
    minY = p3(1,2);
    if p2(1,2) >= imgHeight
        [monitorSlope, monitorIntercept] = line_equation( [0, p3(1,2)], p3);
        [monitorPointX, monitorPointY] = compute_interception_point(propLeft, [monitorSlope, monitorIntercept]);
        startJIndex = ceil(p2(1,1));
        endJIndex = imgWidth;
        PointToMonitor = [ceil(p2(1,1)), p3(1,2)];
        pointA_ = ceil(p2);
        
        
    else
        [monitorSlope, monitorIntercept] = line_equation( [0, p3(1,2)], p3);
        [monitorPointX, monitorPointY] = compute_interception_point(propLeft, [monitorSlope, monitorIntercept]);
        startJIndex = 1;
        endJIndex = imgWidth;
        PointToMonitor = [0, p3(1,2)];
        pointA_ = ceil(p2);
        
    end
   
    
else
   minY = p2(1,2);
   
   if p3(1,2) >= imgHeight
       [monitorSlope, monitorIntercept] = line_equation( [imgWidth, p2(1,2)], p2);
       [monitorPointX, monitorPointY] = compute_interception_point(propRight, [monitorSlope, monitorIntercept]);
       startJIndex = 1;
       endJIndex = ceil(p3(1,1));
       PointToMonitor = [ceil(p3(1,1)), p2(1,2)]; 
       pointA_ = ceil(p3);
       
       
   else
       
       [monitorSlope, monitorIntercept] = line_equation( [imgWidth, p2(1,2)], p2);
       [monitorPointX, monitorPointY] = compute_interception_point(propRight, [monitorSlope, monitorIntercept]);
        startJIndex = 1;
        endJIndex = imgWidth;
        PointToMonitor = [imgWidth, p2(1,2)];
        pointA_ = ceil(p3);
   end
end

%   imshow(img);
%    hold on
%    xy1 = [p1; p3];
%    xy2 = [p1; p2];
%    xy3 = [p3; p2];
%    xx = [[0,imgHeight-50]; [imgWidth, imgHeight-50]];
%    
%    plot(xy1(:,1),xy1(:,2),'LineWidth',2,'Color','green');
%    plot(xy2(:,1),xy2(:,2),'LineWidth',2,'Color','green');
% %    plot(xy3(:,1),xy3(:,2),'LineWidth',2,'Color','green');
%    plot(xx(:,1),xx(:,2),'LineWidth',2,'Color','green');
%    
%    pause;
%  % imshow(img); hold on
%  % xy1 = [p1; p3];
%  % xy2 = [p1; p2];
%   xy4 = [p3; PointToMonitor];
%  % plot(xy1(:,1),xy1(:,2),'LineWidth',2,'Color','green');
%  % plot(xy2(:,1),xy2(:,2),'LineWidth',2,'Color','green');
%   plot(xy4(:,1),xy4(:,2),'LineWidth',2,'Color','green');
%   plot(monitorPointX,monitorPointY,'x','LineWidth',2,'Color','yellow');
%   plot(PointToMonitor(1,1), PointToMonitor(1,2),'x','LineWidth',2,'Color','red');
%   
%  

    
   for i= ceil(vanishingPoint(1,2))-5 :size(img, 1)- footCut % throw y
       for j=startJIndex:endJIndex % throw x
           
           if i <= minY
               
               checkPoint = [j,i];
               trueValue = checkComponent(p3, p2, p1, checkPoint);
               if (trueValue == 1)
                   sub_result(i, j) = 1 ;
               end 
           else
               checkPoint_ = [j,i];
               trueValue_ = checkComponent(PointToMonitor, pointA_, [monitorPointX, monitorPointY], checkPoint_);
               if (trueValue_ ~= 1)
                    sub_result(i, j) = 1 ;
               end
               
           end
            
        end
                 
   end
   
    frame = (sub_result);
    
%     class(frame)
    
    
    
  
    
end
