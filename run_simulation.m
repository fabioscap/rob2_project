Kp = [900;750;500];
Kd = [600;300;300];
qd = [0;0;pi/4];

out = sim('iterative_elastic',60); % run for 30 seconds
show_movie(T,q,out.q,out.theta,l)