function spectrum_1d_area(data)
for k=1:length(data)    
    area{k} = sprintf('%2.4f',round(trapz(data{k}.x_data,data{k}.y_data),4));
    names{k} = data{k}.name;
end
figure('name','Area under the graph','NumberTitle','off','Resize','off','units','normalized','Position',[0 0.1 1 0.4],'ToolBar','none','MenuBar', 'none')
column_width{1} = 200;
uitable('Data',area','units','normalized','Position',[0 0 1 1],'FontSize',13,'RowName',names,'ColumnWidth',column_width);
end