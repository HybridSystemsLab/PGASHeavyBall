%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: HeavyBall.m
%--------------------------------------------------------------------------
% Project: Unifying local and global control, using the Heavy-Ball Method
% for convergence to a local minimum, when L is Morse. Different parameters 
% for lambda and gamma are used globally and locally. 
% And another switching variable is used, to increase z_2 when at an
% extremum.
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 05/20/2015 3:42:00

clear all

set(0,'defaultTextInterpreter','latex'); 

% global variables
global gamma lambda delta eps1 eps2 rho1 rho2 direction timeToDelta_a timeToDeltaIdx_a z1delta_a z2delta_a timeToDelta_b timeToDeltaIdx_b z1delta_b z2delta_b timeToDelta_c timeToDeltaIdx_c z1delta_c z2delta_c timeToDelta_d timeToDeltaIdx_d z1delta_d z2delta_d timeToDelta_e timeToDeltaIdx_e z1delta_e z2delta_e timeToDelta_f timeToDeltaIdx_f z1delta_f z2delta_f timeToDelta_g timeToDeltaIdx_g z1delta_g z2delta_g
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initializing the globals %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lambda = 130;
gamma = 3/4;

eps1 = 0.001;
eps2 = 0.002;

rho1 = 0.001;
rho2 = 0.002;

delta = 0.01;

setMinima();

%%%%%%%%%%%%%%%%%%%%%%
% setting the locals %
%%%%%%%%%%%%%%%%%%%%%%

timeToDelta_a = 0;
timeToDeltaIdx_a = 1;
z1delta_a = 0;
z2delta_a = 0;

timeToDelta_b = 0;
timeToDeltaIdx_b = 1;
z1delta_b = 0;
z2delta_b = 0;

timeToDelta_c = 0;
timeToDeltaIdx_c = 1;
z1delta_c = 0;
z2delta_c = 0;

timeToDelta_d = 0;
timeToDeltaIdx_d = 1;
z1delta_d = 0;
z2delta_d = 0;

timeToDelta_e = 0;
timeToDeltaIdx_e = 1;
z1delta_e = 0;
z2delta_e = 0;

timeToDelta_f = 0;
timeToDeltaIdx_f = 1;
z1delta_f = 0;
z2delta_f = 0;

timeToDelta_g = 0;
timeToDeltaIdx_g = 1;
z1delta_g = 0;
z2delta_g = 0;

% initial conditions
z1_a = 15;
z2_a = 0;
p_a = 0;

% Need to change this to sgn(z2)
direction = 0; 
while direction == 0
    direction = randi([-1,1]); 
end
a_a = sign(direction);

z1_b = 5*(3-sqrt(5));
z2_b = 0;
p_b = 0;

% Need to change this to sgn(z2)
direction = 0; 
while direction == 0
    direction = randi([-1,1]); 
end
a_b = sign(direction);

z1_c = 5*(3+sqrt(5));
z2_c = 0;
p_c = 0;
% Need to change this to sgn(z2)
direction = 0; 
while direction == 0
    direction = randi([-1,1]); 
end
a_c = sign(direction);

z1_d = 6;
z2_d = 0;
p_d = 0;
tau_d = 0;

% Need to change this to sgn(z2)
direction = 0; 
while direction == 0
    direction = randi([-1,1]); 
end
a_d = sign(direction);

z1_e = -1; 
z2_e = 0;
p_e = 0;
% Need to change this to sgn(z2)
direction = 0; 
while direction == 0
    direction = randi([-1,1]); 
end
a_e = sign(direction);

z1_f = 31; 
z2_f = 0;
p_f = 0;
% Need to change this to sgn(z2)
direction = 0; 
while direction == 0
    direction = randi([-1,1]); 
end
a_f = sign(direction);

z1_g = 24.5;
z2_g = 0;
p_g = 0;
% Need to change this to sgn(z2)
direction = 0; 
while direction == 0
    direction = randi([-1,1]); 
end
a_g = sign(direction);

% Assign initial conditions to vector
x0_a = [z1_a;z2_a;p_a;a_a];
x0_b = [z1_b;z2_b;p_b;a_b];
x0_c = [z1_c;z2_c;p_c;a_c];
x0_d = [z1_d;z2_d;p_d;a_d];
x0_e = [z1_e;z2_e;p_e;a_e];
x0_f = [z1_f;z2_f;p_f;a_f];
x0_g = [z1_g;z2_g;p_g;a_g];

