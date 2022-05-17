% gravity terms
g0 = 9.81;
g = g0*[0;-1;0];

% robot kinematic parameters
l1 = 1;
l2 = 1;
l3 = 1;
l = [l1;l2;l3];

% motor dynamic parameters
% include reduction ratios?
Im1 = 1;
Im2 = 1;
Im3 = 1;

% robot dynamic parameters
m1 = 1;
m2 = 1;
m3 = 1;
m = [m1;m2;m3];

d1 = -0.5;
d2 = -0.5;
d3 = -0.5;
I = zeros(3,3,3);
I(3,3,1) = 1;
I(3,3,2) = 1;
I(3,3,3) = 1; % non mi ricordo la formula dell'inerzia della sbarra

% stiffness coefficients
k1 = 1;
k2 = 1;
k3 = 1;

k = [k1;k2;k3];


q = sym('q',[3,1]); assume(q,"real");
qd = sym('qd',[3,1]); assume(qd,"real");
qdd = sym('qdd',[3,1]); assume(qdd,"real");
u  = sym('u',[3,1]); assume(u,"real");

table = [0 l1 0 q(1);
         0 l2 0 q(2);
         0 l3 0 q(3)];

T = DHplus(table);

r = [d1 d2 d3; 0 0 0; 0 0 0];

% initial state
q0 = [-pi/2;0;0];
qd0 = [0;0;0];
theta0 = [0;0;0];
thetad0 = [0;0;0];

% set up simulation using euler lagrange ( do only once )

[vc,om] = moving_frames(table,[0,0,0], r,q,qd) ;

[~,M] = kinM(vc,om,[m1;m2;m3],I,qd);

invM = inv(M);

c = christoffel(M,q,qd)*qd;
gr = gravity_terms(m,g,r,T,q);

% directDyn = (invM*(u-c-gr));
directDyn = (M\(u-c-gr));



% TODO set up simulation using newton euler

% TODO maybe wrap the state in [0;2pi)
% -> change integrator blocks
% -> change elastic force

open("RRR_elastic_joints")
% https://it.mathworks.com/help/symbolic/generate-matlab-function-blocks.html
matlabFunctionBlock("RRR_elastic_joints/RRR/euler_lagrange",directDyn,"vars",[u q qd])


