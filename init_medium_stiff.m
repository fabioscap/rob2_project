%% state and regulation parameters
% you can fine-tune launching only this part of the file ctrl+send

gamma = 3.01;
beta = 1/6;

% stiffness coefficients
k1 = 2500;
k2 = 2000;
k3 = 1050;

k = [k1;k2;k3];

% initial state
q0 = [-pi/2;0;0];
% theta0 at steady state is related to q0 by:
theta0 = double(diag(k)^-1*subs(gr,q,q0)+q0);

dq0 = [0;0;0];
dtheta0 = [0;0;0];

% gain matrices
Kp = [600;500;400];
Kd = [400;400;400];

% desired set-point
qd = [pi/4;0;pi/2];

out = sim('iterative_elastic',30);

% plot error
figure()
plot(out.error.Time,out.error.Data(:,1),"DisplayName","error "+1); hold on;
plot(out.error.Time,out.error.Data(:,2),"DisplayName","error "+2); hold on;
plot(out.error.Time,out.error.Data(:,3),"DisplayName","error "+3); hold on;
xlabel("time -sec-")
ylabel("error -rad-")
legend()
grid;

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
    xlim([0;12])
    ylim([-pi;pi])
    grid;
end

% plot control effort
figure()
plot(out.error.Time,out.u.Data(:,1),"DisplayName","u"+1); hold on;
plot(out.error.Time,out.u.Data(:,2),"DisplayName","u"+2); hold on;
plot(out.error.Time,out.u.Data(:,3),"DisplayName","u"+3); hold on;
xlabel("time -sec-")
ylabel("torque -Nm-")
ylim([-850 850])
xlim([0 30])
legend()
grid;

grqd = subs(gr,q,qd);
% plot gravity compensation
figure()
plot(out.error.Time,out.u.Data(:,1),"DisplayName",""+1); hold on;
plot(out.error.Time,out.u.Data(:,2),"DisplayName","u"+2); hold on;
plot(out.error.Time,out.u.Data(:,3),"DisplayName","u"+3); hold on;
xlabel("time -sec-")
ylabel("torque -Nm-")
ylim([-850 850])
xlim([0 30])
legend()
grid;
