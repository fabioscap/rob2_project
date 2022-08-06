function show_movie(T,q,qout,thetaout,errorout,l)
        
    % plot a real time movie of the 3R planar robot given the simulation results
    lim = l(1)+l(2)+l(3)+0.5;
    % use figure() instead, if you want to display 
    % the plot while making the video
    fig = figure('Position',[100 100 1120 840],'visible','off');
    ax = axes('Parent', fig, 'XLim',[-lim lim],'YLim',[-lim lim]); hold on;
    % set(ax, 'Visible', 'off');
    % resample time series in order to have fixed step samples
    step = 0.0333333333; % 30 FPS
    time = [0:step:qout.Time(end)];
    
    qout = resample(qout,time);
    thetaout = resample(thetaout,time);
    errorout = resample(errorout, time);

    link1 = line([0 -l(1)],[0 0],"LineWidth",5);
    link2 = line([0 -l(1)],[0 0],"LineWidth",5);
    link3 = line([-0.2 -l(3)],[0 0],"LineWidth",5);
    
    % gripper
    g1 = line([-0.2 -0.2],[-0.2 0.2],"LineWidth",5);
    g2 = line([-0.25 0],[-0.2 -0.2],"LineWidth",5);
    g3 = line([-0.25 0],[0.2 0.2],"LineWidth",5);

    % show the joints
    j1 = plot(-l(1),0,"o","Color","g","MarkerSize",8);
    j2 = plot(-l(2),0,"o","Color","g","MarkerSize",8);
    j3 = plot(-l(3),0,"o","Color","g","MarkerSize",8);

    % show joint positions with a red marker
    q1 = line([-l(1),-l(1)],[0,0.3],"Color","r","LineWidth",2);
    q2 = line([-l(2),-l(2)],[0,0.3],"Color","r","LineWidth",2);
    q3 = line([-l(3),-l(3)],[0,0.3],"Color","r","LineWidth",2);

    % show theta positions with a black marker
    theta1 = line([0,0],[0,0.3],"Color","black","LineWidth",2);
    theta2 = line([0,0],[0,0.3],"Color","black","LineWidth",2);
    theta3 = line([0,0],[0,0.3],"Color","black","LineWidth",2);
    

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

    trgripper = hgtransform('Parent',tr3);
    set(trgripper,'Matrix',makehgtform("translate",[0,0,0]))
    set(g1,'Parent',trgripper);
    set(g2,'Parent',trgripper);
    set(g3,'Parent',trgripper);
    

    % Let's make the video
    t = strrep(string(datetime('now'))," ","-");
    v = VideoWriter("animations/experimen-"+t+".avi",'Motion JPEG AVI');
    v.Quality = 75; % 50 or lower is enough for tests, better 95-100 for sharing purposes.
    framerate = round(1/step);
    v.FrameRate = framerate;
    open(v);
    disp("Start saving video...")
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
        frame = getframe(fig);
        writeVideo(v,frame);
        % drawnow
        % if the error norm is very low we can stop the video.
        if norm(errorout.Data(i,:))<1e-3
            break
        end
    end
    close(v);
    disp("...video saved")
end

