function spectrum_1d_convolution_spectrum(data)
if length(data)>2
    msgbox('only two spectra can be selected')
elseif length(data) ==1
    msgbox('two spectra should be selected')
else    
    data_one = data{1}.y_data;
    data_two = data{2}.y_data;
    convoluted_profile = conv(data_one,data_two,'same');
    data_divide{1}.x_data = data{1}.x_data;
    data_divide{1}.y_data = convoluted_profile;
    data_divide{1}.name='convoluted spectrum';
    data_divide{1}.type = 'spectrum_1d';
    data_divide{1}.info = 'NaN';
    spectrum_1d_plot(data_divide)
end
end