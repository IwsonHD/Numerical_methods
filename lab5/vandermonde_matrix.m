function V = vandermonde_matrix(N)
    
    x_coarse = linspace(-1, 1, N);
    
    
    V = zeros(N, N);
    
    for i = 1:N
        for j = 1:N
            V(i, j) = x_coarse(i) ^ (j - 1);
        end
    end
end