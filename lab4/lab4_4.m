a = 1;
b = 50;
ytolerance = 1e-12;
max_iterations = 100;
fun = @impedance_magnitude;
[omega_secant, ysolution_secant, iterations_secant, xtab_secant, xdif_secant] = secant_method(a, b, max_iterations, ytolerance, fun);
[omega_bisection, ysolution_bisection, iterations_bisection, xtab_bisection, xdif_bisection] = bisection_method(a, b, max_iterations, ytolerance, fun);

subplot(2, 1, 1);
plot(1:iterations_secant, xtab_secant,'-','DisplayName', 'Secant');
hold on;
plot(1:iterations_bisection, xtab_bisection,'-', 'DisplayName', 'Bisection');
hold off;
xlabel('Iterations');
ylabel('X candidate values');
title('X candidate values changing between iterations');
legend;

% Wykres dla xdif
subplot(2, 1, 2);
semilogy(1:(iterations_secant-1), xdif_secant, '-','DisplayName','Secant');
hold on;
semilogy(1:(iterations_bisection-1), xdif_bisection,'-','DisplayName', 'Bisection');
hold off;
xlabel('Iterations');
ylabel('Difference of subsequent X candidates');
title('Difference of subsequent X candidates');
legend;
