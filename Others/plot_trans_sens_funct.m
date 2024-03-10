function plot_trans_sens_funct(S0,KS0,T,SG,K,L,Te)
    % Sensitivity functions
    figure()
    subplot(2,2,1);
    plotS0 = bodeplot(S0, {2*pi*10, pi/Te});
    setoptions(plotS0,'FreqUnits','Hz','PhaseVisible','off');
    title('Output Sensitivity Function (S_{0})')
    set(findall(gcf,'Type','line'),'LineWidth',2);

    subplot(2,2,2);
    plotKS0 = bodeplot(KS0, {2*pi*10, pi/Te});
    setoptions(plotKS0,'FreqUnits','Hz','PhaseVisible','off'); 
    title('Input Sensitivity Function (KS_{0})')
    set(findall(gcf,'Type','line'),'LineWidth',2);

    subplot(2,2,3);
    plotT = bodeplot(T, {2*pi*10, pi/Te});
    setoptions(plotT,'FreqUnits','Hz','PhaseVisible','off');
    title('Complementary Sensitivity Function (T)')
    set(findall(gcf,'Type','line'),'LineWidth',2);

    subplot(2,2,4);
    plotSG = bodeplot(SG, {2*pi*10, pi/Te});
    setoptions(plotSG,'FreqUnits','Hz','PhaseVisible','off');
    title('Sensitivity Function SG')
    set(findall(gcf,'Type','line'),'LineWidth',2);

    % Other functions
    figure()
    subplot(2,1,1);
    plotK = bodeplot(K, {2*pi*10, pi/Te});
    setoptions(plotK,'FreqUnits','Hz','PhaseVisible','off');
    title('Controller Transfer Function (K)')
    set(findall(gcf,'Type','line'),'LineWidth',2);

    subplot(2,1,2);
    plotL = bodeplot(L, {2*pi*10, pi/Te});
    setoptions(plotL,'FreqUnits','Hz','PhaseVisible','off');
    title('Open-Loop Transfer Function (L)')
    set(findall(gcf,'Type','line'),'LineWidth',2);
end