function spectrum_2d_interpolate_data(data)
input_values = inputdlg({'Change number of x-data points to:','Change number of y-data points to:'},'',1,{num2str(length(data{1}.x_data)),num2str(length(data{1}.y_data))});
if isempty(input_values)==1
    return
else
    n_x=str2double(input_values{1});
    n_y=str2double(input_values{2});
    for k=1:length(data)
        xq = linspace(data{k}.x_data(1),data{k}.x_data(end),n_x);
        yq = linspace(data{k}.y_data(1),data{k}.y_data(end),n_y);
        x = data{k}.x_data;
        y = data{k}.y_data;
        c = data{k}.c_data;
        c_data_interp = interp2(x,y,c,xq,yq');
        data{k}.x_data = xq;
        data{k}.y_data = yq;
        data{k}.c_data = c_data_interp;
        clear xq yq c_data_interp x y c
    end
    spectrum_2d_plot(data)
end
end