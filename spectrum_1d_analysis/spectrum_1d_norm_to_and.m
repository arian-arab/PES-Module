function spectrum_1d_norm_to_and(data)
input_values = inputdlg({'to:','and:','number of points'},'',1,{num2str(data{1}.x_data(1)),num2str(data{1}.x_data(end)),'5'});
if isempty(input_values)==1
    return
else
    x1=str2double(input_values{1,1});
    x2=str2double(input_values{2,1});
    n=ones(length(data),1)*str2double(input_values{3,1});  
    for k=1:length(data)
        if n(k)>length(data{k}.x_data)
            n(k) = length(data{k}.x_data);
        end
        [~,I1]=min(abs(x1-data{k}.x_data));
        [~,I2]=min(abs(x2-data{k}.x_data));
        if n(k)==1
            data{k}.y_data=data{k}.y_data-data{k}.y_data(I1);
            data{k}.y_data=data{k}.y_data/data{k}.y_data(I2);
        elseif mod(n(k),2) == 0
            data{k}.y_data=data{k}.y_data-mean(data{k}.y_data(I1-n(k)/2:I1+n(k)/2-1));
            data{k}.y_data=data{k}.y_data./mean(data{k}.y_data(I2-n(k)/2:I2+n(k)/2-1));
        else
            data{k}.y_data=data{k}.y_data-mean(data{k}.y_data(I1-(n(k)-1)/2:I1+(n(k)-1)/2));
            data{k}.y_data=data{k}.y_data/mean(data{k}.y_data(I2-(n(k)-1)/2:I2+(n(k)-1)/2));
        end
        clear I1 I2
    end
    spectrum_1d_plot(data)
end