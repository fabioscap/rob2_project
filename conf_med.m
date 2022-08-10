close all

iteration_period = 3;
iterations = iteration_period:iteration_period:30;
gamma = 5;
beta = 0.3;

% stiffness coefficients
k1 = 2100;
k2 = 4500;
k3 = 1500;

k = [k1;k2;k3];

% initial state
q0 = [-pi/2;0;0];
% theta0 at steady state is related to q0 by:
theta0 = double(diag(k)^-1*subs(gr,q,q0)+q0);

dq0 = [0;0;0];
dtheta0 = [0;0;0];

% gain matrices
Kp = [200;200;200];
Kd = [150;150;150];

% desired set-point
qd = [pi/4;0;pi/2];
%qd = [0;0;0];

out = sim('iterative_elastic',30);

% plot error
figure()
plot(out.error.Time,out.error.Data(:,1),"DisplayName","error "+1); hold on;
plot(out.error.Time,out.error.Data(:,2),"DisplayName","error "+2); hold on;
plot(out.error.Time,out.error.Data(:,3),"DisplayName","error "+3); hold on;
xlabel("time -sec-")
ylabel("error -rad-")
legend()
xline(iterations,'--','HandleVisibility','off');

% plot q/theta
figure()
tiledlayout(3,1)
for i=1:3
    nexttile
    plot(out.q.Time,out.q.Data(:,i),"DisplayName","q"+i,"Color","b"); hold on;
    plot(out.theta.Time,out.theta.Data(:,i),"DisplayName","theta"+i,"Color","r");
    legend('Location','SouthEast');
    xlabel("time -sec-")
    ylabel("angle -rad-")
    ylim([-pi;pi])
    xline(iterations,'--','HandleVisibility','off');
end

% plot control effort
figure()
plot(out.error.Time,out.u.Data(:,1),"DisplayName","u"+1); hold on;
plot(out.error.Time,out.u.Data(:,2),"DisplayName","u"+2); hold on;
plot(out.error.Time,out.u.Data(:,3),"DisplayName","u"+3); hold on;
xlabel("time -sec-")
ylabel("torque -Nm-")
ylim([-400 1000])
legend()
xline(iterations,'--','HandleVisibility','off');

grqd = eval(subs(gr,q,qd));
% plot gravity compensation
figure()
tiledlayout(3,1)
for i=1:3
    nexttile
    plot(out.ffw.Time,out.ffw.Data(:,i),"DisplayName","ffw"+i); hold on;
    plot(out.ffw.Time,grqd(i)*ones(1,length(out.theta.Time)),"DisplayName","grav"+i,"LineStyle","- -");
    legend('Location','SouthEast');
    ylim([-100 300])
    xline(iterations,'--','HandleVisibility','off');
end

grqd = eval(subs(gr,q,qd));
% plot thetad
figure()
tiledlayout(3,1)
for i=1:3
    nexttile
    plot(out.thetaref.Time,out.thetaref.Data(:,i),"DisplayName","thetaref"+i); hold on;
    plot(out.thetaref.Time,qd(i)*ones(1,length(out.thetaref.Time)),"DisplayName","qd"+i,"LineStyle","- -");
    legend('Location','SouthEast');
    xline(iterations,'--','HandleVisibility','off');
    ylim([qd(i)-0.2;qd(i)+0.2])
end
% we update Kp is such a way that it's possible to see how the first
% iteration equal for both methods
Kp=Kp/beta;
outPD = sim("PD_elastic",30);
figure()
pd_e_norm = vecnorm(outPD.error.Data,2,2);
it_e_norm = vecnorm(out.error.Data,2,2);
plot(outPD.error.Time,pd_e_norm,"DisplayName","PD error"); hold on;
plot(out.error.Time,it_e_norm,"DisplayName","iterative error"); hold on;
legend()
xline(iterations,'--','HandleVisibility','off');
xlabel("time -sec-")
ylim([-0.5;3])
ylabel("error -rad-") 