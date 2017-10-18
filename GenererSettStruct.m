function [sett_struct] = GenererSettStruct(datasett, aktive_egenskaper)

    nytt_datasett = zeros(size(datasett, 1), 1+nnz(aktive_egenskaper));
    nytt_datasett(:,1) = datasett(:,1);
    for k = 1:nnz(aktive_egenskaper)
        nytt_datasett(:,k+1) = datasett(:,aktive_egenskaper(k)+1);

    end



    
    treningsett = nytt_datasett(1:2:size(nytt_datasett),:);
    testsett = nytt_datasett(2:2:size(nytt_datasett),:);

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

    [N, M] = size(testsett);


    klassifisert = [zeros(N, 1) testsett];


    sett_struct = struct('treningsett', treningsett, 'testsett', testsett, 'treningsett_klasse1', treningsett_klasse1, 'treningsett_klasse2', treningsett_klasse2, 'klassifisert', klassifisert);

end


