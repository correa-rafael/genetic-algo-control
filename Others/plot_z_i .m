function plot_z_i(t,z,i)
    subplot(2,1,1);
    plot(t,z);
    xlabel('Time [s]');
    ylabel('Surface Variations [m]');
    title('Surface Variations');
    subplot(2,1,2);
    plot(t,i);
    xlabel('Time [s]');
    ylabel('Tunneling Current [A]');
    set(findall(gcf,'Type','line'),'LineWidth',2);
    title('Tunneling Current');
end