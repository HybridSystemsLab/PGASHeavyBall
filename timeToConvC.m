function timeToConvC(xvaluec,tvaluec)

global delta z1Star1 z1Star2 z1Star3 z1Star4 timeToDelta_c timeToDeltaIdx_c z1delta_c z2delta_c

% Finding time of convergence for IC: (26.18,0,0):
    for i=2:length(xvaluec(:,1))
        if (((abs(z1Star2 - xvaluec(i,1)) <= delta) && (abs(z1Star2 - xvaluec(i-1,1)) > delta)) || ((abs(z1Star1 - xvaluec(i,1)) <= delta) && (abs(z1Star1 - xvaluec(i-1,1)) > delta)) ...
                || ((abs(z1Star3 - xvaluec(i,1)) <= delta) && (abs(z1Star3 - xvaluec(i-1,1)) > delta)) || ((abs(z1Star4 - xvaluec(i,1)) <= delta) && (abs(z1Star4 - xvaluec(i-1,1)) > delta)))
            timeToDeltaIdx_c = i;
            z1delta_c = xvaluec(i,1);
        end
    end
    z2delta_c = xvaluec(timeToDeltaIdx_c,2);
    timeToDelta_c = tvaluec(timeToDeltaIdx_c,1); 

end