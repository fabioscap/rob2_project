Kp = [900;750;500];
Kd = [600;300;300];
qd = [pi/3;-pi/2;pi/3];

out = sim('iterative_elastic',30); % run for 30 seconds
show_movie(T,q,out.q,out.theta,l)