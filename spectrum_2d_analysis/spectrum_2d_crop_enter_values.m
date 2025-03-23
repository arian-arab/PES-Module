function spectrum_2d_crop_enter_values(data)
for i=1:length(data)
    min_x(i) = min(data{i}.x_data);
    max_x(i) = max(data{i}.x_data);
    min_y(i) = min(data{i}.y_data);
    max_y(i) = max(data{i}.y_data);    
end
input_values = inputdlg({'X1:','X2:','Y1:','Y2:'},'',1, {num2str(min(min_x)),num2str(max(max_x)),num2str(max(min_y)),num2str(max(max_y))});
if isempty(input_values)==1
    return
else
    x1=str2double(input_values{1});
    x2=str2double(input_values{2});
    y1=str2double(input_values{3});
    y2=str2double(input_values{4});    
    X1=min(x1,x2);
    X2=max(x1,x2);
    Y1 = min(y1,y2);
    Y2 = max(y1,y2);
    for k=1:length(data)
        x_data = data{k}.x_data;
        y_data = data{k}.y_data;
        c_data = data{k}.c_data;
        [~,XI1]=min(abs(x_data-X1));
        [~,XI2]=min(abs(x_data-X2));
        [~,YI1]=min(abs(y_data-Y1));
        [~,YI2]=min(abs(y_data-Y2));
        if XI1==XI2 || YI1==YI2
            return
        else
            I1=min(XI1,XI2);
            I2=max(XI1,XI2);
            I3 = min(YI1,YI2);
            I4 = max(YI1,YI2);
            data{k}.x_data = x_data(I1:I2);
            data{k}.y_data = y_data(I3:I4);
            data{k}.c_data = c_data(I3:I4,I1:I2);
        end
        clear I1 I2 I3 I4 XI1 XI2 YI1 YI2 x_data y_data c_data
    end
end
    spectrum_2d_plot(data)
end