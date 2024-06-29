function [A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Gauss_Seidel(N)
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
x = ones(N,1);
time = [];
iterations = 0;
err_norm = 1;
[A,b] = generate_matrix(N,L1);
L = tril(A, -1);
U = triu(A, 1);
D = diag(diag(A));
M = -(D+L)\U;
bm = (D+L)\b;
tic();
while err_norm > 10e-12 && iterations <= 1000
    iterations = iterations + 1;
    x = M*x + bm;
    err_norm = norm(A*x - b);
end
time = toc();
end