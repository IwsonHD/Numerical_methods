function plot_PageRank(r)
    bar(r)
    title('Ranking');
    xlabel('Site');
    ylabel('Rank')
    print -dpng zadanie7.png 
end