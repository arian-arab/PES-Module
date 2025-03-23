function spectrum_1d_norm_pre_post(data)
input_values = inputdlg({'Number of points to average:'},'',1,{'5'});
if isempty(input_values)==1
    return
else
    n=ones(length(data),1)*str2double(input_values{1,1});    
    for k=1:length(data)
        if n(k)>length(data{k}.x_data)
            n(k) = length(data{k}.x_data);
        end
        data{k}.y_data=data{k}.y_data-mean(data{k}.y_data(end-n(k):end));
        data{k}.y_data=data{k}.y_data./mean(data{k}.y_data(1:n(k)));
    end
    spectrum_1d_plot(data)
end