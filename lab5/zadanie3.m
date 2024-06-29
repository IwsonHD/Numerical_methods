function [matrix_condition_numbers, max_coefficients_difference_1, max_coefficients_difference_2] = zadanie3()
    N = 5:40;

    % Wyniki
    matrix_condition_numbers = zeros(1, length(N));
    max_coefficients_difference_1 = zeros(1, length(N));
    max_coefficients_difference_2 = zeros(1, length(N));

    % Współczynniki uwarunkowania
    for i = 1:length(N)
        V = vandermonde_matrix(N(i));
        matrix_condition_numbers(i) = cond(V);
    end

    % Wykres 1: Wzrost współczynnika uwarunkowania macierzy Vandermonde wraz ze wzrostem jej rozmiaru
    figure;
    subplot(3, 1, 1);
    semilogy(N, matrix_condition_numbers);
    title('Wzrost współczynnika uwarunkowania macierzy Vandermonde');
    xlabel('Rozmiar macierzy N');
    ylabel('Współczynnik uwarunkowania (skala logarytmiczna)');
    grid on;

    % Wykres 2: Maksymalna różnica między referencyjnymi a obliczonymi współczynnikami wielomianu (b = wartości funkcji liniowej)
    a1 = randi([20, 30]);
    for i = 1:length(N)
        ni = N(i);
        V = vandermonde_matrix(ni);
        b = linspace(0, a1, ni)';
        reference_coefficients = [0; a1; zeros(ni - 2, 1)];
        calculated_coefficients = V \ b;
        max_coefficients_difference_1(i) = max(abs(calculated_coefficients - reference_coefficients));
    end

    subplot(3, 1, 2);
    plot(N, max_coefficients_difference_1);
    title('Maksymalna różnica współczynników (b = funkcja liniowa)');
    xlabel('Rozmiar macierzy N');
    ylabel('Maksymalna różnica');
    grid on;

   
   %% chart 3
    for i = 1:length(N)
        ni = N(i);
        V = vandermonde_matrix(ni);
    
    % Niech wektor b zawiera wartości funkcji liniowej nieznacznie zaburzone
        b = linspace(0,a1,ni)' + rand(ni,1)*1e-10;
        reference_coefficients = [ 0; a1; zeros(ni-2,1) ]; % tylko a1 jest niezerowy
    
    % Wyznacznie współczynników wielomianu interpolującego
        calculated_coefficients = V \ b;
    
        max_coefficients_difference_2(i) = max(abs(calculated_coefficients-reference_coefficients));
    end

    subplot(3, 1, 3);
    plot(N, max_coefficients_difference_2);
    title('Maksymalna różnica współczynników (b = zaburzona funkcja liniowa)');
    xlabel('Rozmiar macierzy N');
    ylabel('Maksymalna różnica');
    grid on;

    % Zapisz wykresy do pliku zadanie3.png
    saveas(gcf, 'zadanie3.png');
end
