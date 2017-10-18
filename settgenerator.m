function [sett_struct] = SettGenerator(datasett)
    

    treningsett = datasett(1:2:size(datasett),:);
    testsett = datasett(2:2:size(datasett),:);

    %splitter datasett og treningsett 
    for i = 1:size(treningsett),
        if (treningsett(i,1) == 1)
            if exist('treningsett_klasse1')
                treningsett_klasse1 = [treningsett_klasse1; treningsett(i,:)];
            else
                treningsett_klasse1 = treningsett(i,:);
            end
        else if (treningsett(i,1) == 2)
            if exist('treningsett_klasse2')
                treningsett_klasse2 = [treningsett_klasse2; treningsett(i,:)];
            else
                treningsett_klasse2 = treningsett(i,:);
            end
            end
        end   
    end
    
    klassifisert = [zeros(N, 1) testsett];


    sett_struct = struct('treningsett', treningsett, 'testsett', testsett,...
        'treningsett_klasse1', treningsett_klasse1, 'treningsett_klasse2', ...
        treningsett_klasse2, 'klassifisert', klassifisert);

end


