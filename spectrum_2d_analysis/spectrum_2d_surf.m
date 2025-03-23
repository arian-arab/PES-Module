function spectrum_2d_surf(data)
for k=1:length(data)
    n_x = length(data{k}.x_data);
    n_y = length(data{k}.y_data);
end
n_x = max(n_x);
n_y = max(n_y);
for k=1:length(data)
    xq = linspace(data{k}.x_data(1),data{k}.x_data(end),n_x);
    yq = linspace(data{k}.y_data(1),data{k}.y_data(end),n_y);
    x = data{k}.x_data;
    y = data{k}.y_data;
    c = data{k}.c_data;
    c_data_interp = interp2(x,y,c,xq,yq');
    data{k}.x_data = xq;
    data{k}.y_data = yq;
    data{k}.c_data = c_data_interp;
    clear xq yq c_data_interp x y c
end

[X,Y]=meshgrid(data{1}.x_data,data{1}.y_data);
figure()
set(gcf,'color','white')
for k=1:length(data)
    Z=(X-X)+k/10;
    data_plot=data{k}.c_data;
    data_plot(data_plot==0)=NaN;
    surf(X,Y,Z,data_plot,'LineStyle','none')
    axis equal
    hold on
end
xlim([min(data{1}.x_data) max(data{1}.x_data)])
ylim([min(data{1}.y_data) max(data{1}.y_data)])
set(gca,'TickDir','out','TickLength',[0.02 0.02],'FontName','TimesNewRoman','FontSize',12,'TickLabelInterpreter','latex','box','on','boxstyle','full')
end