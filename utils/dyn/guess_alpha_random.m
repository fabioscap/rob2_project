function alpha = guess_alpha_random(q,gr,tries)
% q symbolic vector
% gr gravity term

j = jacobian(gr,q);
JJ = simplify(j'*j);
alpha = 0;
for i=1:tries
    q_sampled = 2*pi*rand(3,1);
    JJ_ = eval(subs(JJ,q,q_sampled));
    new_alpha = sqrt(max(eig(JJ_)));
    if new_alpha > alpha
        alpha = new_alpha;
    end

end

end

