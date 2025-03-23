function spectrum_2d_remove_background(data)
input_values = inputdlg({'disk radius:'},'',1, {'10'});
if isempty(input_values)==1
    return
else
    disk_radius=round(str2double(input_values{1,1}));
    se = strel('disk',disk_radius);    
    for k=1:length(data)
        background = imopen(data{k}.c_data,se);
        data{k}.c_data = data{k}.c_data-background;
    end    
    spectrum_2d_plot(data)
end
end