function spectrum_1d_change_x_data(data)
x_ini=data{1}.x_data(1);
x_step=data{1}.x_data(2)-data{1}.x_data(1);
input_values = inputdlg({'X Initial:','X Step'},'',1,{num2str(x_ini),num2str(x_step)});
if isempty(input_values)==1
    return
else
    x_ini=str2double(input_values{1,1});
    x_step=str2double(input_values{2,1});
    for k=1:length(data)
        data{k}.x_data= (x_ini:x_step:x_ini+(length(data{k}.x_data)-1)*x_step)';        
    end 
end
spectrum_1d_plot(data)
end