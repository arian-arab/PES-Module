function spectrum_2d_mouse_up(data)
x_data = data.x_data;
y_data = data.y_data;
c_data = data.c_data;
name = data.name;

int_along_y=sum(c_data,2);
int_along_x=sum(c_data,1);

subplot(2,2,1)
imagesc('xdata',x_data,'ydata',y_data,'cdata',c_data)
xlim([min(x_data) max(x_data)])
ylim([min(y_data) max(y_data)])
title({'',regexprep(name,'_',' ')},'Interpreter','latex','fontsize',14)
set(gca,'TickDir','out','TickLength',[0.02 0.02],'FontName','TimesNewRoman','FontSize',12,'TickLabelInterpreter','latex')
box on

subplot(2,2,2)
ax = gca; cla(ax);
plot(y_data,int_along_y,'b')
xlim([min(y_data) max(y_data)])
% if int_along_y==0
%     ylim auto
% else
%     ylim([min(int_along_y) max(int_along_y)])
% end
title('Integrated along x-axis','interpreter','latex','fontsize',10)
set(gca,'YDir','reverse','TickDir','out','TickLength',[0.02 0.02],'FontName','TimesNewRoman','FontSize',12,'TickLabelInterpreter','latex')
camroll(90)

subplot(2,2,3)
ax = gca; cla(ax);
plot(x_data,int_along_x,'k')
xlim([min(x_data) max(x_data)])
% if int_along_x==0
%     ylim auto
% else
%     ylim([min(int_along_x) max(int_along_x)])
% end
title('Integrated along y-axis','interpreter','latex','fontsize',10)
set(gca,'TickDir','out','TickLength',[0.02 0.02],'FontName','TimesNewRoman','FontSize',12,'TickLabelInterpreter','latex')
end