clear all
close all
format compact

r_max = 2;
n_max = 200;
[circles, index_number,circle_areas, rand_counts, counts_mean] = generate_circles(20, r_max,n_max);
%rand_counts;
%counts_mean;
plot_circles(20,circles, 193066);
%print -dpng zadanie1.png

%plot_circle_areas(circle_areas);

%print -dpng zadanie3.png
%plot_counts_mean(counts_mean);
%print -dpng zadanie5.png
