function spectrum_2d_show_data(data)
for k=1:length(data)
    figure('name',data{k}.name,'NumberTitle','off','Resize','off','units','normalized','Position',[0 0.1 0.3 0.4],'ToolBar','none','MenuBar', 'none')
    uitable('Data',data{k}.c_data,'units','normalized','Position',[0 0 1 1],'FontSize',12); 
    drawnow
end
end