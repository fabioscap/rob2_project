Kp = [900;750;500];
Kd = [600;300;300];
qd = [-pi;0;0];

out = sim('iterative_elastic',30);
show_movie(T,q,out.q,out.theta,l);