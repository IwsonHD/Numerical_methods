function [country, source, degrees, x_coarse, x_fine, y_original, y_yearly, y_approximation, mse, msek] = zadanie4(energy)
    country = 'Poland';
    source = 'Coal'; 
    degrees = 1:4;
    x_coarse = [];
    x_fine = [];
    y_original = [];
    y_yearly = [];
    y_approximation = [];
    mse = [];
    msek = [];

    if isfield(energy, country) && isfield(energy.(country), source)
        dates = energy.(country).(source).Dates;
        y_original = energy.(country).(source).EnergyProduction;

        n_years = floor(length(y_original) / 12);
        y_cut = y_original(end-12*n_years+1:end);
        y4sum = reshape(y_cut, [12 n_years]);
        y_yearly = sum(y4sum,1)';

        N = length(y_yearly);
        P = (N-1)*10+1;
        x_coarse = linspace(-1, 1, N)';
        x_fine = linspace(-1, 1, P)';

        y_approximation = cell(1, N-1);
        mse = zeros(N-1, 1);
        msek = zeros(N-2, 1);

        for i = 1:N-1
            p = my_polyfit(x_coarse, y_yearly, i);
            y_fit = polyval(p, x_coarse);
            y_fine = polyval(p, x_fine);

            y_approximation{i} = y_fine;
            mse(i) = mean((y_yearly - y_fit).^2);
        end

        for i = 1:N-2
            msek(i) = mean((y_approximation{i} - y_approximation{i+1}).^2);
        end

        figure;
        subplot(3, 1, 1);
        plot(x_coarse, y_yearly);
        hold on;
        for i = 1:length(degrees)
            plot(x_fine, y_approximation{degrees(i)});
        end
        legend('Dane', 'Stopien 1', 'Stopien 2', 'Stopien 3', 'Stopien 4');
        title('Roczna produkcja energi i jej Wielomianowe przybilzenie');
        xlabel("Data")
        ylabel("tWh")


        subplot(3, 1, 2);
        semilogy(1:N-1, mse);
        title('MSE dla stopni wielomianu');
        xlabel('Stopnie wielomianu');
        ylabel('MSE');

        subplot(3, 1, 3);
        semilogy(1:N-2, msek);
        title('Zbieżność Funkcji Aproksymujących');
        xlabel('Stopień Wielomianu');
        ylabel('Błąd Różnicowy');

        saveas(gcf, 'zadanie4.png');
    else
        disp(['Dane dla (country=', country, ') oraz (source=', source, ') nie są dostępne.']);
    end
end
function p = my_polyfit(x, y, deg)

    A = zeros(length(x), deg + 1);
    for i = 1:deg + 1
        A(:, i) = x.^(deg + 1 - i);
    end
    

    p = (A' * A) \ (A' * y);
end