function spectrum_1d_arian_plot(data)
figure()
for k=1:length(data)    
    names{k} = data{k}.name;
    plot(data{k}.x_data,data{k}.y_data,'linewidth',1.1);
    hold on
    min_x(k) = min(data{k}.x_data);
    max_x(k) = max(data{k}.x_data);
end
xlim([min(min_x) max(max_x)])
legend(regexprep(names,'_',' '))
set(gcf,'color','w')
set(gca,'TickDir', 'out','box','on','BoxStyle','full','color','w');
set(gca,'TickLength',[0.02 0.02],'FontName','TimesNewRoman','FontSize',12,'TickLabelInterpreter','latex')
box on
xlabel('Potential (V)','interpreter','latex','fontsize',18)
ylabel('Current (Amp)','interpreter','latex','fontsize',18)
end