figure();
subplot(5,1,1);
plot(t_100,z_100);
ylim([-5.5e-11, 5.5e-11]);
set(gca, 'FontSize', 20);
set(findall(gcf,'Type','line'),'LineWidth',2);
title('Surface Variations [m]', 'FontSize', 25);
xAxis = get(gca, 'XAxis');
set(xAxis, 'FontSize', 0.01);

subplot(5,1,2);
plot(t_pi_100,i_pi_100);
ylim([4.5e-10, 5.6e-10]);
set(gca, 'FontSize', 20);
set(findall(gcf,'Type','line'),'LineWidth',2);
title('PI Controller', 'FontSize', 25);
xAxis = get(gca, 'XAxis');
set(xAxis, 'FontSize', 0.01);

subplot(5,1,3);
plot(t_pp_100,i_pp_100);
set(gca, 'FontSize', 20);
ylabel('Tunneling Current [A]', 'FontSize', 25);
ylim([4.5e-10, 5.6e-10]);
set(findall(gcf,'Type','line'),'LineWidth',2);
title('Pole Placement Controller', 'FontSize', 25);
xAxis = get(gca, 'XAxis');
set(xAxis, 'FontSize', 0.01);

subplot(5,1,4);
plot(t_hinf_100,i_hinf_100);
ylim([4.5e-10, 5.6e-10]);
set(gca, 'FontSize', 20);
set(findall(gcf,'Type','line'),'LineWidth',2);
title('H-infinity Controller', 'FontSize', 25);
xAxis = get(gca, 'XAxis');
set(xAxis, 'FontSize', 0.01);

subplot(5,1,5);
plot(t_ga_100,i_ga_100);
set(gca, 'FontSize', 20);
xlabel('Time [s]', 'FontSize', 25);
ylim([4.5e-10, 5.6e-10]);
set(findall(gcf,'Type','line'),'LineWidth',2);
title('Genetic Algorithm Controller', 'FontSize', 25);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure();
subplot(5,1,1);
plot(t_200,z_200);
ylim([-5.5e-11, 5.5e-11]);
set(gca, 'FontSize', 20);
set(findall(gcf,'Type','line'),'LineWidth',2);
title('Surface Variations [m]', 'FontSize', 25);
xAxis = get(gca, 'XAxis');
set(xAxis, 'FontSize', 0.01);

subplot(5,1,2);
plot(t_pi_200,i_pi_200);
ylim([4e-10, 6e-10]);
set(gca, 'FontSize', 20);
set(findall(gcf,'Type','line'),'LineWidth',2);
title('PI Controller', 'FontSize', 25);
xAxis = get(gca, 'XAxis');
set(xAxis, 'FontSize', 0.01);

subplot(5,1,3);
plot(t_pp_200,i_pp_200);
set(gca, 'FontSize', 20);
ylabel('Tunneling Current [A]', 'FontSize', 25);
ylim([4e-10, 6e-10]);
set(findall(gcf,'Type','line'),'LineWidth',2);
title('Pole Placement Controller', 'FontSize', 25);
xAxis = get(gca, 'XAxis');
set(xAxis, 'FontSize', 0.01);

subplot(5,1,4);
plot(t_hinf_200,i_hinf_200);
ylim([4e-10, 6e-10]);
set(gca, 'FontSize', 20);
set(findall(gcf,'Type','line'),'LineWidth',2);
title('H-infinity Controller', 'FontSize', 25);
xAxis = get(gca, 'XAxis');
set(xAxis, 'FontSize', 0.01);

subplot(5,1,5);
plot(t_ga_200,i_ga_200);
set(gca, 'FontSize', 20);
xlabel('Time [s]', 'FontSize', 25);
ylim([4e-10, 6e-10]);
set(findall(gcf,'Type','line'),'LineWidth',2);
title('Genetic Algorithm Controller', 'FontSize', 25);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure();
subplot(5,1,1);
plot(t_600,z_600);
ylim([-5.5e-11, 5.5e-11]);
set(gca, 'FontSize', 20);
set(findall(gcf,'Type','line'),'LineWidth',2);
title('Surface Variations [m]', 'FontSize', 25);
xAxis = get(gca, 'XAxis');
set(xAxis, 'FontSize', 0.01);

subplot(5,1,2);
plot(t_pi_600,i_pi_600);
ylim([2.5e-10, 7.5e-10]);
set(gca, 'FontSize', 20);
set(findall(gcf,'Type','line'),'LineWidth',2);
title('PI Controller', 'FontSize', 25);
xAxis = get(gca, 'XAxis');
set(xAxis, 'FontSize', 0.01);

subplot(5,1,3);
plot(t_pp_600,i_pp_600);
set(gca, 'FontSize', 20);
ylabel('Tunneling Current [A]', 'FontSize', 25);
ylim([2.5e-10, 7.5e-10]);
set(findall(gcf,'Type','line'),'LineWidth',2);
title('Pole Placement Controller', 'FontSize', 25);
xAxis = get(gca, 'XAxis');
set(xAxis, 'FontSize', 0.01);

subplot(5,1,4);
plot(t_hinf_600,i_hinf_600);
ylim([2.5e-10, 7.5e-10]);
set(gca, 'FontSize', 20);
set(findall(gcf,'Type','line'),'LineWidth',2);
title('H-infinity Controller', 'FontSize', 25);
xAxis = get(gca, 'XAxis');
set(xAxis, 'FontSize', 0.01);

subplot(5,1,5);
plot(t_ga_200,i_ga_200);
set(gca, 'FontSize', 20);
xlabel('Time [s]', 'FontSize', 25);
ylim([4e-10, 6e-10]);
set(findall(gcf,'Type','line'),'LineWidth',2);
title('Genetic Algorithm Controller', 'FontSize', 25);

subplot(5,1,5);
plot(t_ga_600,i_ga_600);
set(gca, 'FontSize', 20);
xlabel('Time [s]', 'FontSize', 25);
ylim([2.5e-10, 7.5e-10]);
set(findall(gcf,'Type','line'),'LineWidth',2);
title('Genetic Algorithm Controller', 'FontSize', 25);