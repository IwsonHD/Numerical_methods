function plot_problem_5(N,time_Jacobi,time_Gauss_Seidel,iterations_Jacobi,iterations_Gauss_Seidel)
% Opis wektorów stanowiących parametry wejściowe:
% N - rozmiary analizowanych macierzy
% time_Jacobi - czasy wyznaczenia rozwiązania metodą Jacobiego
% time_Gauss_Seidel - czasy wyznaczenia rozwiązania metodą Gaussa-Seidla
% iterations_Jacobi - liczba iteracji wymagana do wyznaczenia rozwiązania metodą Jacobiego
% iterations_Gauss_Seide - liczba iteracji wymagana do wyznaczenia rozwiązania metodą Gauss-Seidla
n = length(N);
subplot(2,1,1);
hold on;

plot(N,time_Jacobi);
plot(N, time_Gauss_Seidel);
title('execution times');
xlabel('matrix size')
ylabel('time')
legend('time Jacobi', 'time Gauss Seidel',Location='eastoutside')
hold off;
subplot(2,1,2);
bar_data = [iterations_Jacobi(:), iterations_Gauss_Seidel(:)];
bar(N, bar_data);
title('iterations')
xlabel('matrix size')
ylabel('iterarions')
legend('iterations Jacobi', 'iterations Gauss Seidel', Location='eastoutside')
print -dpng zad5.png
end