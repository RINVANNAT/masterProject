function [ROI_segment] = ROISegementation(currentFrame, maskBinary, vanishingPoint)

    ROI_segment =  maskBinary .*  currentFrame;
   
end
