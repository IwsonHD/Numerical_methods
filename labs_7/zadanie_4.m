function [integration_error, Nt, ft_5, xr, yr, yrmax] = zadanie4()
    mu = 10;
    sigma = 3;
    reference_value = 0.0473612919396179;
    Nt = 5:50:10^4;
    integration_error = zeros(1, length(Nt));
    ft_5 = failure_density_function(5, mu, sigma);
    xr = cell(1, length(Nt));
    yr = cell(1, length(Nt));
    yrmax = 1.2 * ft_5;

    for i = 1:length(Nt)
        xr{i} = rand(1, Nt(i)) * 5;
        yr{i} = rand(1, Nt(i)) * yrmax;
        integration_result = monte_carlo_integration(@(t) failure_density_function(t, mu, sigma), xr{i}, yr{i}, yrmax);
        integration_error(i) = abs(integration_result - reference_value);
    end

    figure;
    loglog(Nt, integration_error);
    xlabel('Liczba losowań (N)');
    ylabel('Błąd całkowania');
    title('Błąd całkowania dla metody Monte Carlo');
    grid on;
    saveas(gcf, 'zadanie4.png');
end

function ft = failure_density_function(t, mu, sigma)
    ft = (1 / (sigma * sqrt(2 * pi))) * exp(-((t - mu).^2) / (2 * sigma^2));
end

function integral = monte_carlo_integration(func, xr, yr, yrmax)
    N = length(xr);
    sum_values = 0;
    for i = 1:N
        if yr(i) <= func(xr(i))
            sum_values = sum_values + 1;
        end
    end
    integral =5 *yrmax* sum_values / N;
end