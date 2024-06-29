function velocity_delta = rocket_velocity(t)
% velocity_delta - różnica pomiędzy prędkością rakiety w czasie t oraz zadaną prędkością M
% t - czas od rozpoczęcia lotu rakiety dla którego ma być wyznaczona prędkość rakiety
M = 750; % [m/s]
u = 2000;
q = 2700;
m0 = 150000;
g = 1.622;

if t <= 0
    error('Time cannot be ')
end

velocity_delta = u * log(m0/(m0 - q*t)) - g*t - M;


end