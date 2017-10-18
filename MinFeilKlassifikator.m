function [klassifisert] = MinFeilKlassifikator(sett_struct)
    
    [N, M] = size(sett_struct.treningsett);
    [N1, M1] = size(sett_struct.treningsett_klasse1);
    [N2, M2] = size(sett_struct.treningsett_klasse2);
    [N_test, M_test] = size(sett_struct.testsett);
    
    x_1 = sett_struct.treningsett_klasse1(:,2:M)';
    x_2 = sett_struct.treningsett_klasse2(:,2:M)';
    x_testsett = sett_struct.testsett(:,2:M)';
    sum1 = sum(x_1');
    mu_klasse1 = 1/N1*sum1';

    sum2 = sum(x_2');
    mu_klasse2 = 1/N2*sum2';

    zigma_klasse1 = zeros(size(x_1, 1));
    for k = 1:N1
        zigma_klasse1 = zigma_klasse1 + 1/N1*((x_1(:, k)-mu_klasse1)*(x_1(:, k)-mu_klasse1)');
    end

    zigma_klasse2 = zeros(size(x_2, 1));
    for k = 1:N2
        zigma_klasse2 = zigma_klasse2 + 1/N2*((x_2(:, k)-mu_klasse2)*(x_2(:, k)-mu_klasse2)');
    end

    W_klasse1 = -0.5*inv(zigma_klasse1);
    W_klasse2 = -0.5*inv(zigma_klasse2);

    w_klasse1 = inv(zigma_klasse1)*mu_klasse1;
    w_klasse2 = inv(zigma_klasse2)*mu_klasse2;

    w0_klasse1= -0.5*mu_klasse1'*inv(zigma_klasse1)*mu_klasse1-0.5*log(det(zigma_klasse1))+log(N1/(N1+N2));
    w0_klasse2= -0.5*mu_klasse2'*inv(zigma_klasse2)*mu_klasse2-0.5*log(det(zigma_klasse2))+log(N2/(N1+N2));


    for i = 1:N_test
        g1 = x_testsett(:, i)'*W_klasse1*x_testsett(:, i) + w_klasse1' * x_testsett(:, i) + w0_klasse1; 
        g2 = x_testsett(:, i)'*W_klasse2*x_testsett(:, i) + w_klasse2' * x_testsett(:, i) + w0_klasse2; 


       if g1-g2 >= 0
           sett_struct.klassifisert(i,1) = 1;
       else
           sett_struct.klassifisert(i,1) = 2;
       end
    end
    klassifisert = sett_struct.klassifisert;



end
