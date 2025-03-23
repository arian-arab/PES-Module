function spectrum_1d_remove_linear_fit(data)
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
        
        y_remove = y_to_fit-y_fit+y_to_fit(1);
        y_final = y;
        y_final(I1:I2) = y_remove;
        
        data_fitted{k}.x_data = x;
        data_fitted{k}.y_data = y_final;
        data_fitted{k}.name = [data{k}.name,'_linear_fit_removed'];
        data_fitted{k}.type = 'spectrum_1d';
        data_fitted{k}.info = 'NaN';
        names{k} = data{k}.name;
        fitted_par{k,1} = lin_fit(1);
        fitted_par{k,2} = lin_fit(2);
        clear x y x_ini x_fin I1 I2 x_to_fit y_to_fit lin_fit y_fit
    end
    spectrum_1d_plot(data_fitted)
    
    figure('name','Linear Fit','NumberTitle','off','Resize','off','units','normalized','Position',[0 0.1 1 0.4],'ToolBar','none','MenuBar', 'none')
    column_width{1} = 200;
    column_width{2} = 200;
    column_names = {'slope','b'};
    uitable('Data',fitted_par,'units','normalized','Position',[0 0 1 1],'FontSize',12,'ColumnName',column_names,'RowName',names,'ColumnWidth',column_width);
end
end