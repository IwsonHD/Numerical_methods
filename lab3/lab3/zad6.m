data = load('filtr_dielektryczny.mat');

%[err_norms_Jacobi, iterations_Jacobi] = solve_Jacobi(data.A, data.b);
[err_norm_Gauss_Seidel,err_norms_Gauss_Seidel, iterations_Gauss_Seidel] = solve_Gauss_Seidel_6(data.A, data.b);
subplot(2,1,1)
plot(err_norms_Gauss_Seidel);
title('error normalizations of Gauss_Seidel')
err_norm_Gauss_Seidel
subplot(2,1,2)
[err_norm_Jacobi, err_norms_Jacobi, iterations_Jacobi] = solve_Jacobi_6(data.A, data.b);
plot(err_norms_Jacobi);
title('error normalizations of Jacobi')
err_norm_Jacobi
print -dpng zad6.png
[err_norm_direct, iterations_direct] = solve_direct_6(data.A, data.b);
err_norm_direct






















function [err_norm,err_norms, iterations] = solve_Jacobi_6(A,b)
% A - macierz z równania macierzowego A * x = b
% b - wektor prawej strony równania macierzowego A * x = b
% M - macierz pomocnicza opisana w instrukcji do Laboratorium 3
% bm - wektor pomocniczy opisany w instrukcji do Laboratorium 3
% x - rozwiązanie równania macierzowego
% err_norm - norma błędu rezydualnego rozwiązania x; err_norm = norm(A*x-b)
% time - czas wyznaczenia rozwiązania x
% iterations - liczba iteracji wykonana w procesie iteracyjnym metody Jacobiego
% index_number - Twój numer indeksu
index_number = 193066;
L1 = mod(index_number, 10);
x = ones(size(b,1),1);
iterations = 0;
err_norm = 1;
L = tril(A, -1);
U = triu(A, 1);
D = diag(diag(A));
D_inv = diag(1 ./ diag(D));
M = -D_inv*(L + U);
bm = D_inv*b;
err_norms = ones(1000);
tic();
while err_norm > 10e-12 && iterations <= 1000
    
    iterations = iterations + 1;
    err_norms(iterations) = err_norm;
    x = M*x + bm;
    err_norm = norm(A*x - b);
end
time = toc();
end






function [err_norm, err_norms, index_number] = solve_Gauss_Seidel_6(A,b)
% A - macierz rzadka z równania macierzowego A * x = b
% b - wektor prawej strony równania macierzowego A * x = b
% M - macierz pomocnicza opisana w instrukcji do Laboratorium 3 – sprawdź wzór (7) w instrukcji, który definiuje M jako M_{GS}
% bm - wektor pomocniczy opisany w instrukcji do Laboratorium 3 – sprawdź wzór (7) w instrukcji, który definiuje bm jako b_{mGS}
% x - rozwiązanie równania macierzowego
% err_norm - norma błędu rezydualnego rozwiązania x; err_norm = norm(A*x-b)
% time - czas wyznaczenia rozwiązania x
% iterations - liczba iteracji wykonana w procesie iteracyjnym metody Gaussa-Seidla
% index_number - Twój numer indeksu
index_number = 193066;
L1 = mod(index_number, 10);
x = ones(size(b,1),1);
time = [];
iterations = 0;
err_norm = 1;
L = tril(A, -1);
U = triu(A, 1);
D = diag(diag(A));
M = -(D+L)\U;
bm = (D+L)\b;
err_norms = ones(1000);
tic();
while err_norm > 10e-12 && iterations <= 1000
    iterations = iterations + 1;
    err_norms(iterations) = err_norm; 
    x = M*x + bm;
    err_norm = norm(A*x - b);
end
time = toc();
end














function [err_norm, index_number] = solve_direct_6(A,b)
% A - macierz z równania macierzowego A * x = b
% b - wektor prawej strony równania macierzowego A * x = b
% x - rozwiązanie równania macierzowego
% time_direct - czas wyznaczenia rozwiązania x
% err_norm - norma błędu rezydualnego rozwiązania x; err_norm = norm(A*x-b);
% index_number - Twój numer indeksu
index_number = 193066;
L1 = mod(index_number,10);

tic();
x = A\b;
time_direct = toc();
err_norm = norm(A*x - b);



end