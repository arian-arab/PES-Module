function spectrum_3d_analyze_data(data)
v_data = data.v_data;
info = data.info;
for k=1:size(v_data,3)
    data_to_send{k}.c_data = v_data(:,:,k);
    data_to_send{k}.x_data = data.y_data';
    data_to_send{k}.y_data = data.x_data';
    data_to_send{k}.name = [data.name,'_',num2str(round(data.z_data(k),3))];
    data_to_send{k}.type = 'spectrum_2d';
    data_to_send{k}.info = info;
end
spectrum_2d_plot(data_to_send);