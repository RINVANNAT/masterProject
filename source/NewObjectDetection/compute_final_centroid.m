function [ final_centroid ] = compute_final_centroid(clusters, frame)

    x_axis =0;
    y_axis = 0;
    height = size(frame,1);
    width = size(frame,2);
    count_cluster = 0;
    
    
    
%      plot((2*width)/7, height/4,'x','LineWidth',2,'Color','yellow');
%      plot((5*width)/7,(3*height)/4,'x','LineWidth',2,'Color','red');
    
    for i = 1: size(clusters, 1)
        if ~isnan(clusters(i, 1))
            if clusters(i, 1) > 0
                if clusters(i, 1) >= (2*width)/7 && clusters(i, 1) <= (5*width)/7
                    if clusters(i, 2) >= height/4 && clusters(i, 2) <= (3*height)/4
                     count_cluster = count_cluster+1;
                     x_axis = clusters(i, 1) + x_axis;
                     y_axis = clusters(i, 2) + y_axis;
                    end
                end
            end
        end
        
    end
    final_centroid = [x_axis/count_cluster, y_axis/ count_cluster];
end
