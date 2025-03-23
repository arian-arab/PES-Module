function spectrum_2d_crop(data)
subplot(2,2,1)
rec_coordinates=getrect;
if isempty(rec_coordinates)
    return
else
    x1 = rec_coordinates(1);
    x2 = x1+rec_coordinates(3);
    y1 = rec_coordinates(2);
    y2 = y1+rec_coordinates(4);
    for k=1:length(data)
        x_data = data{k}.x_data;
        y_data = data{k}.y_data;
        c_data = data{k}.c_data;
        [~,XI1]=min(abs(x_data-x1));
        [~,XI2]=min(abs(x_data-x2));
        [~,YI1]=min(abs(y_data-y1));
        [~,YI2]=min(abs(y_data-y2));
        I1=min(XI1,XI2);
        I2=max(XI1,XI2);
        I3=min(YI1,YI2);
        I4=max(YI1,YI2);
        if I1==I2 || I3==I4
            return
        else
            data{k}.x_data = x_data(I1:I2);
            data{k}.y_data = y_data(I3:I4);
            data{k}.c_data = c_data(I3:I4,I1:I2);
        end
        clear I1 I2 I3 I4 x_data y_data c_data
    end
    spectrum_2d_plot(data)
end
end