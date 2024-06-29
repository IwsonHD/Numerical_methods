function [numer_indeksu, Edges, I, B, A, b, r] = page_rank()
    d = 0.85;
    numer_indeksu = 193066;
    Edges = [1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 6, 6, 7, 8 ;
             8, 4, 6, 4, 5, 3, 5, 6, 7, 5, 6, 4, 6, 4, 7, 6, 7];
    I = speye(8);
    B = sparse(Edges(2,:), Edges(1,:), 1, 8, 8);
    A = spdiags((1./sum(B)).', 0, 8, 8);
    b = ones(8,1) * (1 - d)/8; 
    M = I - d * B * A;
    r = M\b;
    
    

end