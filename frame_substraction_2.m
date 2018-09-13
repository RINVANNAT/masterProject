function [dual_different, imageEdge] = frame_substraction_2(frame1, frame2, maskBinary)

      
     tic
      frame1 =  maskBinary .*  frame1;
      frame2 =  maskBinary .*  frame2;
      
      dual_different = abs(frame2 - frame1);
      imageEdge = frame1;
      toc
%       blureImage =  wiener2(dual_different,[7 7]);
%       imshow(blureImage);
%       dual_different = edge(blureImage,'sobel');
%       figure();
%       imshow(dual_different);
     
%       dual_different = frame1 - frame2;
      
    
end
