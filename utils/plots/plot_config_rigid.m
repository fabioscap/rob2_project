function plot_config_rigid(out)
    % plot q, dq, e for a RRR rigid robot
    tiledlayout(3,3);
    plot_time_series(out.q,"q",false);
    plot_time_series(out.dq,"dq",false)
    plot_time_series(out.error,"error",false)

    % consider adding control effort, error norm ...
end

