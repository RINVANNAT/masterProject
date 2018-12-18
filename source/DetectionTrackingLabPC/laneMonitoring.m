function [p2, p3, p4, p5] = laneMonitoring(RightLine, leftLine, frame)

    [imgHeight, imgWidth ] = size(frame);
    
    [xLeft, yLeft] = findBotomPoint(leftLine,[ [1,0]; [2, imgHeight]]);
    [xRight, yRight] = findBotomPoint(RightLine,[ [imgWidth,0]; [imgWidth-2, imgHeight] ]);
    
    if yLeft <= imgHeight
        p2 = [xLeft, yLeft];
        p5 = [0, imgHeight];
    else
        [xLeft, yLeft] = findBotomPoint(leftLine,[[0,imgHeight]; [imgWidth, imgHeight]]);
        p2 = [xLeft, yLeft];
        p5 = [0, 0];
    end
     
    if yRight <= imgHeight
         p3 = [xRight, yRight];
         p4 = [imgWidth-2, imgHeight];
    else
        [xRight, yRight] = findBotomPoint(RightLine,[[0,imgHeight]; [imgWidth, imgHeight]]);
        p3 = [xRight, yRight];
        p4 = [0, 0];

    end
     
     
     
     
     
%      imshow(frame1);
%      hold on
%    
%      %% draw line at left
%      xy1 = [leftLine.point1; leftLine.point2];
%      xy2 = [[1,0]; [2, imgHeight]];
%      plot(xy1(:,1),xy1(:,2),'LineWidth',2,'Color','green');
%      plot(xy2(:,1),xy2(:,2),'LineWidth',2,'Color','red');
%      %% draw line at right
%      xyr1 = [RightLine.point1; RightLine.point2];
%      xyr2 = [ [imgWidth,0]; [imgWidth-2, imgHeight] ];
%      plot(xyr1(:,1),xyr1(:,2),'LineWidth',2,'Color','green');
%      plot(xyr2(:,1),xyr2(:,2),'LineWidth',2,'Color','red');
%      
%      %% plot point left and right
%      plot(xLeft,yLeft,'x','LineWidth',2,'Color','yellow');
%      plot(xRight,yRight,'x','LineWidth',2,'Color','yellow');
%      
%      
    
end
