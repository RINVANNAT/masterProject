function imge = resizeIMG_without_losing_ratio(originalImg)


%     YourImage = imread('/Users/mac/Documents/MATLAB/extract_frame/frame1.jpg');
    %figure out the pad value to pad to white
    if isinteger(originalImg)
       pad = intmax(class(originalImg));
    else
       pad = 1;   %white for floating point is 1.0
    end
    
    %figure out which dimension is longer and rescale that to be the 256
    %and pad the shorter one to 256
%     360 640
    [r, c, ~] = size(originalImg);
    if r > c
      imge = imresize(originalImg, 360 / r);
      imge(:, end+1 : 256, :) = pad;
    elseif c > r
      imge = imresize(originalImg, 640 / c);
      imge(end+1 : 256, :, :) = pad;
    else
      imge = imresize(originalImg, [360, 640]);
    end
    
%      imshow(imge);
%      pause;
end
