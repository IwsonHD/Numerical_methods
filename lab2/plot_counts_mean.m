function plot_counts_mean(counts_mean)
    plot(counts_mean, '-');
    title('Mean of counts');
    xlabel('Number of draws');
    ylabel('Mean of draws')

    print -dpng zadanie5.png
end