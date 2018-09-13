function frame = mask_binary(img, p1, p2, p3, p4, vanishingPoint)

sub_result = zeros(size(img, 1), size(img, 2));

   for i= ceil(vanishingPoint(1,2))- 50 :size(img, 1)- 50 % throw y
       for j=1:size(img, 2) % throw x
           checkPoint = [j,i];
           trueValue = checkComponent(p3, p2, p1, checkPoint);
           if (trueValue == 1)
               sub_result(i, j) = 1 ;
           else
               if (p4(1,1) ~= 0) || (p4(1,2) ~= 0)
                   trueValue_ = checkComponent(p4, p2, p3, checkPoint);
                   if (trueValue_ == 1)
                        sub_result(i, j) = 1 ;
                   end
               end
               
           end  
        end
                 
   end
   
    frame = (sub_result);
  
    
end
