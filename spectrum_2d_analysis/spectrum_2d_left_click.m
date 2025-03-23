function spectrum_2d_left_click(data)
x_data = data.x_data;
y_data = data.y_data;
c_data = data.c_data;
name = data.name;
subplot(2,2,1)
ax = gca; cla(ax);
mouse_location = get(gca,'CurrentPoint');
x_mouse=mouse_location(1,1);
y_mouse=mouse_location(1,2);
imagesc('xdata',x_data,'ydata',y_data,'cdata',c_data)
xlim([min(x_data) max(x_data)])
ylim([min(y_data) max(y_data)])
title({'',regexprep(name,'_',' ')},'Interpreter','latex','fontsize',14)
line([x_mouse x_mouse],[min(y_data) max(y_data)],'Color','b','LineStyle','--')
line([min(x_data) max(x_data)],[y_mouse y_mouse],'Color','k','LineStyle','--')
if x_mouse<max(x_data) && x_mouse>min(x_data) && y_mouse<max(y_data) && y_mouse>min(y_data)
    text(x_mouse,y_mouse,strcat('(',num2str(round(x_mouse,2)),',',num2str(round(y_mouse,2)),')'),'Color','k','interpreter','latex','FontSize',22)
end
set(gca,'TickDir','out','TickLength',[0.02 0.02],'FontName','TimesNewRoman','FontSize',12,'TickLabelInterpreter','latex')

subplot(2,2,2)
ax = gca; cla(ax);
[~,I]=min(abs(x_data-x_mouse));
plot(y_data,c_data(:,I),'b')
xlim([min(y_data) max(y_data)])
line([y_mouse y_mouse],[min(c_data(:,I)) max(c_data(:,I))],'Color','k','linestyle','--')
if sum(c_data(:,I))==0
    ylim auto
else
    ylim([min(c_data(:,I)) max(c_data(:,I))])
end
title('Integrated along x-axis','interpreter','latex','fontsize',10)
set(gca,'YDir','reverse','TickDir','out','TickLength',[0.02 0.02],'FontName','TimesNewRoman','FontSize',12,'TickLabelInterpreter','latex')
camroll(90)

subplot(2,2,3);
ax = gca; cla(ax);
[~,I]=min(abs(y_data-y_mouse));
plot(x_data,c_data(I,:),'k')
xlim([min(x_data(:)) max(x_data(:))])
line([x_mouse x_mouse],[min(c_data(I,:)) max(c_data(I,:))],'Color','b','linestyle','--')
if sum(c_data(I,:))==0
    ylim auto
else
    ylim([min(c_data(I,:)) max(c_data(I,:))])
end
title('Integrated along y-axis','interpreter','latex','fontsize',10)
set(gca,'TickDir','out','TickLength',[0.02 0.02],'FontName','TimesNewRoman','FontSize',12,'TickLabelInterpreter','latex')
end