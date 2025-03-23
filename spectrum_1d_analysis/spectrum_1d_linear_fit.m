function spectrum_1d_linear_fit(data)
uiwait(msgbox('select region for linear fit','modal'));
[xi,~] = getline;
if length(xi)>1
    for k=1:length(data)
        x = data{k}.x_data;
        y = data{k}.y_data;
        [~,x_ini] = min(abs(x-xi(1)));
        [~,x_fin] = min(abs(x-xi(2)));
        I1 = min(x_ini,x_fin);
        I2 = max(x_ini,x_fin);
        x_to_fit = x(I1:I2);
        y_to_fit = y(I1:I2);
        lin_fit=polyfit(x_to_fit,y_to_fit,1);
        y_fit=lin_fit(1)*x_to_fit+lin_fit(2);
        data_to_fit{k}.x_data = x_to_fit;
        data_to_fit{k}.y_data = y_to_fit;
        data_to_fit{k}.name = data{k}.name;
        data_to_fit{k}.type = 'spectrum_1d';
        data_to_fit{k}.info = 'NaN';
        data_fitted{k}.x_data = x_to_fit;
        data_fitted{k}.y_data = y_fit;
        data_fitted{k}.name = [data{k}.name,'_linear_fit'];
        data_fitted{k}.type = 'spectrum_1d';
        data_fitted{k}.info = 'NaN';
        names{k} = data{k}.name;
        fitted_par{k,1} = lin_fit(1);
        fitted_par{k,2} = lin_fit(2);
        clear x y x_ini x_fin I1 I2 x_to_fit y_to_fit lin_fit y_fit
    end
    data_to_send = [data_to_fit,data_fitted];
    spectrum_1d_plot(data_to_send)
    figure('name','Linear Fit','NumberTitle','off','Resize','off','units','normalized','Position',[0 0.1 1 0.4],'ToolBar','none','MenuBar', 'none')
    column_width{1} = 200;
    column_width{2} = 200;
    column_names = {'slope','b'};
    uitable('Data',fitted_par,'units','normalized','Position',[0 0 1 1],'FontSize',12,'ColumnName',column_names,'RowName',names,'ColumnWidth',column_width);
end
end