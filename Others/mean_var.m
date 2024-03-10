function [m,v] = mean_var(fig,lt,ut)
    S = load(fig, '-mat');
    y=S.hgS_070000.children(1).children(1).properties.YData;
    
    lv = 1e3 * lt/0.05;
    uv = 1e3 * ut/0.05;

    m = mean(y(lv:uv));
    v = var(y(lv:uv));
end