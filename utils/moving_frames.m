function [vc,om] = moving_frames(table,sigma,r,q,qd) % TO TEST
%MOVING_FRAMES computes COM velocities and angular velocities of each link
%using recursive algorithm
%   table : DH table
%   sigma : sigma(i) = 0 -> qi revolute sigma(i) = 1 -> qi prismatic
%           (maybe change with a string like "rrp"?)
%   r : ith COM coordinates expressed in frame i ( r(:,i) denotes ith
%       vector)
    
    [Ts,~] = DHplus(table);

    Rs = Ts(1:3,1:3,:); % get all rotations
    ts = Ts(1:3,4,:); % get all translations

    nj = size(table,1); % assuming n joints is = rows of table

    v  = sym('v',[3,nj]); assume(v,"real");
    vc = sym('vc',[3,nj]); assume(vc,"real");
    om = sym('om',[3,nj]); assume(om,"real");

    % do i = 1 out of for cycle
    om(:,1) = simplify( ...
                Rs(:,:,1)' * (1-sigma(1))*[0; 0; qd(1)] ...
                );
    v(:,1) = simplify( ...
                Rs(:,:,1)' * sigma(1)*[0;0;qd(1)] +  ... 
                cross(om(:,1),Rs(:,:,1)'*ts(:,:,1)) ...
                );
    vc(:,1) = simplify( ...
                v(:,1) + cross(om(:,1),r(:,1)) ...
                );
    for i=2:nj
        % compute angular velocity
        om(:,i) = simplify( ...
                Rs(:,:,i)' * (om(:,i-1) + (1-sigma(i))*[0;0;qd(i)]) ...
                ); 

        % compute linear velocity
        v(:,i) = simplify( ...
                Rs(:,:,i)' * (v(:,i-1) + sigma(i)*[0;0;qd(i)]) + ...
                cross(om(:,i),Rs(:,:,i)'*ts(:,:,i)) ...
                );

        % compute linear velocity of COM
        vc(:,i) = simplify( ...
                v(:,i) + cross(om(:,i),r(:,i)) ...
                );
        
    end
        vc = collect(vc,qd); om = collect(om,qd);
end

