Kp = 300;
Kd = 250;
qd = [pi/3;0;0];

out = sim('iterative_rigid',30); % run for 30 seconds
show_movie(T,q,out.q,l)