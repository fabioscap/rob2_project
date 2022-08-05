Kp = [900;750;500];
Kd = [600;300;300];
qd = [pi/3;pi/3;-2*pi/3];

outPD = sim("PD_elastic",30);


outIT = sim('iterative_elastic',30);


% plot a quantitative comparision of the two control algorithms
figure()
tiledlayout(2,3)
for i=1:3
    nexttile
    plot(outPD.error.Time,outPD.error.Data(:,i),"DisplayName","PD error "+i); hold on;
    plot(outIT.error.Time,outIT.error.Data(:,i),"DisplayName","it error "+i); hold on;
    legend('Location','NorthEast');
end
for i=1:3
    nexttile
    plot(outPD.u.Time,outPD.u.Data(:,i),"DisplayName","PD u "+i); hold on;
    plot(outIT.u.Time,outIT.u.Data(:,i),"DisplayName","it u "+i); hold on;
    legend('Location','NorthEast');
end
