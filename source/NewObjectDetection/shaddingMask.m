function sub_result = shaddingMask(p1, p2, p3, vanishingPoint, img, bottomTheshold)

startJIndex = ceil(p2(1,1));
endJIndex = ceil(p3(1,1));
[imgHeight, imgWidth] = size(img);
sub_result = zeros(imgHeight, imgWidth);

    for i= ceil(vanishingPoint(1,2)) :(imgHeight - bottomTheshold) % throw y
           for j=startJIndex:endJIndex % throw x
               checkPoint = [j,i];
                   trueValue = checkComponent(p3, p2, p1, checkPoint);
                   if (trueValue == 1)
                       sub_result(i, j) = 1 ;
                   end 

            end

     end
end