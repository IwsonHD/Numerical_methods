function [circles, index_number, circle_areas, rand_counts, counts_mean] = generate_circles(a, r_max, n_max)
    index_number = 193066;
    L1 = mod(index_number, 10);
    L2 = idivide(mod(index_number, 100),int16(10),"floor");
    circles = zeros(1, 3);
    
    circle_areas = zeros(1, n_max);
    rand_counts = zeros(1, n_max);
    counts_mean = zeros(1, n_max);

    rand_count = 0;
    circle_num = 1;

    while n_max >= height(circles)
        R = r_max * rand * (1 - eps);
        %X = -1;
        %Y = -1;
        X = rand * (a - 2*R) + R;
        Y = rand * (a - 2*R) + R;
        %while 1
        %  X = rand * (a - R) + R;
        %  Y = rand * (a - R) + R;
        %  if X  < a - R && Y  < a - R && X > R && Y > R
        %      break;
        %  end
        %end
        
        correct_circle = true;

        for i = 1:height(circles)
            rand_count = rand_count + 1;
            x = circles(i, 1);
            y = circles(i, 2);
            r = circles(i, 3);
            if r == 0
                continue
            end
            mid_distance = sqrt((X - x)^2 + (Y - y)^2);
            if mid_distance <= r + R
                correct_circle = false;
                break;
            end
        end

        if correct_circle 
            circles = [circles; [X,Y,R]];
            rand_counts(1, circle_num) = rand_count;

            circle_num = circle_num + 1;
            rand_count = 0;
        end
    end
    circles(1,:) = []; 
    
    circle_areas = zeros(1, n_max);  
    for i = 1:n_max
        circle_areas(i) = sum((circles(1:i, 3).^2) * pi);
        counts_mean(i) = mean(rand_counts(1,1:i));
    end

    
end
