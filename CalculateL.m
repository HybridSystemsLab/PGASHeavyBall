function L = CalculateL(z1)
global z1Star1 z1Star2 z1Star3 z1Star4 

L = 0.0001*(z1-z1Star1)^2*(z1-z1Star2)^2*(z1-z1Star3)^2*(z1-z1Star4)^2;

end