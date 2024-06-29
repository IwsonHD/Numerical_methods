function [lake_volume, x, y, z, zmin] = zadanie5()
    N = 1e6;
    zmin = -60;
    x = 100*rand(1,N); % [m]
    y = 100*rand(1,N); % [m]
    z = zmin*rand(1,N);
    volume = 100 * 100 * 60;
    depth = get_lake_depth(x,y);
    N1 = 0
    for i = 1:N
        if z(i) >= depth(i)
            N1 = N1 + 1;
        end
    end
    lake_volume = volume * N1/N;
end

