function plot_config_elastic(out,f_title)
    figure();
    tiledlayout(3,3);
    % plot q+thetas
    for i=1:3
        nexttile
        plot(out.q.Time,out.q.Data(:,i),"DisplayName","q"+i); hold on;
        plot(out.theta.Time,out.theta.Data(:,i),"DisplayName","theta"+i);
        legend('Location','SouthEast');
        if i==2
            title(f_title)
        end
    end
    
    % plot dq+dthetas
    for i=1:3
        nexttile
        plot(out.dq.Time,out.dq.Data(:,i),"DisplayName","dq"+i); hold on;
        plot(out.dtheta.Time,out.dtheta.Data(:,i),"DisplayName","dtheta"+i);
        legend('Location','SouthEast');
    end


    % plot errors
    for i=1:3
        nexttile
        plot(out.error.Time,out.error.Data(:,i),"DisplayName","e"+i); hold on;
        legend('Location','NorthEast');
    end
    
%     figure()
%     tiledlayout(3,3);
%     % plot dq+dthetas
%     for i=1:3
%         nexttile
%         plot(out.u.Time,out.u.Data(:,i),"DisplayName","u"+i); hold on;
%         if isprop(out,"ffw")
%             plot(out.ffw.Time,out.ffw.Data(:,i),"DisplayName","ffw"+i); hold on;
%         end
%         legend('Location','NorthEast');
%     end
end

