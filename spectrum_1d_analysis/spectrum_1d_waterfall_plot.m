function spectrum_1d_waterfall_plot(data)
figure()
for k=1:length(data)
    z_data = ones(1,length(data{k}.x_data))+k-1;
    names{k} = data{k}.name;
    color = linspace(0,0.5,length(data));
    plot3(data{k}.x_data,z_data,data{k}.y_data,'linewidth',1.1,'color',[color(k) color(k) color(k)]);
    hold on
    min_x(k) = min(data{k}.x_data);
    max_x(k) = max(data{k}.x_data);
    int(k) = max(data{k}.y_data);
    min_val(k) = min(data{k}.y_data);
end
x = zeros(1,length(data))+data{1}.x_data(1);
y = 1:length(data);
plot3(x,y,int,'r','linewidth',2)
xlim([min(min_x) max(max_x)])
zlim([min(min_val) 1.1*max(int)])
legend(regexprep(names,'_',' '))
set(gcf,'color','w')
set(gca,'TickDir', 'out','box','on','BoxStyle','full','color','w');
set(gca,'TickLength',[0.02 0.02],'FontName','TimesNewRoman','FontSize',12,'TickLabelInterpreter','latex')
box on
view(14,14)
end