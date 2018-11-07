function [leftLine, rightLine] = houghLines(frame_mat)


 % ------start initialize four clusters ------
%              initial_clusters = init_clusters(frame_mat);
        %------end initial clusters---------
        [frameHeight, frameWidth ] = size(frame_mat);
        frame_mat(1:ceil(frameHeight/2), :) = 0;
        frame_mat(frameHeight-20:frameHeight, :) = 0;
        
     
%         frame_mat = imgaussfilt(frame_mat, 2);
        BW = edge(frame_mat,'sobel'); % create binary image using canny edge detection
        
        
        [H,T,R] = hough(BW); % apply hough tranform 
        P  = houghpeaks(H,30,'threshold',ceil(0.2*max(H(:)))); % get hough peak value
        lines = houghlines(BW,T,R,P,'FillGap',10,'MinLength',100); % get lines from hough tranform by configuring some parmetters 
%            plot_hough_lines(lines, frame_mat);
%            
%            pause;
%         lines
%         lines.theta
%         lines = sort(lines.theta);
%         lines.theta
%        pause;
%          lines
        rightLine = [];
%         maxLengthRight = 0;
%         maxXRightPosition = 0;
%         minXLeftPosition = 0;
        
        rightLineIndex = 0;
        leftLine = [];
%         maxLenghtLeft = 0;
        leftLineIndex = 0;
%      
%            minThetaRight = -10;
%            minThetaLeft = 85;
%            maxPointLeftY1 = 0;
%            maxPointLeftY2 = 0;
           countLeft = 0;
           countRight =1;
          for k=1:length(lines)
%               if lines(k).theta <= -0 && lines(k).theta > -10
%                  lines(k)=[];
%              elseif lines(k).theta >= -90 && lines(k).theta < -85
%                  lines(k)=[];
%              elseif lines(k).theta >= 0 &&  lines(k).theta < 10
%                  lines(k)=[];
%              elseif lines(k).theta > 85 &&  lines(k).theta <= 90
%                  lines(k)=[];
%              end


               if lines(k).theta <= -20 && lines(k).theta >= -83
                   
                   %% right lane marking
                   if (lines(k).point1(1,1) >= frameWidth/2) && (lines(k).point2(1,1) >= frameWidth/2)
                       
                       if countRight == 1
                           
                           midPointRight = [(lines(k).point1(1,1)+lines(k).point2(1,1))/2, (lines(k).point1(1,2)+lines(k).point2(1,2))/2];
                           rightLineIndex = k;
                       else
                           disRight = (midPointRight(1,1)-lines(k).point1(1,1))*(lines(k).point2(1,2)-lines(k).point1(1,2))- (midPointRight(1,2)-lines(k).point1(1,2))*(lines(k).point2(1,1)-lines(k).point1(1,1));
                         
                           if disRight > 0
                                midPointRight = [(lines(k).point1(1,1)+lines(k).point2(1,1))/2, (lines(k).point1(1,2)+lines(k).point2(1,2))/2];
                                rightLineIndex = k;
                           end
                          
                       end
%                        plot(midPointRight(1,1),midPointRight(1,2),'x','LineWidth',2,'Color','red');
%                        len = norm(lines(k).point1 - lines(k).point2);
% %                        rightLineIndex = k;
% %                        lines(k)
%                        if minThetaRight > lines(k).theta
% %                            right = lines(k).theta
%                            if ( len > maxLengthRight)
%                                
%                                if lines(k).point1(1,2) <= frameHeight
%                                        minThetaRight = lines(k).theta;
%                                        maxLengthRight = len;
%                                        rightLineIndex = k;
%                                end
% 
%                            end
%                        end
                       countRight = countRight +1;
                   end
                  
               elseif lines(k).theta <= 83 && lines(k).theta >= 20
                   %% left lane mark
                   if (lines(k).point1(1,1) <= frameWidth/2) && lines(k).point2(1,1) <= frameWidth/2
                        countLeft = countLeft + 1;
                       if countLeft == 1
                           midPoint = [(lines(k).point1(1,1)+lines(k).point2(1,1))/2, (lines(k).point1(1,2)+lines(k).point2(1,2))/2];
                           leftLineIndex = k;
%                            selectLeft = lines(k)
                       else
                       % d = (x-x1)(y2-y1) - (y-y1)(x2-x1) if d>0 -->
                       % P(x,y) on the right of line [p1(x1, y1),p2(x2,y2)] 
                       % if d<0 --> P lie on left of Line else on the line
                           
                           dis = (midPoint(1,1)-lines(k).point1(1,1))*(lines(k).point2(1,2)-lines(k).point1(1,2))...
                               - (midPoint(1,2)-lines(k).point1(1,2))*(lines(k).point2(1,1)-lines(k).point1(1,1));
                           if dis < 0
                                midPoint = [(lines(k).point1(1,1)+lines(k).point2(1,1))/2, (lines(k).point1(1,2)+lines(k).point2(1,2))/2];
                                
                                leftLineIndex = k;
                           end
                       end
                       
%                        plot(midPoint(1,1),midPoint(1,2),'x','LineWidth',2,'Color','red');
%                       len_left = norm(lines(k).point1 - lines(k).point2);
%                       if minThetaLeft >= lines(k).theta
% %                           left = lines(k).theta
%                           
%                           if ( len_left > maxLenghtLeft)
%                            
%                                if lines(k).point1(1,2) <= frameHeight
%                                    minThetaLeft = lines(k).theta;
%                                    maxLenghtLeft = len_left;
%                                    leftLineIndex = k;
%                                end
% 
%                            end
%                           
%                           
%                       end
                       
                   end
                   
               end
          end
          
          if rightLineIndex ~= 0
              rightLine = lines(rightLineIndex);
%               rightLine
          end
           
          
           if leftLineIndex ~= 0
              leftLine = lines(leftLineIndex);
%               leftLine
           end
end
