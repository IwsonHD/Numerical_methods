function plot_circles(a, circles, index_number)
    hold on;
    axis equal;
    axis([0 a 0 a]);
    
    for i = 1:height(circles())
        plot_circle(circles(i,3), circles(i,1), circles(i, 2))
    end
    
end
