function timeToConvD(xvalued,tvalued)

global delta z1Star1 z1Star2 z1Star3 z1Star4 timeToDelta_d timeToDeltaIdx_d z1delta_d z2delta_d

% Finding time of convergence for IC: (6,0,0):
    for i=2:length(xvalued(:,1))
        if (((abs(z1Star2 - xvalued(i,1)) <= delta) && (abs(z1Star2 - xvalued(i-1,1)) > delta)) || ((abs(z1Star1 - xvalued(i,1)) <= delta) && (abs(z1Star1 - xvalued(i-1,1)) > delta)) ...
                || ((abs(z1Star3 - xvalued(i,1)) <= delta) && (abs(z1Star3 - xvalued(i-1,1)) > delta)) || ((abs(z1Star4 - xvalued(i,1)) <= delta) && (abs(z1Star4 - xvalued(i-1,1)) > delta)))
            timeToDeltaIdx_d = i;
            z1delta_d = xvalued(i,1);
        end
    end
    z2delta_d = xvalued(timeToDeltaIdx_d,2);
    timeToDelta_d = tvalued(timeToDeltaIdx_d,1); 

end