function [integration_error, Nt, ft_5, integral_1000] = zadanie1()
    mu = 10;
    sigma = 3;
    reference_value = 0.0473612919396179;
    Nt = 5:50:10000;
    integration_error = zeros(1, length(Nt));
    ft_5 = failuer_density_function(5, mu, sigma);
    integral_1000 = rect_integration(@(t) failuer_density_function(t, mu, sigma), 0, 5, 1000);

    for i = 1:length(Nt)
        integration_result = rect_integration(@(t) failuer_density_function(t, mu, sigma), 0, 5, Nt(i));
        integration_error(i) = abs(integration_result - reference_value);
    end

    figure;
    loglog(Nt, integration_error);
    xlabel('Liczba podprzedziałów');
    ylabel('Błąd całkowania');
    title('Błąd całkowania metodą prostokątów');
    grid on;
    saveas(gcf, 'zadanie1.png');
end

function y = failuer_density_function(t, mu, sigma)
    y = (1 / (sigma * sqrt(2 * pi))) * exp(-((t - mu).^2) / (2 * sigma^2));
end

function integral = rect_integration(func, a, b, N)
    x_vals = linspace(a, b, N+1);
    dx = (b - a) / N;
    integral = sum(func((x_vals(1:end-1) + x_vals(2:end)) / 2)) * dx;
end
