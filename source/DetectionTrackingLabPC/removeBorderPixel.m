function [res1, res2] = removeBorderPixel(resEdge, triDiff, vanishingPoint, botLelfPoint, botRightPoit)

 [imgHeight, imgWidth]= size(triDiff);
 res1 = zeros(imgHeight, imgWidth);
 res2 = zeros(imgHeight, imgWidth);
 startJIndex = ceil(botLelfPoint(1,1));
 endJIndex = ceil(botRightPoit(1,1));
 p1 = vanishingPoint;
 p2 = [botLelfPoint(1,1), botLelfPoint(1,2)];
 p3 = [botRightPoit(1,1), botRightPoit(1,2)];
 for i= ceil(vanishingPoint(1,2)) :imgHeight - 55 % throw y
   for j=startJIndex:endJIndex % throw x
       checkPoint = [j,i];
       trueValue = checkComponent(p3, p2, p1, checkPoint);
       if (trueValue == 1)
            res1(i,j)= triDiff(i, j);
            res2(i, j) = resEdge(i,j);
       end
   end     
 end
     
     
   
     
end