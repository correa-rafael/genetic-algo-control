clear all
clc

fig_pi = 'Fichiers/Manip/PI 4/output.fig';
fig_pp = 'Fichiers/Manip/PP 2/output.fig';
fig_hinf = 'Fichiers/Manip/Hinf 2/output.fig';
fig_ga = 'Fichiers/Manip/GA 2/output.fig';
fig_pi_var = 'Fichiers/Manip/Variations/PI/output.fig';
fig_hinf_var = 'Fichiers/Manip/Variations/Hinf/output.fig';

[mean_pi, var_pi] = mean_var(fig_pi, 118, 134)
[mean_pp, var_pp] = mean_var(fig_pp, 71, 81)
[mean_hinf, var_hinf] = mean_var(fig_hinf, 45, 75)
[mean_ga, var_ga] = mean_var(fig_ga, 15, 23)


[mean_pi_var1u, var_pi_var1u] = mean_var(fig_pi_var, 130, 135);
[mean_pi_var2u, var_pi_var2u] = mean_var(fig_pi_var, 140, 145);
[mean_pi_var3u, var_pi_var3u] = mean_var(fig_pi_var, 150, 155);

[mean_pi_var1l, var_pi_var1l] = mean_var(fig_pi_var, 125, 130);
[mean_pi_var2l, var_pi_var2l] = mean_var(fig_pi_var, 135, 140);
[mean_pi_var3l, var_pi_var3l] = mean_var(fig_pi_var, 145, 150);
[mean_pi_var4l, var_pi_var4l] = mean_var(fig_pi_var, 155, 160);


[mean_hinf_var1u, var_hinf_var1u] = mean_var(fig_hinf_var, 10, 15);
[mean_hinf_var2u, var_hinf_var2u] = mean_var(fig_hinf_var, 20, 25);
[mean_hinf_var3u, var_hinf_var3u] = mean_var(fig_hinf_var, 30, 35);

[mean_hinf_var1l, var_hinf_var1l] = mean_var(fig_hinf_var, 15, 20);
[mean_hinf_var2l, var_hinf_var2l] = mean_var(fig_hinf_var, 25, 30);


mean_pi_varu = (mean_pi_var1u + mean_pi_var2u + mean_pi_var3u) / 3
mean_pi_varl= (mean_pi_var1l + mean_pi_var2l + mean_pi_var3l + mean_pi_var4l) / 4
mean_hinf_varu = (mean_hinf_var1u + mean_hinf_var2u + mean_hinf_var3u) / 3
mean_hinf_varl = (mean_hinf_var1l + mean_hinf_var2l) / 2

var_pi_varu = (var_pi_var1u + var_pi_var2u + var_pi_var3u) / 3
var_pi_varl= (var_pi_var1l + var_pi_var2l + var_pi_var3l + var_pi_var4l) / 4
var_hinf_varu = (var_hinf_var1u + var_hinf_var2u + var_hinf_var3u) / 3
var_hinf_varl = (var_hinf_var1l + var_hinf_var2l) / 2