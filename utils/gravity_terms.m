function grav = gravity_terms(m,g,r,T,q)
    % not tested
    nj = length(q);
    U=0;
    A = eye(4);

    % compute potential energy
    for i=1:nj
        A = A*T(:,:,i);
        ri = A*[r(:,i);1];
        ri = ri(1:3);
        U = U -m(i)*g'*ri;
    end

    grav = sym('grav',[nj,1]); assume(grav,"real");
    for i=1:nj
        grav(i) = diff(U,q(i));
    end
end

