function spectrum_1d_show_data(data)
for k=1:length(data)
    figure('name',data{k}.name,'NumberTitle','off','Resize','off','units','normalized','Position',[0.1 0.3 0.3 0.4],'ToolBar','none','MenuBar', 'none')
    temp(:,1) = round(data{k}.x_data,4);
    temp(:,2) = round(data{k}.y_data,4);
    names = {'x_data','y_data'};
    column_width = {100,100};
    uitable('Data',temp,'units','normalized','Position',[0 0 1 1],'FontSize',12,'ColumnName',names,'ColumnWidth',column_width);
    drawnow
end
end