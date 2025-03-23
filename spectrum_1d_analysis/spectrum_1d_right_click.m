function spectrum_1d_right_click(data)
for i=1:length(data)    
    x_data{i} = data{i}.x_data;
    y_data{i} = data{i}.y_data;
    min_x(i) = min(x_data{i});
    min_y(i) = min(y_data{i});
    max_x(i) = max(x_data{i});
    max_y(i) = max(y_data{i});
    name{i} = data{i}.name;
end
ax = gca; cla(ax);
mouse_location = get(gca,'CurrentPoint');
x_mouse=mouse_location(1,1);
y_mouse=mouse_location(1,2);
for i=1:length(data)
    plot(x_data{i},y_data{i})
    hold on
end
xlim([min(min_x) max(max_x)])
ylim([min(min_y) max(max_y)])
line([x_mouse x_mouse],[min(min_y) max(max_y)],'Color','k','LineStyle','--')
line([min(min_x) max(max_x)],[y_mouse y_mouse],'Color','k','LineStyle','--')
if x_mouse<max(max_x) && x_mouse>min(min_x) && y_mouse<max(max_y) && y_mouse>min(min_y)
    text(x_mouse,y_mouse,strcat('(',num2str(round(x_mouse,4)),',',num2str(round(y_mouse,4)),')'),'Color','k','interpreter','latex','FontSize',22)
end
set(gca,'TickLength',[0.02 0.02],'FontName','TimesNewRoman','FontSize',12,'TickLabelInterpreter','latex')
end