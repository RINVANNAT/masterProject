function [referencePoint, rightLine, slopeRightLine, interceptRightLine, leftLine, slopeLeftLine, interceptLeftLine] = get_ROI(frame)

   [height, width] = size(frame);
   [middleSlope, middleIntercept] = line_equation([width/2, 0], [((width/2)-1), height]);
   [leftLine, rightLine] = houghLines(frame);
%       imshow(frame); hold on
%      
%       if ~isempty(leftLine) && ~isempty(leftLine)
%           xy = [leftLine.point1; leftLine.point2];
%            xy1 = [rightLine.point1; rightLine.point2];
%           plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
%           plot(xy1(:,1),xy1(:,2),'LineWidth',2,'Color','yellow');
%           figure();
%       end
      
%      pause;
   
   if ~isempty(leftLine) && ~isempty(rightLine)
        [slope1, intercept1] = line_equation(leftLine.point1, leftLine.point2); % leftLine
        [slope2, intercept2] = line_equation(rightLine.point1, rightLine.point2); % rightLine
        [x_intercept, y_intercept] = compute_interception_point([slope1, intercept1], [slope2, intercept2]);
        referencePoint = [x_intercept, y_intercept];
        slopeLeftLine = slope1;
        interceptLeftLine = intercept1;
        slopeRightLine = slope2;
        interceptRightLine = intercept2;
%          iamhere1 = 'bothLine'
        
   end
   
   if isempty(leftLine) || isempty(rightLine)
       
       if isempty(leftLine) && ~isempty(rightLine)
           [slopeRight, interceptRight] = line_equation(rightLine.point1, rightLine.point2); % rightLine
            [x_intercept, y_intercept] = compute_interception_point([middleSlope, middleIntercept], [slopeRight, interceptRight]);
%             referencePoint = [x_intercept, y_intercept];
            referencePoint= [];
            slopeRightLine = slopeRight;
            interceptRightLine = interceptRight;
            slopeLeftLine = 0;
            interceptLeftLine = 0;
%              iamhere2 = 'leftEmpty'
       elseif isempty(rightLine) && ~isempty(leftLine)
       
           [slopeLeft, interceptLeft] = line_equation(leftLine.point1, leftLine.point2); % rightLine
            [x_intercept, y_intercept] = compute_interception_point([middleSlope, middleIntercept], [slopeLeft, interceptLeft]);
%             referencePoint = [x_intercept, y_intercept];
            referencePoint= [];

            slopeRightLine = 0;
            interceptRightLine = 0;
            slopeLeftLine = slopeLeft;
            interceptLeftLine = interceptLeft;
%              iamhere3 = 'rightEmpty'
       else
            slopeRightLine = 0;
            interceptRightLine = 0;
            slopeLeftLine = 0;
            interceptLeftLine = 0;
            referencePoint = [];
%              iamhere4 = 'bothEmpty'
       end
       
       
   end
  
   
  
end
