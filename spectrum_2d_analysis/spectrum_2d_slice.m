function spectrum_2d_slice(data)
input_values = inputdlg({'Number of profiles along y-axis:'},'',1,{'5'});
if isempty(input_values)==1
    return
else
    num = str2double(input_values{1});
    num = num+1;
    for k=1:length(data)
        if mod(data{k}.y_data,num)~=0
            n_y=ceil(length(data{k}.y_data)/num);
            n_y = num*n_y;
            yq = linspace(data{k}.y_data(1),data{k}.y_data(end),n_y);
            x = data{k}.x_data;
            y = data{k}.y_data;
            c = data{k}.c_data;
            c_data_interp = interp2(x,y,c,x,yq');
            data{k}.y_data = yq;
            data{k}.c_data = c_data_interp;
            clear xq yq c_data_interp x y c
        end
        
        to_go = linspace(1,length(data{k}.y_data),num);
        to_go = floor(to_go);
        for i=1:num-1
            data_slice = data{k}.c_data(to_go(i):to_go(i+1),:);
            x_data = data{k}.y_data(to_go(i):to_go(i+1));
            y_data = data{k}.x_data;
            data_to_send{i}.x_data = y_data;
            data_to_send{i}.y_data = x_data;
            data_to_send{i}.c_data = data_slice;
            data_to_send{i}.type = 'spectrum_2d';
            data_to_send{i}.info = 'NaN';
            data_to_send{i}.name = [data{k}.name,'_slice_along_y_',num2str(i)];
            clear x_data y_data data_slice
        end
        data_wanted{k} = data_to_send;
        clear data_to_send to_go
    end
    data_wanted = horzcat(data_wanted{:});
    spectrum_2d_plot(data_wanted)
end
end