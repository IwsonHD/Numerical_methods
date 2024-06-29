function [country, source, degrees, y_movemean, y_approximation, mse] = zadanie1(energy)
% Głównym celem tej funkcji jest wyznaczenie aproksymacji danych o produkcji energii elektrycznej w wybranym kraju i z wybranego źródła energii.
% Wybór kraju i źródła energii należy określić poprzez nadanie w tej funkcji wartości zmiennym typu string: country, source.
% Dopuszczalne wartości tych zmiennych można sprawdzić poprzez sprawdzenie zawartości struktury energy zapisanej w pliku energy.mat.
% 
% energy - struktura danych wczytana z pliku energy.mat
% country - [String] nazwa kraju
% source  - [String] źródło energii
% degrees - wektor zawierający cztery stopnie wielomianu dla których wyznaczono aproksymację
% y_original - dane wejściowe, czyli pomiary produkcji energii zawarte w wektorze energy.(country).(source).EnergyProduction
% y_approximation - tablica komórkowa przechowująca cztery wartości funkcji aproksymującej dane wejściowe. y_approximation stanowi aproksymację stopnia degrees(i).
% mse - wektor o rozmiarze 4x1: mse(i) zawiera wartość błędu średniokwadratowego obliczonego dla aproksymacji stopnia degrees(i).

country = 'Brazil';
source = 'Nuclear';
degrees = [1, 5, 19, 40];
degrees = unique(degrees);
y_original = [];
y_approximation= [];
mse = [];

% Sprawdzenie dostępności danych
if isfield(energy, country) && isfield(energy.(country), source)
    y_original = energy.(country).(source).EnergyProduction;
    dates = energy.(country).(source).Dates;
    y_movmean = movmean(y_original, [11,0]);
    x = linspace(-1,1,length(y_original))';
    for i = 1:length(degrees)
        p = polyfit(x, y_movmean, degrees(i));
        y_approximation{i} = polyval(p, x);
        mse(i) = immse(y_movmean, y_approximation{i});
    end
    

    figure;
    

    subplot(2,1,1);
    hold on;
    plot(dates, y_original, 'DisplayName', 'Oryginalne dane');
    plot(dates, y_movmean, 'DisplayName', 'Dane obrobione średnią kroczącą');
    for i = 1:length(degrees)
        plot(dates, y_approximation{i}, 'DisplayName', sprintf('Stopień %d', degrees(i)));
    end
    hold off;
    xlabel('Data');
    ylabel('Produkcja energii');
    title('Aproksymacja wielomianowa produkcji energii');
    legend('show');
    

    subplot(2,1,2);
    bar(mse);
    set(gca, 'XTickLabel', degrees);
    xlabel('Stopień wielomianu');
    ylabel('Błąd średniokwadratowy');
    title('Błąd średniokwadratowy dla różnych stopni wielomianu');
    

    saveas(gcf, 'labs_6/output_pngs/zadanie2.png');
    
else
    disp(['Dane dla (country=', country, ') oraz (source=', source, ') nie są dostępne.']);
end

end
