function show_movie(T,q,qout,l)
    % TODO replace the loop with a timer to get real time playback
    % https://it.mathworks.com/matlabcentral/answers/396472-how-to-generate-an-event-in-matlab-every-second
    
    % TODO plot also the thetas (maybe a small indicator on the joint)

    % plot a real time movie of the 3R planar robot given the simulation results
    ax = axes('XLim',[-3 3],'YLim',[-3 3]); hold on;
    
    % resample time series in order to have fixed step samples
    step = 0.02;
    time = [0:step:qout.Time(end)];
    
    qout = resample(qout,time);
    
    link1 = line([0 -l(1)],[0 0]);
    link2 = line([0 -l(1)],[0 0]);
    link3 = line([0 -l(3)],[0 0]);
    
    tr1 = hgtransform('Parent',ax);
    set(link1,'Parent',tr1);
    tr2 = hgtransform('Parent',tr1);
    set(link2,'Parent',tr2);
    tr3 = hgtransform('Parent',tr2);
    set(link3,'Parent',tr3);
    
    for i=1:length(time) 

        qi = qout.Data(i,:)';
        Ti = double(subs(T,q,qi));

        set(tr1,'Matrix',Ti(:,:,1));
        set(tr2,'Matrix',Ti(:,:,2));
        set(tr3,'Matrix',Ti(:,:,3));
        
        drawnow
        
    end
end

