function [M, N, P, R, x_coarse, y_coarse, F_coarse, x_fine, y_fine, F_fine] = zadanie5()
    M = 40;
    N = 40;
    P = 200;
    R = 200;
    
    x_coarse = linspace(0, 1, M);
    y_coarse = linspace(0, 1, N);
    [X_coarse, Y_coarse] = meshgrid(x_coarse, y_coarse);
    F_coarse =19 * sin(X_coarse * 2 * pi) .* abs(Y_coarse - 0.5);
    
    xvec_coarse = reshape(X_coarse, M*N, 1);
    yvec_coarse = reshape(Y_coarse, M*N, 1);
    fvec_coarse = reshape(F_coarse, M*N, 1);
    
    V = zeros(M * N, M * N);
    for i = 0:(M - 1)
        for j = 0:(N - 1)
            V(:, i * N + j + 1) = xvec_coarse .^ i .* yvec_coarse .^ j;
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
    
    subplot(1, 2, 1);
    mesh(x_coarse, y_coarse, F_coarse);
    title('F_coarse');
    xlabel('x');
    ylabel('y');
    zlabel('F_coarse');
    
    subplot(1, 2, 2);
    mesh(x_fine, y_fine, F_fine);
    title('F_fine');
    xlabel('x');
    ylabel('y');
    zlabel('F_fine');
    
    saveas(gcf, 'zadanie5.png');
end