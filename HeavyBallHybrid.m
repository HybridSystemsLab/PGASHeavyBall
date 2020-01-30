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
global gamma lambda delta eps1 eps2 rho1 rho2 direction nu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initializing the globals %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lambda = 145;
gamma = 3/4;

eps1 = 0.05;
eps2 = 0.06;

rho1 = 0.05;
rho2 = 0.06;

delta = 0.01;

nu = 1;

setMinima();

%%%%%%%%%%%%%%%%%%%%%%
% setting the locals %
%%%%%%%%%%%%%%%%%%%%%%

% initial conditions
z1_a = 15;
z2_a = 0;
p_a = 0;

% Need to change this to sgn(z2)
direction = 0; 
while direction == 0
    direction = randi([-1,1]); 
end
a_a = nu*sign(direction);

z1_b = 5*(3-sqrt(5));
z2_b = 0;
p_b = 0;

% Need to change this to sgn(z2)
direction = 0; 
while direction == 0
    direction = randi([-1,1]); 
end
a_b = nu*sign(direction);

z1_c = 5*(3+sqrt(5));
z2_c = 0;
p_c = 0;
% Need to change this to sgn(z2)
direction = 0; 
while direction == 0
    direction = randi([-1,1]); 
end
a_c = nu*sign(direction);

z1_d = 6;
z2_d = 0;
p_d = 0;
tau_d = 0;

% Need to change this to sgn(z2)
direction = 0; 
while direction == 0
    direction = randi([-1,1]); 
end
a_d = nu*sign(direction);

z1_e = -1; 
z2_e = 0;
p_e = 0;
% Need to change this to sgn(z2)
direction = 0; 
while direction == 0
    direction = randi([-1,1]); 
end
a_e = nu*sign(direction);

z1_f = 31; 
z2_f = 0;
p_f = 0;
% Need to change this to sgn(z2)
direction = 0; 
while direction == 0
    direction = randi([-1,1]); 
end
a_f = nu*sign(direction);

z1_g = 24.5;
z2_g = 0;
p_g = 0;
% Need to change this to sgn(z2)
direction = 0; 
while direction == 0
    direction = randi([-1,1]); 
end
a_g = nu*sign(direction);

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

deltaVecA = timeToConv(xa,ta);
deltaVecB = timeToConv(xb,tb);
deltaVecC = timeToConv(xc,tc);
deltaVecD = timeToConv(xd,td);
deltaVecE = timeToConv(xe,te);
deltaVecF = timeToConv(xf,tf);
deltaVecG = timeToConv(xg,tg);

