function mat = hello(I1)

     p1 = [310,230];
     p2 = [600,310];
     p3 = [150, 300];
     p4 = [0,0];
     
     [height, width]= size(I1);
     res = zeros(height, width);
     
     for i = 230: height-50
         for j=1:width
             if  I1(i,j) >= 0.085
                 
                checkPoint = [j,i];
               trueValue = checkComponent(p3, p2, p1, checkPoint);
               if (trueValue == 1)
                   res(i,j)= I1(i, j);
                   
                   
               else
                   if (p4(1,1) ~= 0) || (p4(1,2) ~= 0)
                       trueValue_ = checkComponent(p4, p2, p3, checkPoint);
                       if (trueValue_ == 1)
                           res(i,j)= I1(i, j);
                       end
                   end

               end
                 
             end
           
         end
     end
     mat = res;
end