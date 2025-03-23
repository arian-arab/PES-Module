function data = spectrum_3d_permute_volume(data)
data.v_data = permute(data.v_data,[2 3 1]);
x_data = data.x_data;
y_data = data.y_data;
z_data = data.z_data;
data.x_data = y_data;
data.y_data = z_data;
data.z_data = x_data;
end