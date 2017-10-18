
function [klassifisert] = NaermesteNaboKlassifikator(sett_struct)
%finner storrelser paa treningssett og testsett
    
[N, M] = size(sett_struct.testsett);
[N1, M1] = size(sett_struct.treningsett_klasse1);
[N2, M2] = size(sett_struct.treningsett_klasse2);

xtemp = zeros(M, 1);
xtemp_klasse1 = zeros (M1, 1);
xtemp_klasse2 = zeros (M2, 1); 

for x = 1:N
    min_klasse1 = inf;
    min_klasse2 = inf;
    
    xtemp = sett_struct.testsett(x, 2:M)';
    
    %beregner naermeste avstand til klasse1 objekt i treningsettet
    for i = 1:N1
        xtemp_klasse1 = sett_struct.treningsett_klasse1(i ,2:M1)';
        
        if norm(xtemp - xtemp_klasse1) < min_klasse1
            min_klasse1 = norm(xtemp - xtemp_klasse1);
        end
    end
    
        for i = 1:N2
        xtemp_klasse2 = sett_struct.treningsett_klasse2(i ,2:M2)';
        
        if norm(xtemp - xtemp_klasse2) < min_klasse2
            min_klasse2 = norm(xtemp - xtemp_klasse2);
        end
        end
    
    if min_klasse1 <= min_klasse2
        sett_struct.klassifisert(x, 1) = 1;
    else
        sett_struct.klassifisert(x, 1) = 2;
    end
    klassifisert = sett_struct.klassifisert;
end




