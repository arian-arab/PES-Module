function table_data_plot(data,row_names,column_names,title)
figure('name',title,'NumberTitle','off','units','normalized','position',[0 0.1 1 0.4],'ToolBar','none','MenuBar', 'none');
column_width = {200};
uitable('Data',data,'units','normalized','position',[0 0 1 1],'FontSize',12,'RowName',row_names,'ColumnName',column_names,'columnwidth',column_width);
end