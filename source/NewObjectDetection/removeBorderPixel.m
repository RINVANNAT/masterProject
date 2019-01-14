function [res, res1] = removeBorderPixel(edge, img, vanishingPoint, botPointLeft, botPointRight)

 [imgHeight, imgWidth]= size(img);
 res = zeros(imgHeight, imgWidth);
 res1 = zeros(imgHeight, imgWidth);
 startJIndex = ceil(botPointLeft(1,1));
 endJIndex = ceil(botPointRight(1,1));
 p1 = [vanishingPoint(1,1), vanishingPoint(1,2)-10];
 p2 = [botPointLeft(1,1)+65, botPointLeft(1,2)];
 p3 = [botPointRight(1,1)-60, botPointRight(1,2)];
     
     for i = ceil(vanishingPoint(1,2))+10 :imgHeight- 55 % throw y
       for j=startJIndex:endJIndex % throw x
           
           checkPoint = [j,i];
               trueValue = checkComponent(p3, p2, p1, checkPoint);
               if (trueValue == 1)
                    res(i,j)= img(i, j);
                    res1(i, j) = edge(i,j);
               end 
            
       end
                 
    end
     
     
end