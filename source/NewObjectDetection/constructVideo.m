function constructVideo()

    %---load the images 
    
    images = cell(3,1);
    k=1;
    tic
    for i=2000:3000
        
        originalReadIMG =  imread(strcat('/Users/mac/Desktop/object_detection/newEx/f2/', num2str(i), '.jpg'));
        images{k} = resizeIMG_without_losing_ratio(originalReadIMG);
%         images{k} = imresize(originalReadIMG, [360 640]);
        k=k+1;
    end
    toc
    
     % create the video writer with 1 fps
     writerObj = VideoWriter('/Users/mac/Desktop/object_detection/official_video2.avi');
     writerObj.FrameRate = 25;
     
     % set the seconds per image
%        secsPerImage = [5 10 15];
    
     % open the video writer
        open(writerObj);
        
      % write the frames to the video
      tic
     for u=1:length(images)
         % convert the image to a frame
         frame = im2frame(images{u});
          writeVideo(writerObj, frame);
%          for v=1:secsPerImage(u) 
%             
%          end
     end
     toc
     % close the writer object
     close(writerObj);
    
end

