function plot_intersect_points(intersections)

    intersections = transpose(intersections);
     for j=1:size(intersections, 1)
%          plot( intersections(j, 1), intersections(j,2),'.','LineWidth',1,'Color','magenta');
         plot( intersections(j, 1), intersections(j,2), 'c*', 'LineWidth',4);
        
     end
end
