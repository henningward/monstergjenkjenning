clearvars -except datasett1 datasett2 datasett3
clc
clear all
%datasett = importdata('ds-1.txt');
datasett = importdata('ds-2.txt');
%datasett = importdata('ds-3.txt');

[N, M] = size(datasett);



%genererer matrise med alle kombinasjoner av aktive egenskaper
aktive_egenskaper = zeros(1, M-1);
v = 1:M-1;
for i = 1:M-1
    [temp, ~] = size(nchoosek(v,i));
    if exist('C')
        C = [C; [nchoosek(v,i) zeros(temp, M-1-i)]];
    else
        C = [nchoosek(v,i) zeros(temp, M-1-i)];
    end

end

%matrise for feilraten gitt alle ulike egenskapskombinasjoner
%[feilrate egenskap1, egenskap2, ...., egenskap d]
feilrate_matrise = zeros(size(C, 1), M);
feilrate_matrise(:,2:M) = C(:,1:M-1);

%estimere feilrate matrise for alle egenskapskombinasjoner
for j = 1:size(C)
    aktive_egenskaper = C(j, :);
    sett_struct = GenererSettStruct(datasett, aktive_egenskaper);
    sett_struct.klassifisert    = NaermesteNaboKlassifikator(sett_struct);    
    feilrate_matrise(j,1)       = FeilRateEstimator(sett_struct);  
end

%plukker ut beste egenskapsvektorkombinasjon
best_feilrate = [inf inf inf inf];
for k = 1:size(feilrate_matrise)
    if feilrate_matrise(k,1) < best_feilrate(1)
        best_feilrate = feilrate_matrise(k,:);
        feilrate_naermste_nabo = best_feilrate(1);
    end
end

%tilpasser structen til de beste egenskapene
sett_struct = GenererSettStruct(datasett, best_feilrate(2:M));


%bruker beste egenskapsvektor p? minste kvadraters metode
sett_struct.klassifisert = MinsteKvadratersMetode(sett_struct);
feilrate_minste_kvadraters = FeilRateEstimator(sett_struct); 

%bruker beste egenskapsvektor p? Minimum feilrate klasifikatoren
klassifisert = MinFeilKlassifikator(sett_struct);
sett_struct.klassifisert = klassifisert;
feilrate_minimum_feilrate = FeilRateEstimator(sett_struct); 




for i = 1:size(datasett),
        if (datasett(i,1) == 1)
            if exist('egenskap1_klasse1')
                egenskap1_klasse1 = [egenskap1_klasse1; datasett(i,2)];
                egenskap2_klasse1 = [egenskap2_klasse1; datasett(i,3)];
                egenskap3_klasse1 = [egenskap3_klasse1; datasett(i,4)];
            else
                egenskap1_klasse1 = datasett(i,2);
                egenskap2_klasse1 = datasett(i,3);
                egenskap3_klasse1 = datasett(i,4);
            end
        else if (datasett(i,1) == 2)
            if exist('egenskap1_klasse2')
                egenskap1_klasse2 = [egenskap1_klasse2; datasett(i,2)];
                egenskap2_klasse2 = [egenskap2_klasse2; datasett(i,3)];
                egenskap3_klasse2 = [egenskap3_klasse2; datasett(i,4)];
            else
                egenskap1_klasse2 = datasett(i,2);
                egenskap2_klasse2 = datasett(i,3);
                egenskap3_klasse2 = datasett(i,4);
            end
            end
        end   
end

figure(1)
scatter(egenskap1_klasse1, egenskap2_klasse1, 'MarkerFaceColor', 'r'); hold on;
scatter(egenskap1_klasse2, egenskap2_klasse2, 'MarkerFaceColor', 'b'); hold off;
legend('klasse 1', 'klasse 2');
xlabel('egenskap 1');
ylabel('egenskap 2');

figure(2)
scatter(egenskap2_klasse1, egenskap3_klasse1, 'MarkerFaceColor', 'r'); hold on;
scatter(egenskap2_klasse2, egenskap3_klasse2, 'MarkerFaceColor', 'b'); hold off;
legend('klasse 1', 'klasse 2');
xlabel('egenskap 2');
ylabel('egenskap 3');

figure(3)
scatter(egenskap1_klasse1, egenskap3_klasse1, 'MarkerFaceColor', 'r'); hold on;
scatter(egenskap1_klasse2, egenskap3_klasse2, 'MarkerFaceColor', 'b'); hold off;
legend('klasse 1', 'klasse 2')
xlabel('egenskap 1');
ylabel('egenskap 3');




