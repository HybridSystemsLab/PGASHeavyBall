function timeToConvF(xvaluef,tvaluef)

global delta z1Star1 z1Star2 z1Star3 z1Star4 timeToDelta_f timeToDeltaIdx_f z1delta_f z2delta_f

% Finding time of convergence for IC: (31,0,0):
    for i=2:length(xvaluef(:,1))
        if (((abs(z1Star2 - xvaluef(i,1)) <= delta) && (abs(z1Star2 - xvaluef(i-1,1)) > delta)) || ((abs(z1Star1 - xvaluef(i,1)) <= delta) && (abs(z1Star1 - xvaluef(i-1,1)) > delta)) ...
                || ((abs(z1Star3 - xvaluef(i,1)) <= delta) && (abs(z1Star3 - xvaluef(i-1,1)) > delta)) || ((abs(z1Star4 - xvaluef(i,1)) <= delta) && (abs(z1Star4 - xvaluef(i-1,1)) > delta)))
            timeToDeltaIdx_f = i;
            z1delta_f = xvaluef(i,1);
        end
    end
    z2delta_f = xvaluef(timeToDeltaIdx_f,2);
    timeToDelta_f = tvaluef(timeToDeltaIdx_f,1);

end