function [klassifisert] = MinsteKvadratersMetode(sett_struct)

    %setter f?rste rad i treningssettet til 1 for ? tilpasse utvidet
    %egenskapsvektor
    temp_treningsett = sett_struct.treningsett;
    temp_treningsett(:,1) = ones(size(sett_struct.treningsett, 1), 1);
    [N, M] = size(sett_struct.treningsett);
    Y = [ones(size(sett_struct.testsett, 1), 1) sett_struct.treningsett(:,2:M)];
    b = zeros(size(sett_struct.testsett, 1), 1);

    for i = 1:size(sett_struct.testsett, 1)
        if sett_struct.treningsett(i, 1) == 1
            b(i) = 1;
        else 
            b(i) = -1;
        end

    end
    a = inv(Y'*Y)*Y'*b;
    temp_testsett = sett_struct.testsett;
    temp_testsett(:,1) = ones(size(sett_struct.testsett, 1), 1);
    g = a'*sett_struct.testsett';
    
    
    
    
    
    
    
    
    
    for i = 1:size(sett_struct.testsett, 1)
       if g(i) > 0
           sett_struct.klassifisert(i,1) = 1;
       else
           sett_struct.klassifisert(i,1) = 2;
       end
    end
    

    klassifisert = sett_struct.klassifisert;

    

end