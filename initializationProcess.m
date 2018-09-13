function [ maskBinary, POINT_ ] = initializationProcess(frame)

    frame = rgb2gray(frame);
  
    [frame_, vanishingPoint] = get_ROI(frame);
    [sPL, ePL, sPR, ePR, x_intercept, y_intercept, botEndPR, botIntx, botInty] = getInitialStep(vanishingPoint, frame_);
    p1 = [x_intercept, y_intercept];
    p2 = sPR;
    p3 = sPL;
      p4 = [0, size(frame_, 1)- 50];
%        p4 = [0, 0];
    tic
    maskBinary = mask_binary(frame_, p1,p2,p3,p4, vanishingPoint);
    toc
    POINT_ = vanishingPoint;
 
end