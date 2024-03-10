function plot_sensitivity_functions(S0,KS0,T,Te)
    figure()
    plotS0 = bodeplot(S0, {2*pi*10, pi/Te});
    setoptions(plotS0,'FreqUnits','Hz','PhaseVisible','off');
    title('Output Sensitivity Function (S_{yp})')
    set(findall(gcf,'Type','line'),'LineWidth',2);

    figure()
    plotKS0 = bodeplot(KS0, {2*pi*10, pi/Te});
    setoptions(plotKS0,'FreqUnits','Hz','PhaseVisible','off'); 
    title('Input Sensitivity Function (S_{up})')
    set(findall(gcf,'Type','line'),'LineWidth',2);

    figure()
    plotT = bodeplot(T, {2*pi*10, pi/Te});
    setoptions(plotT,'FreqUnits','Hz','PhaseVisible','off');
    title('Complementary Sensitivity Function (S_{yr})')
    set(findall(gcf,'Type','line'),'LineWidth',2);
end