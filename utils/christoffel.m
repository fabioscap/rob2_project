function S = christoffel(M,q,qd)
%CHRISTOFFEL Summary of this function goes here
%   computes S(q,qd) according to christoffel symbol
    
    nj = size(M,1); % get num joints
    
    S = sym('S',[nj,nj]); assume(S,"real");

    for k=1:nj
        % kth row of matrix S is qd'*Ck(q),
        % where Ck is computed according to 
        % christoffel symbols
        j = jacobian(M(:,k),q) ;
        Ck = 0.5 * ( j + j' - diff(M,q(k)));
        S(k,:) = qd' * Ck;
    end
    S = simplify(S);
end

