function plot_circle_areas(circle_areas)
    

    plot(circle_areas, '-o', 'LineWidth', 2, 'MarkerSize', 8);


    title('Cumulative Circle Areas');
    xlabel('Number of Circles');
    ylabel('Cumulative Area');

    

    print -dpng zadanie3.png 
end