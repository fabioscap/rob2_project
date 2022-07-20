function [Ts, T] = DHplus(table)
    % table in the form: alfa, a, d, theta
    Ts = [];
    T = eye(4);
    for i=1:size(table,1)
        alfa = table(i,1); a = table(i,2);
        d = table(i,3); theta = table(i,4);
        A = [    cos(theta), -cos(alfa)*sin(theta), ...
                 sin(alfa)*sin(theta), a*cos(theta);
                 sin(theta), cos(alfa)*cos(theta), ...
                 -sin(alfa)*cos(theta), a*sin(theta);
                 0, sin(alfa), cos(alfa), d;
                 0, 0,         0,         1];
        Ts = cat(3,Ts,A); % cat along third dimension
        T = T * A;
    end
end

