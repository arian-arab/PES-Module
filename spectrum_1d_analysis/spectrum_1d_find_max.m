function spectrum_1d_find_max(data)
input_values = inputdlg({'Number of Maximum points:'},'',1,{'1'});
if isempty(input_values)==1
    return
else
    n=str2double(input_values{1,1});
    for k=1:length(data)
        [~,I]=maxk(data{k}.y_data,n);
        x_max_data(k,:)=data{k}.x_data(I);
        y_max_data(k,:)=data{k}.y_data(I);
        clear I     
        names{k} = data{k}.name;
    end
    figure('name','x data maximum','NumberTitle','off','position',[100 200 680 420],'ToolBar','none','MenuBar', 'none');
    uitable('Data',x_max_data,'position',[10 10 640 400],'FontSize',12,'RowName',names);

    figure('name','y data maximum','NumberTitle','off','position',[120 220 680 420],'ToolBar','none','MenuBar', 'none');
    uitable('Data',y_max_data,'position',[10 10 640 400],'FontSize',12,'RowName',names);
end
end