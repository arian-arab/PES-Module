function spectrum_1d_crop_enter_values(data)
for i=1:length(data)
    min_x(i) = min(data{i}.x_data);
    max_x(i) = max(data{i}.x_data);
end
input_values = inputdlg({'X1:','X2:'},'',1, {num2str(min(min_x)),num2str(max(max_x))});
if isempty(input_values)==1
    return
else
    x1=str2double(input_values{1,1});
    x2=str2double(input_values{2,1});
    X1=min(x1,x2);
    X2=max(x1,x2);
    for k=1:length(data)
        x_data = data{k}.x_data;
        y_data = data{k}.y_data;
        [~,XI1]=min(abs(x_data-X1));
        [~,XI2]=min(abs(x_data-X2));
        if XI1==XI2
            return
        else
            I1=min(XI1,XI2);
            I2=max(XI1,XI2);
            data{k}.x_data = x_data(I1:I2);
            data{k}.y_data = y_data(I1:I2);
        end
        clear I1 I2 XI1 XI2 x_data y_data
    end
    spectrum_1d_plot(data)
end
end