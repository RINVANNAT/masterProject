function [dual_different, edgeFrame] = frame_substraction(frame1, frame2, vanishingPoint, mask)

%      frame1(1:(ceil(vanishingPoint(1,2)) - 10) , :) = 0;
%      frame2(1:(ceil(vanishingPoint(1,2)) - 10), :) = 0;
      frame2 = frame2 .* mask;
      frame1 = frame1 .* mask;
%       imshow(frame1);
%       figure();
%       imshow(frame2);
%       
      edgeFrame = frame2;
    dual_different = frame1 - frame2;

end
