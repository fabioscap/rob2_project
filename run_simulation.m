q0 = [pi/2;pi/4;0];
Kp = [400;450;400];
Kd = [300; 300;350];
qd = [0;-pi/2;pi/2];

out = sim('iterative_elastic',30);
show_movie(T,q,out.q,out.theta,out.error,l);