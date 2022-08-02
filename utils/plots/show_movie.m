function show_movie(T,q,qout,thetaout,l)

    % TODO replace the loop with a timer to get real time playback
    % https://it.mathworks.com/matlabcentral/answers/396472-how-to-generate-an-event-in-matlab-every-second
    
    % TODO plot also the thetas (maybe a small indicator on the joint)

    % plot a real time movie of the 3R planar robot given the simulation results
    ax = axes('XLim',[-3 3],'YLim',[-3 3]); hold on;
    
    % resample time series in order to have fixed step samples
    step = 0.02;
    time = [0:step:qout.Time(end)];
    
    qout = resample(qout,time);
    thetaout = resample(thetaout,time);

    link1 = line([0 -l(1)],[0 0]);
    link2 = line([0 -l(1)],[0 0]);
    link3 = line([0 -l(3)],[0 0]);
    
    % show the joints
    j1 = plot(-l(1),0,"o","Color","g","MarkerSize",5);
    j2 = plot(-l(2),0,"o","Color","g","MarkerSize",5);
    j3 = plot(-l(3),0,"o","Color","g","MarkerSize",5);

    % show joint positions with a red marker
    q1 = line([-l(1),-l(1)],[0,0.1],"Color","r");
    q2 = line([-l(2),-l(2)],[0,0.1],"Color","r");
    q3 = line([-l(3),-l(3)],[0,0.1],"Color","r");

    % show theta positions with a black marker
    theta1 = line([0, 0],[0,0.1],"Color","black");
    theta2 = line([0,0],[0,0.1],"Color","black");
    theta3 = line([0,0],[0,0.1],"Color","black");
    

    tr1 = hgtransform('Parent',ax);
    set(link1,'Parent',tr1);
    set(j1,'Parent',tr1);
    set(q1,'Parent',tr1);

    tr1_theta = hgtransform('Parent',ax);
    set(theta1,'Parent',tr1_theta);

    tr2 = hgtransform('Parent',tr1);
    set(link2,'Parent',tr2);
    set(j2,'Parent',tr2);
    set(q2,'Parent',tr2);

    tr2_theta = hgtransform('Parent',tr1);
    set(theta2,'Parent',tr2_theta);

    tr3 = hgtransform('Parent',tr2);
    set(link3,'Parent',tr3);
    set(j3,'Parent',tr3);
    set(q3,'Parent',tr3);

    tr3_theta = hgtransform('Parent',tr2);
    set(theta3,'Parent',tr3_theta);

    
    for i=1:length(time) 

        qi = qout.Data(i,:)';
        thetai = thetaout.Data(i,:)';

        Ti = double(subs(T,q,qi));

        set(tr1,'Matrix',Ti(:,:,1));
        set(tr1_theta,'Matrix',Rz(thetai(1)));
        set(tr2_theta,'Matrix',Rz(thetai(2)));
        set(tr3_theta,'Matrix',Rz(thetai(3)));

        set(tr2,'Matrix',Ti(:,:,2));
        set(tr3,'Matrix',Ti(:,:,3));
        
        drawnow
    end
end

