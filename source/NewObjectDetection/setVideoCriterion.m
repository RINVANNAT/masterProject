function [trueCon] = setVideoCriterion (videoName)
    
% videoName(1,length(videoName)-4)

    if videoName(1,length(videoName)-4) == '5'
        trueCon=1;
    else
        trueCon=0;
    end

end