function timeToConvG(xvalueg,tvalueg)

global delta z1Star1 z1Star2 z1Star3 z1Star4 timeToDelta_g timeToDeltaIdx_g z1delta_g z2delta_g

    for i=2:length(xvalueg(:,1))
        if (((abs(z1Star2 - xvalueg(i,1)) <= delta) && (abs(z1Star2 - xvalueg(i-1,1)) > delta)) || ((abs(z1Star1 - xvalueg(i,1)) <= delta) && (abs(z1Star1 - xvalueg(i-1,1)) > delta)) ...
                || ((abs(z1Star3 - xvalueg(i,1)) <= delta) && (abs(z1Star3 - xvalueg(i-1,1)) > delta)) || ((abs(z1Star4 - xvalueg(i,1)) <= delta) && (abs(z1Star4 - xvalueg(i-1,1)) > delta)))
            timeToDeltaIdx_g = i;
            z1delta_g = xvalueg(i,1);
        end
    end
    z2delta_g = xvalueg(timeToDeltaIdx_g,2);
    timeToDelta_g = tvalueg(timeToDeltaIdx_g,1);
    
end