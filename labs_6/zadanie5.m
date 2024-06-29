function [country, source, degrees, x_coarse, x_fine, y_original, y_yearly, y_approximation, mse, msek] = zadanie5(energy)

country = 'Poland'; 
source = 'Coal'; 
degrees = [1, 3, 5, 7];
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
    y_original_mean = movmean(y_original,[11,0]);

    n_years = floor(length(y_original) / 12);
    y_cut = y_original(end-12*n_years+1:end);
    y4sum = reshape(y_cut, [12 n_years]);
    y_yearly = sum(y4sum,1)';

    N = length(y_yearly);
    P = (N-1)*8+1;
    x_coarse = linspace(0, 1, N)';
    x_fine = linspace(0, 1, P)';


    for i = 1:N
        X = dct2_custom(y_yearly, i);
        y_fit = idct2_custom(X, i, N, N);
        y_fine = idct2_custom(X, i, N, P);

        y_approximation{i} = y_fine;
        mse(i,1) = mean((y_yearly - y_fit).^2);
    end

    for i = 1:N-1
        msek(i,1) = mean((y_approximation{i} - y_approximation{i+1}).^2);
    end

    figure;
    subplot(3, 1, 1);
    plot(x_coarse, y_yearly, 'o');
    hold on;
    colors = ['r', 'g', 'b', 'm'];
    for i = 1:length(degrees)
        plot(x_fine, y_approximation{degrees(i)}, colors(i));
    end
    xlabel('Data')
    ylabel('tWh')
    legend('Dane', 'Stopień 1', 'Stopień 3', 'Stopień 5', 'Stopień 7');
    title('Roczna Produkcja Energii i Aproksymacje Cosinusowe');

    subplot(3, 1, 2);
    semilogy(1:N, mse);
    title('Średni Kwadrat Błędu dla Stopni Aproksymacji Cosinusowej');
    xlabel('Stopień Aproksymacji');
    ylabel('MSE');

    subplot(3, 1, 3);
    semilogy(1:N-1, msek);
    title('Zbieżność Funkcji Aproksymujących');
    xlabel('Stopień Aproksymacji');
    ylabel('Błąd Różnicowy');

    saveas(gcf, 'zadanie5.png');
else
    disp(['Dane dla (country=', country, ') oraz (source=', source, ') nie są dostępne.']);
end

end

function X = dct2_custom(x, kmax)
    N = length(x);
    X = zeros(kmax, 1);
    c2 = sqrt(2/N);
    c3 = pi/2/N;
    nn = (1:N)';

    X(1) = sqrt(1/N) * sum( x(nn) );
    for k = 2:kmax
        X(k) = c2 * sum( x(nn) .* cos(c3 * (2*(nn-1)+1) * (k-1)) );
    end
end

function x = idct2_custom(X, kmax, N, P)
    x = zeros(P, 1);
    kk = (2:kmax)';
    c1 = sqrt(1/N);
    c2 = sqrt(2/N);
    c3 = pi*(N - 1)/(2*N*(P - 1));
    c4 = -(pi*(N - P))/(2*N*(P - 1));

    for n = 1:P
        x(n) = c1*X(1) + c2*sum( X(kk) .* cos((c3*(2*(n-1)+1)+c4) * (kk-1)) );
    end
end
