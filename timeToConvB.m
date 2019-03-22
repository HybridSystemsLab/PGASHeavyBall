function timeToConvB(xvalueb,tvalueb)

global delta z1Star1 z1Star2 z1Star3 z1Star4 timeToDelta_b timeToDeltaIdx_b z1delta_b z2delta_b

% Finding time of convergence for IC: (3.82,0,0):
    for i=2:length(xvalueb(:,1))
        if (((abs(z1Star2 - xvalueb(i,1)) <= delta) && (abs(z1Star2 - xvalueb(i-1,1)) > delta)) || ((abs(z1Star1 - xvalueb(i,1)) <= delta) && (abs(z1Star1 - xvalueb(i-1,1)) > delta)) ...
                || ((abs(z1Star3 - xvalueb(i,1)) <= delta) && (abs(z1Star3 - xvalueb(i-1,1)) > delta)) || ((abs(z1Star4 - xvalueb(i,1)) <= delta) && (abs(z1Star4 - xvalueb(i-1,1)) > delta)))
            timeToDeltaIdx_b = i;
            z1delta_b = xvalueb(i,1);
        end
    end
    z2delta_b = xvalueb(timeToDeltaIdx_b,2);
    timeToDelta_b = tvalueb(timeToDeltaIdx_b,1); 


end