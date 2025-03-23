function spectrum_3d_mouse_up(data,slider_value,N)
v_data = data.v_data;
x_data = data.x_data;
y_data = data.y_data;
z_data = data.z_data;
c_data = data.v_data(:,:,slider_value);
I_z_data = sum(v_data,1);
I_z_data = sum(I_z_data,2);
I_z_data = permute(I_z_data,[3,1,2]);

subplot(2,2,1);
ax = gca; cla(ax);
imagesc('xdata',y_data,'ydata',x_data,'cdata',c_data)
colormap(hot)
caxis([min(min(c_data)) max(max(c_data))]);
set(gca,'TickDir', 'out','TickLabelInterpreter','latex','fontsize',12)
ylim([min(x_data) max(x_data)])
xlim([min(y_data) max(y_data)])

subplot(2,2,2)
ax = gca; cla(ax)
plot(x_data,sum(c_data,2),'color','r')
set(gca,'TickDir', 'out','TickLabelInterpreter','latex','fontsize',12)
xlim([min(x_data) max(x_data)])
camroll(90)
title('Integrated along x-axis','interpreter','latex','fontsize',10)

subplot(2,2,3)
ax = gca; cla(ax)
plot(y_data,sum(c_data,1),'color','b')
set(gca,'TickDir', 'out','TickLabelInterpreter','latex','fontsize',12)
xlim([min(y_data) max(y_data)])
title('Integrated along y-axis','interpreter','latex','fontsize',10)

subplot(2,2,4)
ax = gca; cla(ax)
plot(z_data,I_z_data,'color','k')
set(gca,'TickDir', 'out','TickLabelInterpreter','latex','fontsize',12)
xlim([min(z_data) max(z_data)])
ylim([min(I_z_data) max(I_z_data)])
line([z_data(slider_value) z_data(slider_value)],[min(I_z_data) max(I_z_data)],'Color','m','linewidth',1)
if N==1
    line([z_data(slider_value) z_data(slider_value)],[min(I_z_data) max(I_z_data)],'Color','m','linewidth',1)
elseif N+slider_value<=length(z_data)
    line([z_data(slider_value+N) z_data(slider_value+N)],[min(I_z_data) max(I_z_data)],'Color','m','linewidth',1)
elseif N+slider_value>length(z_data)
    return
end
title(['z = ',num2str(round(z_data(slider_value),3))],'interpreter','latex','fontsize',14)
end