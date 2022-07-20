% out = sim('RRR_rigid_joints',10); % run for 10 seconds
out = sim('RRR_elastic_joints',10); % run for 10 seconds
show_movie(T,q,out.qout,l)