% simulation horizon
TSPAN = [0 200];
JSPAN = [0 200];

% rule for jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
rule = 1;

options = odeset('RelTol',1e-6,'MaxStep',.1);

% simulate, IC: (15,0,0)
[ta,ja,xa] = HyEQsolver(@f,@g,@C,@D,...
    x0_a,TSPAN,JSPAN,rule,options);

% simulate, IC: (3.82,0,0)
[tb,jb,xb] = HyEQsolver(@f,@g,@C,@D,...
    x0_b,TSPAN,JSPAN,rule,options);

% simulate, IC: (26.18,0,0)
[tc,jc,xc] = HyEQsolver(@f,@g,@C,@D,...
    x0_c,TSPAN,JSPAN,rule,options);

% simulate, IC: (6,0,0)
[td,jd,xd] = HyEQsolver(@f,@g,@C,@D,...
    x0_d,TSPAN,JSPAN,rule,options);

% simulate, IC: (-1,0,0)
[te,je,xe] = HyEQsolver(@f,@g,@C,@D,...
    x0_e,TSPAN,JSPAN,rule,options);

% simulate, IC: (31,0,0)
[tf,jf,xf] = HyEQsolver(@f,@g,@C,@D,...
    x0_f,TSPAN,JSPAN,rule,options);

% simulate, IC: (31,0,0)
[tg,jg,xg] = HyEQsolver(@f,@g,@C,@D,...
    x0_g,TSPAN,JSPAN,rule,options);

timeToConvA(xa,ta);
timeToConvB(xb,tb);
timeToConvC(xc,tc);
timeToConvD(xd,td);
timeToConvE(xe,te);
timeToConvF(xf,tf);
timeToConvG(xg,tg);
    
%  % Prepare the data, to plot multiple hybrid arcs on same plane
 minarc = min([length(xa),length(xb),length(xc),length(xd),length(xe),length(xf),length(xg)]);
 t = [ta(1:minarc),tb(1:minarc),tc(1:minarc),td(1:minarc),te(1:minarc),tf(1:minarc),tg(1:minarc)];
 j = [ja(1:minarc),jb(1:minarc),jc(1:minarc),jd(1:minarc),je(1:minarc),jf(1:minarc),jg(1:minarc)];
 x1 = [xa(1:minarc,1),xb(1:minarc,1),xc(1:minarc,1),xd(1:minarc,1),xe(1:minarc,1),xf(1:minarc,1),xg(1:minarc,1)];
 x2 = [xa(1:minarc,2),xb(1:minarc,2),xc(1:minarc,2),xd(1:minarc,2),xe(1:minarc,2),xf(1:minarc,2),xg(1:minarc,2)];
    
% plot solution
figure(1) % position
clf
modificatorF{1} = '';
modificatorF{2} = 'LineWidth';
modificatorF{3} = 3;
modificatorJ{1} = '*--';
modificatorJ{2} = 'LineWidth';
modificatorJ{3} = 3;

