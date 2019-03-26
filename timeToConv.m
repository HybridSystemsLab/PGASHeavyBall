function deltaVec = timeToConv(xvalue,tvalue)

global delta z1Star1 z1Star2 z1Star3 z1Star4

z1delta = 0;
timetoDeltaIdx = 0;

% Finding time of convergence for IC: (15,0,0):
    for i=2:length(xvalue(:,1))
        if (((abs(z1Star2 - xvalue(i,1)) <= delta) && (abs(z1Star2 - xvalue(i-1,1)) > delta)) || ((abs(z1Star1 - xvalue(i,1)) <= delta) && (abs(z1Star1 - xvalue(i-1,1)) > delta)) ...
                || ((abs(z1Star3 - xvalue(i,1)) <= delta) && (abs(z1Star3 - xvalue(i-1,1)) > delta)) || ((abs(z1Star4 - xvalue(i,1)) <= delta) && (abs(z1Star4 - xvalue(i-1,1)) > delta)))
            timeToDeltaIdx = i;
            z1delta = xvalue(i,1);
        end
    end
    deltaVec(1) = z1delta;
    deltaVec(2) = xvalue(timeToDeltaIdx,2);
    deltaVec(3) = tvalue(timeToDeltaIdx,1); 
end