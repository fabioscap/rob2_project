function [T,M] = kinM(vc,om,m,I,qd)
%KIN computes kinetic energy of a robot
%   om : angular velocity vector such that om(:,i) is the angular velocity
%        of ith link
%   vc
%   m
%   I : inertia matrices such that I(:,:,i) is the ith inertia matrix

    syms T real
    T = 0;
    nj = length(qd);
    for i=1:nj

        T_i = simplify( 0.5*(m(i)*vc(:,i)' * vc(:,i) + om(:,i)' * I(:,:,i) * om(:,i)) ) ;
        T = simplify(T + T_i);
    end
    
    M = sym("M",[nj,nj]); assume(M,"real");
    
    for i=1:nj
        for j=1:nj
            % could be optimized (M symmetric)
            M(i,j) = diff(diff(T,qd(j)),qd(i)); 
        end
    end
end

