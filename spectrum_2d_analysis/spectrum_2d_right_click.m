function spectrum_2d_right_click(data)
x_data = data.x_data;
y_data = data.y_data;
c_data = data.c_data;
name = data.name;
subplot(2,2,1)
ax = gca; cla(ax);
mouse_location = get(gca,'CurrentPoint');
imagesc('xdata',x_data,'ydata',y_data,'cdata',c_data)
xlim([min(x_data) max(x_data)])
ylim([min(y_data) max(y_data)])
title({'',regexprep(name,'_',' ')},'Interpreter','latex','fontsize',14)
line([mouse_location(1,1) mouse_location(1,1)],[min(y_data) max(y_data)],'Color','b','LineStyle','--')
line([min(x_data) max(x_data)],[mouse_location(1,2) mouse_location(1,2)],'Color','k','LineStyle','--')
if mouse_location(1,1)<max(x_data) && mouse_location(1,1)>min(x_data) && mouse_location(1,2)<max(y_data) && mouse_location(1,2)>min(y_data)
    [~,I1]=min(abs(x_data-mouse_location(1,1)));
    [~,I2]=min(abs(y_data-mouse_location(1,2)));
    text(mouse_location(1,1),mouse_location(1,2),{[strcat('(',num2str(round(mouse_location(1,1),2)),',',num2str(round(mouse_location(1,2),2)),')')],[num2str(c_data(I2,I1))]},'Color','k','interpreter','latex','FontSize',22)
end
set(gca,'TickDir','out','TickLength',[0.02 0.02],'FontName','TimesNewRoman','FontSize',12,'TickLabelInterpreter','latex')

subplot(2,2,2)
ax = gca; cla(ax);
[~,I]=min(abs(x_data-mouse_location(1,1)));
plot(y_data,c_data(:,I),'b')
xlim([min(y_data) max(y_data)])
line([mouse_location(1,2) mouse_location(1,2)],[min(c_data(:,I)) max(c_data(:,I))],'Color','b','linestyle','--')
if sum(c_data(:,I))==0
    ylim auto
else
    ylim([min(c_data(:,I)) max(c_data(:,I))])
end
title('Integrated along x-axis','interpreter','latex','fontsize',10)
camroll(90)
set(gca,'YDir','reverse','TickDir','out','TickLength',[0.02 0.02],'FontName','TimesNewRoman','FontSize',12,'TickLabelInterpreter','latex')

subplot(2,2,3);
[~,I]=min(abs(y_data-mouse_location(1,2)));
plot(x_data,c_data(I,:),'k')
xlim([min(x_data) max(x_data)])
line([mouse_location(1,1) mouse_location(1,1)],[min(c_data(I,:)) max(c_data(I,:))],'Color','k','linestyle','--')
if sum(c_data(I,:))==0
    ylim auto
else
    ylim([min(c_data(I,:)) max(c_data(I,:))])
end
title('Integrated along y-axis','interpreter','latex','fontsize',10)
set(gca,'TickDir','out','TickLength',[0.02 0.02],'FontName','TimesNewRoman','FontSize',12,'TickLabelInterpreter','latex')
end