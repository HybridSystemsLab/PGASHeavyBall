function GradL = GradientL(z1)
global z1Star1 z1Star2 z1Star3 z1Star4 

GradL = 0.0001*(2*z1 - 2*z1Star1)*(z1 - z1Star2)^2*(z1 - z1Star3)^2*(z1 - z1Star4)^2 + 0.0001*(2*z1 - 2*z1Star2)*(z1 - z1Star1)^2*(z1 - z1Star3)^2*(z1 - z1Star4)^2 + 0.0001*(2*z1 - 2*z1Star3)*(z1 - z1Star1)^2*(z1 - z1Star2)^2*(z1 - z1Star4)^2 + 0.0001*(2*z1 - 2*z1Star4)*(z1 - z1Star1)^2*(z1 - z1Star2)^2*(z1 - z1Star3)^2;

end