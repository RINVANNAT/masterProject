function [three_diff_image,tri_frames_, dual_diff_frames_ ] = init_three_frame(frame, mask, vanishingPoint)

    
    R_LENGTH = size(frame,2);
	R_HEIGHT = size(frame,1);
  

    tri_frames = zeros(R_HEIGHT, R_LENGTH, 3);	% Gray images, range 0~1
	dual_diff_frames = zeros(R_HEIGHT, R_LENGTH, 2);	% As above
% 	tri_diff_frame = zeros(R_HEIGHT, R_LENGTH);	% As above
    % The initial process
    for i=1:3
        tri_frames(:, :, i) = frame;
    end
   
    for i = 1:2
        [dual_diff_frames(:,:,i), haftFrame] = frame_substraction(tri_frames(:,:,i), tri_frames(:,:,i + 1), vanishingPoint, mask);
    end
    
	tri_diff_frame = dual_diff_frames(:,:,1) | dual_diff_frames(:,:,2);
%     resEdge = edge(haftFrame, 'sobel');
%     tri_diff_frame = tri_diff_frame | resEdge ;
    

    tri_frames_ = tri_frames;
    dual_diff_frames_ = dual_diff_frames;
    three_diff_image= tri_diff_frame;
    
   
   
end