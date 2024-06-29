function [integration_error, Nt, ft_5, integral_1000] = zadanie2()
    mu = 10;
    sigma = 3;
    reference_value = 0.0473612919396179;
    Nt = 5:50:10000;
    integration_error = zeros(1, length(Nt));

    ft_5 = failure_density_function(5, mu, sigma);
    integral_1000 = trapezoidal_integration(@(t) failure_density_function(t, mu, sigma), 0, 5, 1000);

    for i = 1:length(Nt)
        integration_result = trapezoidal_integration(@(t) failure_density_function(t, mu, sigma), 0, 5, Nt(i));
        integration_error(i) = abs(integration_result - reference_value);
    end

    figure;
    loglog(Nt, integration_error);
    xlabel('Liczba podprzedziałów');
    ylabel('Błąd całkowania');
    title('Błąd całkowania metodą trapezów');
    grid on;
    saveas(gcf, 'zadanie2.png');
end

function ft = failure_density_function(t, mu, sigma)
    ft = (1 / (sigma * sqrt(2 * pi))) * exp(-((t - mu).^2) / (2 * sigma^2));
end

function integral = trapezoidal_integration(func, a, b, N)
    x = linspace(a, b, N+1);
    dx = (b - a) / N;
    y = func(x);
    integral = (dx / 2) * (y(1) + 2 * sum(y(2:end-1)) + y(end));
end
