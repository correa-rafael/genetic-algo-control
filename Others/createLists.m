function [t, z, i] = createLists(y)
    t = y.time;
    z = y.signals.values(:,1);
    i = y.signals.values(:,2);
    %plot_z_i(t,z,i);
end