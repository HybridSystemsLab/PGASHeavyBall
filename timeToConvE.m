function timeToConvE(xvaluee,tvaluee)

global delta z1Star1 z1Star2 z1Star3 z1Star4 timeToDelta_e timeToDeltaIdx_e z1delta_e z2delta_e

% Finding time of convergence for IC: (-1,0,0):
    for i=2:length(xvaluee(:,1))
        if (((abs(z1Star2 - xvaluee(i,1)) <= delta) && (abs(z1Star2 - xvaluee(i-1,1)) > delta)) || ((abs(z1Star1 - xvaluee(i,1)) <= delta) && (abs(z1Star1 - xvaluee(i-1,1)) > delta)) ...
                || ((abs(z1Star3 - xvaluee(i,1)) <= delta) && (abs(z1Star3 - xvaluee(i-1,1)) > delta)) || ((abs(z1Star4 - xvaluee(i,1)) <= delta) && (abs(z1Star4 - xvaluee(i-1,1)) > delta)))
            timeToDeltaIdx_e = i;
            z1delta_e = xvaluee(i,1);
        end
    end
    z2delta_e = xvaluee(timeToDeltaIdx_e,2);
    timeToDelta_e = tvaluee(timeToDeltaIdx_e,1); 

end