function [V, original_Runge, original_sine, interpolated_Runge, interpolated_sine] = zadanie1()
    % Rozmiar tablic komórkowych (cell arrays) V, interpolated_Runge, interpolated_sine: [1,4].
    % V{i} zawiera macierz Vandermonde wyznaczoną dla liczby węzłów interpolacji równej N(i)
    N = 4:4:16;
    x_fine = linspace(-1, 1, 1000);
    original_Runge = 1 ./ (1 + 25 * (x_fine .^ 2));
    original_sine = sin(2 * pi * x_fine);
    
    % Inicjalizacja tablic komórkowych
    V = cell(1, length(N));
    interpolated_Runge = cell(1, length(N));
    interpolated_sine = cell(1, length(N));
    
    subplot(2, 1, 1);
    plot(x_fine, original_Runge, 'DisplayName', 'Original Runge');
    hold on;
   
    for i = 1:length(N)
        V{i} = vandermonde_matrix(N(i)); % macierz Vandermonde
        
        
        x_coarse = linspace(-1, 1, N(i));
        
        runge_values = 1 ./ (1 + 25 * (x_coarse .^ 2));
        
        c_runge = V{i} \ runge_values';
        
        
        interpolated_Runge{i} = polyval(flipud(c_runge), x_fine);
        plot(x_fine, interpolated_Runge{i}, 'DisplayName', ['Interpolated Runge N=' num2str(N(i))]);
    end
    
    hold off;
    legend;
    title('Runge function');
    xlabel('x');
    ylabel('y');
    
    subplot(2, 1, 2);
    plot(x_fine, original_sine, 'DisplayName', 'Original Sine');
    hold on;
    
    for i = 1:length(N)
        sine_values = sin(2 * pi * linspace(-1, 1, N(i)));
        
        
        c_sine = V{i} \ sine_values';
        
        
        interpolated_sine{i} = polyval(flipud(c_sine), x_fine);
        plot(x_fine, interpolated_sine{i}, 'DisplayName', ['Interpolated Sine N=' num2str(N(i))]);
    end
    
    hold off;
    legend;
    title('Sine function');
    xlabel('x');
    ylabel('y');
    saveas(gcf, 'zadanie1.png');
end


