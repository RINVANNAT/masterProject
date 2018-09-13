function lines = houghLines(frame_mat)


 % ------start initialize four clusters ------
             initial_clusters = init_clusters(frame_mat);
        %------end initial clusters---------
        
        BW = edge(frame_mat,'canny'); % create binary image using canny edge detection
        [H,T,R] = hough(BW); % apply hough tranform 
        P  = houghpeaks(H,15,'threshold',ceil(0.3*max(H(:)))); % get hough peak value
        lines = houghlines(BW,T,R,P,'FillGap',10,'MinLength',70); % get lines from hough tranform by configuring some parmetters 
      
       
          k =1;
          while k < length(lines)
              k = k+1;
              if lines(k).theta <= -0 && lines(k).theta > -10
                 lines(k)=[];
             elseif lines(k).theta >= -90 && lines(k).theta < -85
                 lines(k)=[];
             elseif lines(k).theta >= 0 &&  lines(k).theta < 10
                 lines(k)=[];
             elseif lines(k).theta > 85 &&  lines(k).theta <= 90
                 lines(k)=[];
             end
              
          end
          
          
          
end
