function dual_different = frame_substraction_3(frame1, frame2, maskBinary, vanishingPoint)

     thresHight = 0.045;
     thresLow = 0.0650;
        frame1 =  maskBinary .*  frame1;
        frame2 =  maskBinary .*  frame2;
   
%       frame1 = padarray(frame1, [1,1]);
%       frame2 = padarray(frame2, [1,1]);
       [height, width] = size(frame1);
       sub_result = zeros(height, width);
       
     p1 = [310,230];
     p2 = [630,310];
     p3 = [200, 300];
     p4 = [0,0];
       
       for i=ceil(vanishingPoint(1,2)):size(frame1,1)
           for j=1:size(frame1,2)
               a = frame1(i,j);
               b = frame2(i,j);
               pixel_substrac = abs(a - b);
              
               if  pixel_substrac >= thresHight
                   
                   checkPoint = [j,i];
                   trueValue = checkComponent(p3, p2, p1, checkPoint);
                   if (trueValue == 1)
                       sub_result(i,j) = 1;
                       for i2=(i-2):(i+2)
                        for j2= (j-2):(j+2)
                            if abs(frame1(i2, j2) - frame2(i2, j2)) >= thresHight
                               sub_result(i2,j2) = 1;
                            end
                            
                        end
                        
                      end
                       
                   else
                       if (p4(1,1) ~= 0) || (p4(1,2) ~= 0)
                           trueValue_ = checkComponent(p4, p2, p3, checkPoint);
                           if (trueValue_ == 1)
                                sub_result(i,j) = 1;
                           end
                       end

                   end
               else
                   sub_result(i,j) = 0;
               end
               
               
               
%                if (abs(frame1(i,j) - frame2(i,j)) > thresLow) && (abs(frame1(i,j) - frame2(i,j)) < thresHight)
%                    
%                    for i2=(i-1):(i+1)
%                        
%                        for j2= (j-1):(j+1)
%                            
%                            if (abs(frame1(i2,j2) - frame2(i2, j2)) > thresLow)
%                               subRest(i,j) = 1;
%                            end
%                            
%                        end
%                        
%                    end
%                end
%                if abs(frame1(i,j) - frame2(i,j)) <= thresLow
%                     subRest(i,j) = 0;
%                end    
           end
       end

%       subRest(1,:)= [];
%       subRest(:,1)= [];
%       subRest(end,:)= [];
%       subRest(:,end)= [];
    
      
      dual_different = (sub_result);
    
      
      
    
end
