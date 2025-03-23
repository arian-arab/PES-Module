function spectrum_1d_crop(data)
rec_coordinates=getrect;
if isempty(rec_coordinates)
    return
else
x1=rec_coordinates(1);
x2=x1+rec_coordinates(3);
end
X1=min(x1,x2);
X2=max(x1,x2);
for k=1:length(data)
    x_data = data{k}.x_data;
    y_data = data{k}.y_data;
    [~,XI1]=min(abs(x_data-X1));
    [~,XI2]=min(abs(x_data-X2));
    if XI1==XI2
        return
    else
        I1=min(XI1,XI2);
        I2=max(XI1,XI2);
        data{k}.x_data = x_data(I1:I2);
        data{k}.y_data = y_data(I1:I2);
    end
    clear I1 I2 XI1 XI2 x_data y_data
end
spectrum_1d_plot(data)
end