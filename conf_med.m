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
figure(1)
plot(out.error.Time,out.error.Data(:,1),"DisplayName","error "+1,"LineWidth",2); hold on;
plot(out.error.Time,out.error.Data(:,2),"DisplayName","error "+2,"LineWidth",2); hold on;
plot(out.error.Time,out.error.Data(:,3),"DisplayName","error "+3,"LineWidth",2); hold on;
xlabel("time -sec-")
ylabel("error -rad-")
legend()
xline(iterations,'--','HandleVisibility','off');


% plot q/theta
figure(2)
tiledlayout(2,1)
% for the high stiffness configuration, we plot separately q and delta
% because they are hard to distinguish
nexttile
for i=1:3
    plot(out.theta.Time,out.theta.Data(:,i),"DisplayName","theta"+i,"LineWidth",2); hold on;
    legend('Location','SouthEast');
    xlabel("time -sec-")
    ylabel("angle -rad-")
    xlim([0;12])
    xline(iteration_period:iteration_period:30,'--','HandleVisibility','off');
    %grid;
end
nexttile
out.delta = out.q - out.theta;
for i=1:3
    plot(out.delta.Time,out.delta.Data(:,i),"DisplayName","delta"+i,"LineWidth",2); hold on;
    legend('Location','SouthEast');
    xlabel("time -sec-")
    ylabel("angle -rad-")
    xlim([0;12])
    xline(iteration_period:iteration_period:30,'--','HandleVisibility','off');
    %grid;
end

% plot control effort
figure(3)
plot(out.error.Time,out.u.Data(:,1),"DisplayName","u"+1,"LineWidth",2); hold on;
plot(out.error.Time,out.u.Data(:,2),"DisplayName","u"+2,"LineWidth",2); hold on;
plot(out.error.Time,out.u.Data(:,3),"DisplayName","u"+3,"LineWidth",2); hold on;
xlabel("time -sec-")
ylabel("torque -Nm-")
ylim([-400 1000])
legend()
xline(iterations,'--','HandleVisibility','off');

grqd = eval(subs(gr,q,qd));
% plot gravity compensation
figure(4)
tiledlayout(3,1)
for i=1:3
    nexttile
    plot(out.ffw.Time,out.ffw.Data(:,i),"DisplayName","ffw"+i,"LineWidth",2); hold on;
    plot(out.ffw.Time,grqd(i)*ones(1,length(out.theta.Time)),"DisplayName","grav"+i,"LineStyle","- -","LineWidth",2);
    legend('Location','SouthEast');
    ylim([-100 300])
    xline(iterations,'--','HandleVisibility','off');
end

% plot thetad
figure(5)
tiledlayout(3,1)
for i=1:3
    nexttile
    plot(out.thetaref.Time,out.thetaref.Data(:,i),"DisplayName","thetaref"+i,"LineWidth",2); hold on;
    plot(out.thetaref.Time,qd(i)*ones(1,length(out.thetaref.Time)),"DisplayName","qd"+i,"LineStyle","- -","LineWidth",2,"Color","r");
    legend('Location','SouthEast');
    xline(iterations,'--','HandleVisibility','off');
    ylim([qd(i)-0.2;qd(i)+0.2])
end
% we update Kp is such a way that it's possible to see how the first
% iteration equal for both methods
Kp=Kp/beta;
outPD = sim("PD_elastic",30);
figure(6)
pd_e_norm = vecnorm(outPD.error.Data,2,2);
it_e_norm = vecnorm(out.error.Data,2,2);
plot(outPD.error.Time,pd_e_norm,"DisplayName","PD error","LineWidth",2); hold on;
plot(out.error.Time,it_e_norm,"DisplayName","iterative error","LineWidth",2); hold on;
legend()
xline(iterations,'--','HandleVisibility','off');
xlabel("time -sec-")
ylim([-0.5;3])
ylabel("error -rad-") 



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
qd = [0;0;0];

out = sim('iterative_elastic',30);

% plot error
figure(7)
plot(out.error.Time,out.error.Data(:,1),"DisplayName","error "+1,"LineWidth",2); hold on;
plot(out.error.Time,out.error.Data(:,2),"DisplayName","error "+2,"LineWidth",2); hold on;
plot(out.error.Time,out.error.Data(:,3),"DisplayName","error "+3,"LineWidth",2); hold on;
xlabel("time -sec-")
ylabel("error -rad-")
legend()
xline(iterations,'--','HandleVisibility','off');

% plot q/theta
figure(8)
tiledlayout(2,1)
% for the high stiffness configuration, we plot separately q and delta
% because they are hard to distinguish
nexttile
for i=1:3
    plot(out.theta.Time,out.theta.Data(:,i),"DisplayName","theta"+i,"LineWidth",2); hold on;
    legend('Location','SouthEast');
    xlabel("time -sec-")
    ylabel("angle -rad-")
    xlim([0;12])
    xline(iteration_period:iteration_period:30,'--','HandleVisibility','off');
    %grid;
end
nexttile
out.delta = out.q - out.theta;
for i=1:3
    plot(out.delta.Time,out.delta.Data(:,i),"DisplayName","delta"+i,"LineWidth",2); hold on;
    legend('Location','SouthEast');
    xlabel("time -sec-")
    ylabel("angle -rad-")
    xlim([0;12])
    xline(iteration_period:iteration_period:30,'--','HandleVisibility','off');
    %grid;
end

% plot control effort
figure(9)
plot(out.error.Time,out.u.Data(:,1),"DisplayName","u"+1,"LineWidth",2); hold on;
plot(out.error.Time,out.u.Data(:,2),"DisplayName","u"+2,"LineWidth",2); hold on;
plot(out.error.Time,out.u.Data(:,3),"DisplayName","u"+3,"LineWidth",2); hold on;
xlabel("time -sec-")
ylabel("torque -Nm-")
ylim([-400 1000])
legend()
xline(iterations,'--','HandleVisibility','off');


saveas(1,"figures/2_1_error.eps","epsc")
saveas(2,"figures/2_1_thetadelta.eps","epsc")
saveas(3,"figures/2_1_effort.eps","epsc")
saveas(4,"figures/2_1_grcomp.eps","epsc")
saveas(5,"figures/2_1_thetaref.eps","epsc")
saveas(6,"figures/2_1_PDcomp.eps","epsc")
saveas(7,"figures/2_2_error.eps","epsc")
saveas(8,"figures/2_2_thetadelta.eps","epsc")
saveas(9,"figures/2_2_effort.eps","epsc")