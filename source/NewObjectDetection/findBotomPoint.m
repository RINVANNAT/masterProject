function [x, y] = findBotomPoint(RightOrLeftLine, checkLine)

    %% left or right lane mark
    [slopeLeft1, interceptLeft1] = line_equation( RightOrLeftLine.point1, RightOrLeftLine.point2);
    [slopeLeft2, interceptLeft2] = line_equation( checkLine(1, :), checkLine(2, :));
   
    %% compute both interception point at right and left 
    [x, y] = compute_interception_point([slopeLeft1, interceptLeft1], [slopeLeft2, interceptLeft2]);
end