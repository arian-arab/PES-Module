function spectrum_1d_mouse_up(data)
for i=1:length(data)    
    x_data{i} = data{i}.x_data;
    y_data{i} = data{i}.y_data;
    name{i} = data{i}.name;
    min_x(i) = min(x_data{i});
    min_y(i) = min(y_data{i});
    max_x(i) = max(x_data{i});
    max_y(i) = max(y_data{i});
    name{i} = data{i}.name;
end
ax = gca; cla(ax);
for i=1:length(data)
    plot(x_data{i},y_data{i})
    hold on
end
try
    xlim([min(min_x) max(max_x)])
end
try
    ylim([min(min_y) max(max_y)])
end
set(gca,'TickLength',[0.02 0.02],'FontName','TimesNewRoman','FontSize',12,'TickLabelInterpreter','latex')
box on
if length(data)<10
    legend(regexprep(name,'_',' '))
end
end