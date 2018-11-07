function findLine()

close all;
clear all;
clc;

    directoryName = '/Users/mac/Desktop/object_detection/manipulated_frame/t1';
    %----reading video for displaying 
     videoread = vision.VideoFileReader('/Users/mac/Desktop/object_detection/official_video1.mov');
     frame  = step(videoread);
     frame = rgb2gray(frame);
%       [leftLine, rightLine] = houghLines(frame);
%       leftLine
%       rightLine
%       pause;
    
    loopIndex = 1;
    instance =615;
    
        %% main loop 
         while ~ isDone(videoread)
             currentFrame = step(videoread);
             currentFrame = rgb2gray(currentFrame);
            % --- create file image name for writing image
            fileName = [sprintf('%03d', loopIndex) '.jpg'];
            fullname = fullfile(directoryName, fileName);
            %==========end===========================
            
            if loopIndex == 1  %if mod(loopIndex,instance) == 0
                tic
                [leftLine, rightLine] = houghLines(currentFrame);
                
                [slope1, intercept1] = line_equation(leftLine.point1, leftLine.point2); % leftLine
                [slope2, intercept2] = line_equation(rightLine.point1, rightLine.point2); % rightLine
                [x_intercept, y_intercept] = compute_interception_point([slope1, intercept1], [slope2, intercept2]);
                referencePoint = [x_intercept, y_intercept];
                vanishingThreshold=0;
                p1 = [ceil(referencePoint(1,1)),ceil(referencePoint(1,2))];
                 [p2, p3, p4, p5 ] = laneMonitoring(rightLine, leftLine, currentFrame);
                 propRight = [slope2, intercept2];
                 propLeft = [slope1, intercept1];
                 mask = mask_binary(currentFrame, p1, p2, p3, p4, referencePoint, propRight, propLeft);
                 checkFrame = currentFrame .* mask;
                 
                 imshow(checkFrame);
                 imwrite((checkFrame), fullname);
                 pause;
                
                
                
                
                if ~isempty(rightLine)
                     currentFrame = insertShape(currentFrame,'line',[rightLine.point1, rightLine.point2],'LineWidth',2, 'Color', {'green'});
                end
                 if ~isempty(leftLine)
                     currentFrame = insertShape(currentFrame,'line',[leftLine.point1, leftLine.point2],'LineWidth',2, 'Color', {'red'});
                 end
                 imshow(currentFrame);
                 hold on
                 plot( referencePoint(1,1),referencePoint(1,2),'x','LineWidth',8,'Color','magenta');
                pause;
                 imwrite((currentFrame), fullname);
                 toc
            end
            
            loopIndex = loopIndex+1;
         end
end