% Prepare the data, to plot multiple hybrid arcs on same plane
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
plot(deltaVecA(3),deltaVecA(1),'k.','MarkerSize', 20)
strDelta_a = [num2str(deltaVecA(3)), 's'];
text(deltaVecA(3),deltaVecA(1),strDelta_a,'HorizontalAlignment','left','VerticalAlignment','bottom');
plot(deltaVecB(3),deltaVecB(1),'k.','MarkerSize', 20)
strDelta_b = [num2str(deltaVecB(3)), 's'];
text(deltaVecB(3),deltaVecB(1),strDelta_b,'HorizontalAlignment','left','VerticalAlignment','top');
plot(deltaVecC(3),deltaVecC(1),'k.','MarkerSize', 20)
strDelta_c = [num2str(deltaVecC(3)), 's'];
text(deltaVecC(3),deltaVecC(1),strDelta_c,'HorizontalAlignment','left','VerticalAlignment','top');
plot(deltaVecD(3),deltaVecD(1),'k.','MarkerSize', 20)
strDelta_d = [num2str(deltaVecD(3)), 's'];
text(deltaVecD(3),deltaVecD(1),strDelta_d,'HorizontalAlignment','left','VerticalAlignment','top');
plot(deltaVecE(3),deltaVecE(1),'k.','MarkerSize', 20)
strDelta_e = [num2str(deltaVecE(3)), 's'];
text(deltaVecE(3),deltaVecE(1),strDelta_e,'HorizontalAlignment','left','VerticalAlignment','top');
plot(deltaVecF(3),deltaVecF(1),'k.','MarkerSize', 20)
strDelta_f = [num2str(deltaVecF(3)), 's'];
text(deltaVecF(3),deltaVecF(1),strDelta_f,'HorizontalAlignment','left','VerticalAlignment','top');
plot(deltaVecG(3),deltaVecG(1),'k.','MarkerSize', 20)
strDelta_g = [num2str(deltaVecG(3)), 's'];
text(deltaVecG(3),deltaVecG(1),strDelta_g,'HorizontalAlignment','left','VerticalAlignment','top');
grid on
ylabel('$\mathrm{z_1}$','FontSize',16)
xlabel('$\mathrm{t}$','FontSize',16)
axis([0 6 -10 35]);
subplot(2,1,2), plotHarc(t,j,x2,[],modificatorF,modificatorJ);
hold on
plot(deltaVecA(3),deltaVecA(2),'k.','MarkerSize', 20)
plot(deltaVecB(3),deltaVecB(2),'k.','MarkerSize', 20)
plot(deltaVecC(3),deltaVecC(2),'k.','MarkerSize', 20)
plot(deltaVecD(3),deltaVecD(2),'k.','MarkerSize', 20)
plot(deltaVecE(3),deltaVecE(2),'k.','MarkerSize', 20)
plot(deltaVecF(3),deltaVecF(2),'k.','MarkerSize', 20)
plot(deltaVecG(3),deltaVecG(2),'k.','MarkerSize', 20)
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
plot(deltaVecA(1),deltaVecA(2),'k.','MarkerSize', 20)
strDelta_a = [num2str(deltaVecA(3)), 's'];
text(deltaVecA(1),deltaVecA(2),strDelta_a,'HorizontalAlignment','right','VerticalAlignment','bottom');
plot(deltaVecB(1),deltaVecB(2),'k.','MarkerSize', 20)
strDelta_b= [num2str(deltaVecB(3)), 's'];
text(deltaVecB(1),deltaVecB(2),strDelta_b,'HorizontalAlignment','right','VerticalAlignment','top');
plot(deltaVecC(1),deltaVecC(2),'k.','MarkerSize', 20)
strDelta_c= [num2str(deltaVecC(3)), 's'];
text(deltaVecC(1),deltaVecC(2),strDelta_c,'HorizontalAlignment','right','VerticalAlignment','top');
plot(deltaVecD(1),deltaVecD(2),'k.','MarkerSize', 20)
strDelta_d = [num2str(deltaVecD(3)), 's'];
text(deltaVecD(1),deltaVecD(2),strDelta_d,'HorizontalAlignment','right','VerticalAlignment','top');
plot(deltaVecE(1),deltaVecE(2),'k.','MarkerSize', 20)
strDelta_e = [num2str(deltaVecE(3)), 's'];
text(deltaVecE(1),deltaVecE(2),strDelta_e,'HorizontalAlignment','left','VerticalAlignment','bottom');
plot(deltaVecF(1),deltaVecF(2),'k.','MarkerSize', 20)
strDelta_f = [num2str(deltaVecF(3)), 's'];
text(deltaVecF(1),deltaVecF(2),strDelta_f,'HorizontalAlignment','left','VerticalAlignment','bottom');
plot(deltaVecG(1),deltaVecG(2),'k.','MarkerSize', 20)
strDelta_g = [num2str(deltaVecG(3)), 's'];
text(deltaVecG(1),deltaVecG(2),strDelta_g,'HorizontalAlignment','left','VerticalAlignment','bottom');
axis([-5 35 -45 45]);
grid on
hold off
saveas(gcf,'Plots\PhasePlane','epsc')