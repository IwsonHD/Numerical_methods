function [integration_error, Nt, ft_5, integral_1000] = zadanie3()

    mu = 10;
    sigma = 3;
    reference_value = 0.0473612919396179;

    Nt = 5:50:10^4;
    integration_error = zeros(1, length(Nt));

    ft_5 = failure_density_function(5, mu, sigma);
    integral_1000 = simpson_integration(@(t) failure_density_function(t, mu, sigma), 0, 5, 1000);

    for i = 1:length(Nt)
        integration_result = simpson_integration(@(t) failure_density_function(t, mu, sigma), 0, 5, Nt(i));
        integration_error(i) = abs(integration_result - reference_value);
    end

    figure;
    loglog(Nt, integration_error);
    xlabel('Liczba podprzedziałów (N)');
    ylabel('Błąd całkowania');
    title('Błąd całkowania dla metody Simpsona');
    grid on;
    saveas(gcf, 'zadanie3.png');
end

function ft = failure_density_function(t, mu, sigma)
    ft = (1 / (sigma * sqrt(2 * pi))) * exp(-((t - mu).^2) / (2 * sigma^2));
end

function integral = simpson_integration(func, a, b, N)
    dx = (b - a) / N;
    integral = 0;
    for i = 1:N
        x_i = a + (i - 1) * dx;
        x_ipo = a + i * dx;
        integral = integral + dx / 6 * (func(x_i) + 4 * func((x_i + x_ipo) / 2) + func(x_ipo));
    end
end
