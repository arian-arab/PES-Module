function spectrum_1d_histogram_plot(data)
input_values = inputdlg({'number of bins:'},'',1,{'100'});
if isempty(input_values)==1
    return
else
    N = str2double(input_values{1});
    for k=1:length(data)
        [counts,centers] = hist(data{k}.y_data,N);
        data{k}.x_data = centers;
        data{k}.y_data = counts;
        clear counts centers 
    end
    spectrum_1d_plot(data)
end
end