subplot(2,1,1), plotHarc(t,j,x1,[],modificatorF,modificatorJ);
hold on
plot(timeToDelta_a,z1delta_a,'k.','MarkerSize', 20)
strDelta_a = [num2str(timeToDelta_a), 's'];
text(timeToDelta_a,z1delta_a,strDelta_a,'HorizontalAlignment','left','VerticalAlignment','bottom');
plot(timeToDelta_b,z1delta_b,'k.','MarkerSize', 20)
strDelta_b = [num2str(timeToDelta_b), 's'];
text(timeToDelta_b,z1delta_b,strDelta_b,'HorizontalAlignment','left','VerticalAlignment','top');
plot(timeToDelta_c,z1delta_c,'k.','MarkerSize', 20)
strDelta_c = [num2str(timeToDelta_c), 's'];
text(timeToDelta_c,z1delta_c,strDelta_c,'HorizontalAlignment','left','VerticalAlignment','top');
plot(timeToDelta_d,z1delta_d,'k.','MarkerSize', 20)
strDelta_d = [num2str(timeToDelta_d), 's'];
text(timeToDelta_d,z1delta_d,strDelta_d,'HorizontalAlignment','left','VerticalAlignment','top');
plot(timeToDelta_e,z1delta_e,'k.','MarkerSize', 20)
strDelta_e = [num2str(timeToDelta_e), 's'];
text(timeToDelta_e,z1delta_e,strDelta_e,'HorizontalAlignment','left','VerticalAlignment','top');
plot(timeToDelta_f,z1delta_f,'k.','MarkerSize', 20)
strDelta_f = [num2str(timeToDelta_f), 's'];
text(timeToDelta_f,z1delta_f,strDelta_f,'HorizontalAlignment','left','VerticalAlignment','top');
plot(timeToDelta_g,z1delta_g,'k.','MarkerSize', 20)
strDelta_g = [num2str(timeToDelta_g), 's'];
text(timeToDelta_g,z1delta_g,strDelta_g,'HorizontalAlignment','left','VerticalAlignment','top');
grid on
ylabel('$\mathrm{z_1}$','FontSize',16)
xlabel('$\mathrm{t}$','FontSize',16)
axis([0 6 -10 35]);
subplot(2,1,2), plotHarc(t,j,x2,[],modificatorF,modificatorJ);
hold on
plot(timeToDelta_a,z2delta_a,'k.','MarkerSize', 20)
plot(timeToDelta_b,z2delta_b,'k.','MarkerSize', 20)
plot(timeToDelta_c,z2delta_c,'k.','MarkerSize', 20)
plot(timeToDelta_d,z2delta_d,'k.','MarkerSize', 20)
plot(timeToDelta_e,z2delta_e,'k.','MarkerSize', 20)
plot(timeToDelta_f,z2delta_f,'k.','MarkerSize', 20)
plot(timeToDelta_g,z2delta_g,'k.','MarkerSize', 20)
grid on
ylabel('$\mathrm{z_2}$','FontSize',16)
xlabel('$\mathrm{t}$','FontSize',16)
axis([0 6 -45 45]);
saveas(gcf,'Plots\SubPlots','epsc')    
 
% plot phase plane
figure(2) % position
clf
%plotHarcColor(x1,j,x2,t);
plotHarc(x1,j,x2,[],modificatorF,modificatorJ);
xlabel('$\mathrm{z_1}$','FontSize',16)
ylabel('$\mathrm{z_2}$','FontSize',16)
hold on
plot(z1delta_a,z2delta_a,'k.','MarkerSize', 20)
strDelta_a = [num2str(timeToDelta_a), 's'];
text(z1delta_a,z2delta_a,strDelta_a,'HorizontalAlignment','right','VerticalAlignment','bottom');
plot(z1delta_b,z2delta_b,'k.','MarkerSize', 20)
strDelta_b= [num2str(timeToDelta_b), 's'];
text(z1delta_b,z2delta_b,strDelta_b,'HorizontalAlignment','right','VerticalAlignment','top');
plot(z1delta_c,z2delta_c,'k.','MarkerSize', 20)
strDelta_c= [num2str(timeToDelta_c), 's'];
text(z1delta_c,z2delta_c,strDelta_c,'HorizontalAlignment','right','VerticalAlignment','top');
plot(z1delta_d,z2delta_d,'k.','MarkerSize', 20)
strDelta_d = [num2str(timeToDelta_d), 's'];
text(z1delta_d,z2delta_d,strDelta_d,'HorizontalAlignment','right','VerticalAlignment','top');
plot(z1delta_e,z2delta_e,'k.','MarkerSize', 20)
strDelta_e = [num2str(timeToDelta_e), 's'];
text(z1delta_e,z2delta_e,strDelta_e,'HorizontalAlignment','left','VerticalAlignment','bottom');
plot(z1delta_f,z2delta_f,'k.','MarkerSize', 20)
strDelta_f = [num2str(timeToDelta_f), 's'];
text(z1delta_f,z2delta_f,strDelta_f,'HorizontalAlignment','left','VerticalAlignment','bottom');
plot(z1delta_g,z2delta_g,'k.','MarkerSize', 20)
strDelta_g = [num2str(timeToDelta_g), 's'];
text(z1delta_g,z2delta_g,strDelta_g,'HorizontalAlignment','left','VerticalAlignment','bottom');
axis([-5 35 -45 45]);
grid on
hold off
saveas(gcf,'Plots\PhasePlane','epsc')