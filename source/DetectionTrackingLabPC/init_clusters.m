function initialization_cluster = init_clusters(frame_mat)

        [y_axis, x_axis ] = size(frame_mat);
        
        
%             class_1 = [ (x_axis/4), (y_axis/2)];
%             class_2 = [(3*x_axis/4), (y_axis/2)];
%             class_3 = [(x_axis/2), (y_axis/2)];
%              class_4 = [(x_axis/2), (3*y_axis/4)];
%              class_5 = [(x_axis/2), (y_axis/2)];
            
        % ----- first critearion ------
%             class_1 = [ (x_axis/4), (3*y_axis/4)];
%             class_2 = [(3*x_axis/4), (3*y_axis/4)];
%            class_3 = [(x_axis/2), (3*y_axis/4)];
           
%            class_3 = [(3*x_axis/4), (3*y_axis/4)];
%           class_4 = [(x_axis/4), (y_axis/4)];
%           class_5 = [(x_axis/2), (y_axis/2)];
        %------end ----------
        
        
        
        %------ second critearion ------
        
          class_1 = [ (x_axis/4), (3*y_axis/4)];
          class_2 = [(x_axis/2), (y_axis/2)];
          class_3 = [(3*x_axis/4), (3*y_axis/4)];
          
          
          
          
%           class_4 = [(x_axis/2), (3*y_axis/4)];
%           class_5 = [(x_axis/2), (y_axis/2)];
        
        %---end ----------------
        initialization_cluster = [class_1; class_2; class_3];
end
