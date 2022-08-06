q0 = [-pi/2;0;0];
% theta0 at steady state is related to q0 by:
theta0 = double(diag(k)^-1*subs(gr,q,q0)+q0);

Kp = [400;450;400];
Kd = [300; 300;350];
qd = [pi/4;pi/2;pi/2];

out = sim('iterative_elastic',30);
show_movie(T,q,out.q,out.theta,out.error,l);