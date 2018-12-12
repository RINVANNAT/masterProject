
function plot_hough_lines(lines, frame)
[frameHeight, frameWidth ] = size(frame);

     imshow(frame), hold on
    max_len = 0;

     for k = 1:length(lines)
        
         xy = [lines(k).point1; lines(k).point2];
%               plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
%               plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%                plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','yellow');
              % Determine the endpoints of the longest line segment
%               len = norm(lines(k).point1 - lines(k).point2);
%               if ( len > max_len)
%                   max_len = len;
%                   xy_long = xy;
%               end
          if lines(k).theta <= -10 && lines(k).theta >= -85
              if (lines(k).point1(1,1) >= frameWidth/2) && (lines(k).point2(1,1) >= frameWidth/2)
                  plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
                   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
                    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','yellow');
                   % Determine the endpoints of the longest line segment
                   len = norm(lines(k).point1 - lines(k).point2);
    %                if ( len > max_len)
    %                    max_len = len;
    %                    xy_long = xy;
    %                end
              end
               
              
          elseif lines(k).theta <= 85 && lines(k).theta >= 10
              
              if (lines(k).point1(1,1) <= frameWidth/2) && lines(k).point2(1,1) <= frameWidth/2
                  plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
                   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
                    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','yellow');
              end
               
               % Determine the endpoints of the longest line segment
%                len = norm(lines(k).point1 - lines(k).point2);
%                if ( len > max_len)
%                    max_len = len;
%                    xy_long = xy;
%                end
          end
         
%           if lines(k).theta <= -0 && lines(k).theta >= -10 
%           end
%          if lines(k).theta <= -80 && lines(k).theta >= -84 
%          end
        
     end
%     plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');

end

            