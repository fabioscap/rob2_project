close all
out = sim('iterative_elastic',30);
visibility = 'on' % 'off' or 'on'
quality = 95 % integer between 10 and 100
show_movie(T,q,out.q,out.theta,out.error,l,visibility,quality);