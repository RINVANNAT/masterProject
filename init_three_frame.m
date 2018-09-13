function [three_diff_image,tri_frames_, dual_diff_frames_, maskBinary, POINT_ ] = init_three_frame(frame)

    frame = rgb2gray(frame);
    R_LENGTH = size(frame,2);
	R_HEIGHT = size(frame,1);
  

    tri_frames = zeros(R_HEIGHT, R_LENGTH, 3);	% Gray images, range 0~1
	dual_diff_frames = zeros(R_HEIGHT, R_LENGTH, 2);	% As above
% 	tri_diff_frame = zeros(R_HEIGHT, R_LENGTH);	% As above
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
   
    % The initial process
    for i=1:3
        tri_frames(:, :, i) = frame;
    end
   
    for i = 1:2
        [dual_diff_frames(:,:,i), edge_S] = frame_substraction_4(tri_frames(:,:,i), tri_frames(:,:,i + 1), maskBinary, vanishingPoint);
    end
    
	tri_diff_frame = dual_diff_frames(:,:,1) & dual_diff_frames(:,:,2);
    tri_diff_frame = tri_diff_frame | dual_diff_frames(:,:,1) | dual_diff_frames(:,:,2);
% 	tri_diff_frame = set_upper_bound(tri_diff_frame, 1);	% Gray should be 0~1
% 	tri_diff_frame = edge(tri_diff_frame,'sobel');
%     diff_img_level_threshold = graythresh(tri_diff_frame);
%     tri_diff_frame = im2bw(tri_diff_frame, diff_img_level_threshold);
    

    tri_frames_ = tri_frames;
    dual_diff_frames_ = dual_diff_frames;
    three_diff_image= tri_diff_frame;
    
   
   
end