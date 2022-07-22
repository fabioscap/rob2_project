function plot_time_series(ts,label,same_graph)
    for i=1:size(ts.Data,2)
        if ~same_graph
            nexttile
        else
            hold on
        end
        plot(ts.Time,ts.Data(:,i));
        title(label+i)
    end
end

