function mat = hello(I1, vanishingPoint, p1,p2,p3,p4, propRight, propLeft)

     [imgHeight, imgWidth]= size(I1);
     res = zeros(imgHeight, imgWidth);
     alternatePoint = [ ceil(vanishingPoint(1,1)), ceil(vanishingPoint(1,2))+5];
     
     
%       imshow(I1);
%       figure();
%       hold on
%      plot( p2(1, 1), p2(1,2), 'c*', 'LineWidth',4, 'Color','magenta');
%        plot( p3(1, 1), p3(1,2), 'c*', 'LineWidth',4, 'Color','red');
%      figure();
     
%       
%      
%      
%      for i = (ceil(vanishingPoint(1,2)) -10) : height-51
%          for j=5:width-5
%              if  I1(i,j) >= 0.02
%                  if i <= p2(1,2) 
%                      
%                    checkPoint = [j,i];
%                    trueValue = checkComponent(p3, p2, alternatePoint, checkPoint);
%                    if (trueValue == 1)
%                        res(i,j)= I1(i, j);
%                    else
% %                        if (p4(1,1) ~= 0) || (p4(1,2) ~= 0)
% %                            trueValue_ = checkComponent(p4, p2, p3, checkPoint);
% %                            if (trueValue_ == 1)
% %                                res(i,j)= I1(i, j);
% %                            end
% %                        end
% 
%                    end
%                    
%                  else
%                      res(i,j)= I1(i, j);
%                  end
%                  
%              end
%            
%          end
%      end
     
     
     
     
     
     
     
     
     
     if p3(1,2) < p2(1,2)
        minY = p3(1,2);
        if p2(1,2) >= imgHeight
            con=1
            [monitorSlope, monitorIntercept] = line_equation( [0, p3(1,2)], p3);
            [monitorPointX, monitorPointY] = compute_interception_point(propLeft, [monitorSlope, monitorIntercept]);
            startJIndex = ceil(p2(1,1));
            endJIndex = imgWidth-10;
            PointToMonitor = [ceil(p2(1,1)), p3(1,2)];
            pointA_ = ceil(p2);


        else
            con=2
            [monitorSlope, monitorIntercept] = line_equation( [0, p3(1,2)], p3);
            [monitorPointX, monitorPointY] = compute_interception_point(propLeft, [monitorSlope, monitorIntercept]);
            startJIndex = 5;
            endJIndex = imgWidth-10;
            PointToMonitor = [0, p3(1,2)];
            pointA_ = ceil(p2);

        end


    else
       minY = p2(1,2)+10;

       if p3(1,2) >= imgHeight
           con=3
           [monitorSlope, monitorIntercept] = line_equation( [imgWidth, p2(1,2)], p2);
           [monitorPointX, monitorPointY] = compute_interception_point(propRight, [monitorSlope, monitorIntercept]);
           startJIndex = 5;
           endJIndex = ceil(p3(1,1));
           PointToMonitor = [ceil(p3(1,1)), p2(1,2)]; 
           pointA_ = ceil(p3);


       else
%            con=4

           [monitorSlope, monitorIntercept] = line_equation( [imgWidth, p2(1,2)], p2);
           [monitorPointX, monitorPointY] = compute_interception_point(propRight, [monitorSlope, monitorIntercept]);
            startJIndex = 15;
            endJIndex = imgWidth-10;
            PointToMonitor = [imgWidth, p2(1,2)];
            pointA_ = ceil(p3);
            p2 = [p2(1,1)+ 20, p2(1,2)+10];
            p3 = [p3(1,1)- 15, p3(1,2)];
            p1 = [p1(1,1), p1(1,2)+ 5];
       end
     end
    
     
     for i= ceil(vanishingPoint(1,2)) :size(I1, 1)- 55 % throw y
       for j=startJIndex:endJIndex % throw x
           
           if i <= minY
               
               checkPoint = [j,i];
               trueValue = checkComponent(p3, p2, p1, checkPoint);
               if (trueValue == 1)
                    res(i,j)= I1(i, j);
               end 
           else
               checkPoint_ = [j,i];
               trueValue_ = checkComponent(PointToMonitor, [pointA_(1,1), pointA_(1,2)+10], [monitorPointX-10, monitorPointY], checkPoint_);
               if (trueValue_ ~= 1)
                     res(i,j)= I1(i, j);
               end
               
           end
            
       end
                 
    end

     mat = res;
%      
%       imshow(mat);
%       hold on
%       plot(p1(1,1),p1(1,2),'x','LineWidth',2,'Color','red');
%       plot(p2(1,1),p2(1,2),'x','LineWidth',2,'Color','green');
%       plot(p3(1,1),p3(1,2),'x','LineWidth',2,'Color','yellow');
%       
%       pause;
    
end