function alpha = guess_alpha(q,gr)
% q symbolic vector
% gr gravity term
j = jacobian(gr,q);
JJ = simplify(j'*j);
alpha = 0;

step = 0.5;

for q1=-pi/2:step:pi/2
    for q2=0:step:2*pi
        for q3=0:step:2*pi
            JJ_ = eval(subs(JJ,q,[q1;q2;q3]));
            new_alpha = sqrt(max(eig(JJ_)));
            if new_alpha > alpha
                alpha = new_alpha;
            end
        end
    end
end

end
