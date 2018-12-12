function removeBorderPixel(img)

 [imgHeight, imgWidth]= size(I1);
     res = zeros(imgHeight, imgWidth);
     res1 = zeros(imgHeight, imgWidth);
     
     
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
%            con=3
            minY = p2(1,2);
           [monitorSlope, monitorIntercept] = line_equation( [imgWidth, p2(1,2)], p2);
           [monitorPointX, monitorPointY] = compute_interception_point(propRight, [monitorSlope, monitorIntercept]);
           startJIndex = ceil(p2(1,1));
           endJIndex = ceil(p3(1,1));
           PointToMonitor = [ceil(p3(1,1)), p2(1,2)]; 
           pointA_ = ceil(p3);
           p2 = [p2(1,1)+ 25, p2(1,2)];
           p3 = [p3(1,1)- 7, p3(1,2)];
           p1 = [p1(1,1), p1(1,2)+ 10];


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
                    res1(i, j) = resEdge(i,j);
               end 
           else
               checkPoint_ = [j,i];
               trueValue_ = checkComponent(PointToMonitor, [pointA_(1,1), pointA_(1,2)], [monitorPointX-10, monitorPointY], checkPoint_);
               if (trueValue_ ~= 1)
                     res(i,j)= I1(i, j);
                     res1(i, j) = resEdge(i,j);
               end
               
           end
            
       end
                 
    end

     mat = res;
     mat1 = res1;
end