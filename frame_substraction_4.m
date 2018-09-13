function [dual_different, edge] = frame_substraction_4(frame1, frame2, maskBinary, vanishingPoint)

    frame1 =  maskBinary .*  frame1;
    frame2 =  maskBinary .*  frame2;
    edge = frame2;
    dual_different = frame1 - frame2;
     
end
