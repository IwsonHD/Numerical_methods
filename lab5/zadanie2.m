function [nodes_Chebyshev, V, V2, original_Runge, interpolated_Runge, interpolated_Runge_Chebyshev] = zadanie2()
    N = 16;
    x_fine = linspace(-1, 1, 1000);
    original_Runge = 1 ./ (1 + 25 * (x_fine .^ 2));
    nodes_Chebyshev = get_Chebyshev_nodes(N);
    x_coarse = linspace(-1, 1, N);
    V = vandermonde_matrix(x_coarse);
    V2 = vandermonde_matrix(nodes_Chebyshev);
    runge_values = 1 ./ (1 + 25 * (x_coarse .^ 2));
    runge_values_chebyshev = 1 ./ (1 + 25 * (nodes_Chebyshev .^ 2));
    c_runge = V \ runge_values';
    c_runge_chebyshev = V2 \ runge_values_chebyshev';
    interpolated_Runge = polyval(flipud(c_runge), x_fine);
    interpolated_Runge_Chebyshev = polyval(flipud(c_runge_chebyshev), x_fine);
    figure;
    subplot(2,1,1);
    plot(x_fine, original_Runge, 'DisplayName', 'Oryginalna funkcja Runge');
    hold on;
    plot(x_coarse, runge_values, 'o', 'DisplayName', 'Wartości funkcji Runge w węzłach');
    plot(x_fine, interpolated_Runge, 'DisplayName', 'Interpolacja (równomierne węzły)');
    hold off;
    title('Interpolacja wielomianowa dla równomiernie rozmieszczonych węzłów');
    legend;
    xlabel('x');
    ylabel('y');
    subplot(2,1,2);
    plot(x_fine, original_Runge, 'DisplayName', 'Oryginalna funkcja Runge');
    hold on;
    plot(nodes_Chebyshev, runge_values_chebyshev, 'o', 'DisplayName', 'Wartości funkcji Runge w węzłach');
    plot(x_fine, interpolated_Runge_Chebyshev, 'DisplayName', 'Interpolacja (węzły Czebyszewa)');
    hold off;
    title('Interpolacja wielomianowa dla węzłów Czebyszewa');
    legend;
    xlabel('x');
    ylabel('y');
    saveas(gcf, 'zadanie2.png');
end

function nodes = get_Chebyshev_nodes(N)
    % Oblicza N węzłów Czebyszewa drugiego rodzaju
    nodes = cos((0:N-1) * pi / (N - 1));
end

function V = vandermonde_matrix(x)
    N = length(x);
    V = zeros(N, N);
    for i = 1:N
        for j = 1:N
            V(i, j) = x(i) ^ (j - 1);
        end
    end
end
