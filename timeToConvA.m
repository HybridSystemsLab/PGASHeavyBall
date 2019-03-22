function timeToConvA(xvalue,tvalue)

global delta z1Star1 z1Star2 z1Star3 z1Star4 timeToDelta_a timeToDeltaIdx_a z1delta_a z2delta_a

% Finding time of convergence for IC: (15,0,0):
    for i=2:length(xvalue(:,1))
        if (((abs(z1Star2 - xvalue(i,1)) <= delta) && (abs(z1Star2 - xvalue(i-1,1)) > delta)) || ((abs(z1Star1 - xvalue(i,1)) <= delta) && (abs(z1Star1 - xvalue(i-1,1)) > delta)) ...
                || ((abs(z1Star3 - xvalue(i,1)) <= delta) && (abs(z1Star3 - xvalue(i-1,1)) > delta)) || ((abs(z1Star4 - xvalue(i,1)) <= delta) && (abs(z1Star4 - xvalue(i-1,1)) > delta)))
            timeToDeltaIdx_a = i;
            z1delta_a = xvalue(i,1);
        end
    end
    z2delta_a = xvalue(timeToDeltaIdx_a,2);
    timeToDelta_a = tvalue(timeToDeltaIdx_a,1); 
end