function spectrum_2d_change_x_y_data(data)
x_ini=data{1}.x_data(1);
x_step=data{1}.x_data(2)-data{1}.x_data(1);
y_ini=data{1}.y_data(1);
y_step=data{1}.y_data(2)-data{1}.y_data(1);
input_values = inputdlg({'X Initial:','X Step','Y Initial:','Y Step'},'',1,{num2str(x_ini),num2str(x_step),num2str(y_ini),num2str(y_step)});
if isempty(input_values)==1
    return
else
    x_ini=str2double(input_values{1});
    x_step=str2double(input_values{2});
    y_ini=str2double(input_values{3});
    y_step=str2double(input_values{4});      
    for k=1:length(data)
        data{k}.x_data= (x_ini:x_step:x_ini+(length(data{k}.x_data)-1)*x_step)';
        data{k}.y_data= (y_ini:y_step:y_ini+(length(data{k}.y_data)-1)*y_step)'; 
    end 
end
spectrum_2d_plot(data)
end