close all

iteration_period = 3;
gamma = 35;
beta = 0.47;

% stiffness coefficients
k1 = 14210;
k2 = 29800;
k3 = 13500;

k = [k1;k2;k3];

% initial state
q0 = [-pi/2;0;0];
% theta0 at steady state is related to q0 by:
theta0 = double(diag(k)^-1*subs(gr,q,q0)+q0);

dq0 = [0;0;0];
dtheta0 = [0;0;0];

% gain matrices
Kp = [600;500;400];
Kd = [200;200;200];

% desired set-point
qd = [pi/2;0;0];
qd = [pi/4;0;pi/2];

out = sim('iterative_elastic',30);

% plot error
figure(1)
plot(out.error.Time,out.error.Data(:,1),"DisplayName","error "+1,"LineWidth",2); hold on;
plot(out.error.Time,out.error.Data(:,2),"DisplayName","error "+2,"LineWidth",2); hold on;
plot(out.error.Time,out.error.Data(:,3),"DisplayName","error "+3,"LineWidth",2); hold on;
xlabel("time -sec-")
ylabel("error -rad-")
xlim([0;12])
ylim([-0.6;2.5])
xline(iteration_period:iteration_period:12,'--','HandleVisibility','off');
legend()
%grid;
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
    xline(iteration_period:iteration_period:12,'--','HandleVisibility','off');
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
    xline(iteration_period:iteration_period:12,'--','HandleVisibility','off');
    %grid;
end

% plot control effort
figure(3)
plot(out.error.Time,out.u.Data(:,1),"DisplayName","u"+1,"LineWidth",2); hold on;
plot(out.error.Time,out.u.Data(:,2),"DisplayName","u"+2,"LineWidth",2); hold on;
plot(out.error.Time,out.u.Data(:,3),"DisplayName","u"+3,"LineWidth",2); hold on;
xlabel("time -sec-")
ylabel("torque -Nm-")
ylim([-850 1100])
xlim([0 12])
xline(iteration_period:iteration_period:12,'--','HandleVisibility','off');
legend()
%grid;

saveas(1,"figures/1_1_error.eps","epsc")
saveas(2,"figures/1_1_thetadelta.eps","epsc")
saveas(3,"figures/1_1_effort.eps","epsc")
