
function New_Three_Diff_Method_2()

clear all;
close all;
clc;
positionPrediction = [];

    count = 0;
    directoryName = '/Users/vannat/Desktop/Matlab_space/object_detection/manipulate_frame2/count';
    %----reading video for displaying 
     videoread = vision.VideoFileReader('/Users/vannat/Desktop/Matlab_space/video_sample/v_1.mov');
     frame  = step(videoread);
   
     [tri_diff_frame,tri_frames, dual_diff_frames, maskBinary, vanishingPoint] = init_three_frame(frame);
   
    %--------end
    % -------- to play the transformed video
%          videoplay = vision.VideoPlayer; 
    %------end-----
    SE_2 = strel('disk',1);
    loopIndex = 1;
    instance =4;
    
    
    %% Initialization of object tracking with kalmanfilter==
    
%         I = eye(2); % identity matrix
        dt = 1; % Sampling time (s)
        % t = dt*(1:N); % time vector (s)
        F = dt; % system matrix - state
        H = [1, 0; 0,1]; % observation matrix

        Q = [0, 0; 0, 0]; % process noise covariance
        I = eye(2); % identity matrix
        % Define the initial position and velocity
        Pox = 303.5913; % position in x direction
        Poy = 241.6213; % position in y direction
        % uncertainty matric associated with a noisy set of measurement
        deltaPox = 4;
        deltaPoy = 4;
        R = [deltaPox^2, 0; 0, deltaPoy^2];
        % process error in process covariance matrice
        deltaPx = 5; % the stadard deviation of Position in x direction
        deltaPy = 5; % the stadard deviation of Position in y direction
        % Initialize the state vector (estimated state)
        k =1;
        measurementValue = zeros(2, 1);
        measurementValue(:, 1) = [Pox; Poy];
        estimatedValue = zeros(2, 1); % Estimated state vector
        estimatedValue(:, 1) = [Pox; Poy]; % Guess for initial state
        % Initialize the covariance matrix
        P = [deltaPx^2, 0; 0, deltaPy^2 ]; % Covariance for initial state error
        % Loop through and perform the Kalman filter equations recursively
        predictedValue = zeros(2, 1);
        predictedValue(:, 1 )= [Pox; Poy];
        %% end of kalman initialisation ==
    
        %% main loop 
         while ~ isDone(videoread)
             currentFrame = step(videoread);
             currentFrame = rgb2gray(currentFrame);
            % --- create file image name for writing image
            fileName = [sprintf('%03d', loopIndex) '.jpg'];
            fullname = fullfile(directoryName, fileName);
            %==========end===========================

            if (mod(loopIndex,instance) == 0)

                if loopIndex == instance
                    for idx=1:2
                     tri_frames(:, :, idx) = tri_frames(:, :, idx+1);
                    end
                     tri_frames(:,:,3) = currentFrame;  
    %                  predictedValue = [predictedValue, [0;0]];
                else


                 % ===================update frame to ques array of 3 images / that
                 % mean index:[ 1==> image1, 2==> image5, 3==> image10 ]
                         for idx=1:2
                             tri_frames(:, :, idx) = tri_frames(:, :, idx+1);
                         end
                         tri_frames(:,:,3) = currentFrame;
                 % =====================end of qeueing==========

                   tic
                 % =====================start duel different of frame1-frame5 & frame5-frame10==========
                     for i = 1:2
                        [dual_diff_frames(:,:,i), edge_S]= frame_substraction_4(tri_frames(:,:,i), tri_frames(:,:,i + 1), maskBinary, vanishingPoint);
                     end
                  % ===================== end==============

                  level1_thres = 0.065;
                  level2_thres = 0.065;
                  binary1 = im2bw(dual_diff_frames(:,:,1), level1_thres);
                  binary2 = im2bw(dual_diff_frames(:,:,2), level2_thres);
                  tri_diff_frame =  binary1 & binary2 ;
                  resEdges = edge(edge_S ,'sobel');
                  tri_diff_frame = tri_diff_frame | resEdges;

                  tri_diff_frame = hello(tri_diff_frame);
                   tri_diff_frame = bwareaopen(tri_diff_frame, 3);
                   tri_diff_frame =  imdilate(tri_diff_frame, SE_2);

                   [labeledImage, numberOfObjects] = bwlabel(tri_diff_frame);
                   stats = regionprops(labeledImage,{'Area','BoundingBox','perimeter', 'Centroid', 'Orientation', 'BoundingBox', 'ConvexImage'});
                   stats = struct2table(stats);

                   % 1st metric: ratio between perimeter and round length of its bounding box
                    stats.Metric1 = 2*sum(stats.BoundingBox(:,3:4),2)./stats.Perimeter;
                    idx1 = abs(1 - stats.Metric1) < 0.3;

                    %2nd metric: ratio between blob area and it's bounding box's area
                    stats.Metric2 = stats.Area./(stats.BoundingBox(:,3).*stats.BoundingBox(:,4));   
                    idx2 = stats.Metric2 > 0.5;

                    % 3rd metic: approximation of area size
                    idx3 =  stats.Area >= 100;

                    finalIndex = idx1 & idx2 & idx3 ;
                    stats(~finalIndex,:) = [];
                   

                    %% kalman filter process=======
                     k = k +1;
                    if ~isempty(stats.Centroid) 
                        positionPrediction = [positionPrediction; stats.Centroid];
                        xt = transpose(stats.Centroid);
                    else
                        positionPrediction = [positionPrediction; positionPrediction(k-2,:)];
                        xt = transpose(positionPrediction(k-2,:));
                    end

                    z = H*xt ; % noisy measurement
                    measurementValue = [measurementValue, z];
                    estimatedValue = [estimatedValue, [0;0]];
                    predictedValue = [predictedValue, [0;0]];

                    % predict the position in the next iteration 
                    estimatedValue(:, k) = F*estimatedValue(:, k-1) ;
                    predictedValue(:, k ) = estimatedValue(:, k) ; % = store the predicted value for displaying

                    % Predict the covariance
                     P = F*P*F' + Q;
                     % Calculate the Kalman gain matrix
                     K = P*H'/(H*P*H' + R);
                     % Update the state vector
                     estimatedValue(:,k) = estimatedValue(:,k) + K*(z - H*estimatedValue(:,k));
                     % Update the covariance
                     P = (I - K*H)*P;
                     %% end of kalman filter=======


                    idFound = find(finalIndex==1);
                    if ~isempty(idFound) 
                        count = count+1;
                    end
    %                 tri_diff_frame = ismember(labeledImage, idFound) ;
    %                 imGG = tri_diff_frame;
    %                 for kk = 1:height(stats)
    %                  imGG = insertShape(uint8(imGG),'rectangle', stats.BoundingBox(kk,:), 'LineWidth',1);
    %                 end

                   toc
    %                  imGG = im2bw(imGG);
    %                  tri_diff_frame = tri_diff_frame | imGG;
                     imwrite((tri_diff_frame), fullname);
                end
            end
            loopIndex=loopIndex+1;

         end
         %% end while loop
     count
     positionPrediction
     measurementValue
     estimatedValue
     predictedValue
     
     t = 1:length(predictedValue);
figure(1);
subplot(211);
plot(t, predictedValue(1,:), 'g-', t, estimatedValue(1,:), 'b--', 'LineWidth', 2);
 hold on; plot(t, measurementValue(1,:), 'r:', 'LineWidth', 1.5)
xlabel('t (frame)'); ylabel('Position in x axis'); grid on;
legend('Predicted Value', 'Estimated','Measured');
subplot(212);
plot(t, predictedValue(2,:), 'g-', t, estimatedValue(2,:), 'b--', 'LineWidth', 2);
 hold on; plot(t, measurementValue(2,:), 'r:', 'LineWidth', 1.5)
xlabel('t (frame)'); ylabel('Position in y axis'); grid on;
legend('Predicted Value', 'Estimated','Measured');
         
end






