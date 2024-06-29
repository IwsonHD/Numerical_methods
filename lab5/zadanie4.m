function [M, N, P, R, x_coarse, y_coarse, F_coarse, x_fine, y_fine, F_fine] = zadanie4()
    
    P = 20;  % liczba unikalnych współrzędnych x punktów dla interpolacji (siatka gęsta)
    R = 20;  % liczba unikalnych współrzędnych y punktów dla interpolacji (siatka gęsta)
    
    M = 5;  % liczba węzłów interpolacji wzdłuż osi X 
    N = 5;  % liczba węzłów interpolacji wzdłuż osi Y 
    
    
    x_coarse = linspace(0, 1, M);
    y_coarse = linspace(0, 1, N);
    [X_coarse, Y_coarse] = meshgrid(x_coarse, y_coarse);
    
    
    F_coarse = sin(pi * X_coarse) .* cos(2 * pi * Y_coarse);
    
    
    MN = M * N;
    xvec_coarse = reshape(X_coarse, MN, 1);
    yvec_coarse = reshape(Y_coarse, MN, 1);
    fvec_coarse = reshape(F_coarse, MN, 1);
    
    
    V = zeros(M*N, M * N);
    idx = 1;
    for i = 0:(M - 1)
        for j = 0:(N - 1)
            V(:, idx) = (xvec_coarse .^ i) .* (yvec_coarse .^ j);
            idx = idx + 1;
        end
    end
    
    
    coeffs = V \ fvec_coarse;
    
    
    x_fine = linspace(0, 1, P);
    y_fine = linspace(0, 1, R);
    [X_fine, Y_fine] = meshgrid(x_fine, y_fine);
    
    
    F_fine = zeros(size(X_fine));
    idx = 1;
    for i = 0:(M - 1)
        for j = 0:(N - 1)
            
            F_fine = F_fine + coeffs(idx) * (X_fine .^ i) .* (Y_fine .^ j);
            idx = idx + 1;
        end
    end
    
    
    figure;
    
    subplot(2,1,1);
    surf(X_coarse, Y_coarse, F_coarse);
    title('Wartości funkcji oryginalnej w węzłach');
    xlabel('x');
    ylabel('y');
    zlabel('F_coarse');
   
    subplot(2,1,2);
    surf(X_fine, Y_fine, F_fine);
    title('Wartości funkcji interpolacyjnej na gęstszej siatce');
    xlabel('x');
    ylabel('y');
    zlabel('F_fine');
    
    
    saveas(gcf, 'zadanie4.png');
end
