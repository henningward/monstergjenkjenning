function [feilrate] = FeilRateEstimator(sett_struct)


    con_matrx = zeros(2, 2);
    [N, M] = size(sett_struct.testsett);

    for i = 1:N
        sann_verdi = sett_struct.klassifisert(i,2);
        klassifisert_verdi = sett_struct.klassifisert(i,1);
        con_matrx(klassifisert_verdi, sann_verdi) = con_matrx(klassifisert_verdi, sann_verdi) + 1;
    end

    feilrate = 0.5*con_matrx(2, 1)/(con_matrx(1,1)+con_matrx(2, 1))...
        + 0.5*con_matrx(1, 2)/(con_matrx(1,2)+con_matrx(2, 2));
end