function spectrum_1d_plot(data)
figure()
set(gcf,'name','1D Spectrum Toolbox','NumberTitle','off','color','w','units','normalized','position',[0.3 0.2 0.4 0.6],'WindowButtonDownFcn',@mouse_down,'WindowButtonUpFcn',@mouse_up,'menubar','none','toolbar','figure')
spectrum_1d_mouse_up(data)

    function mouse_down(~,~)
        if isequal(get(gcf,'SelectionType'),'normal')            
        elseif isequal(get(gcf,'SelectionType'),'alt') 
            set(gcf,'WindowButtonMotionFcn',@mouse_move_right)
        end
    end

    function mouse_move_right(~,~)
        spectrum_1d_right_click(data)        
    end

    function mouse_up(~,~)
        set(gcf,'WindowButtonMotionFcn',@mouse_not_move)
        spectrum_1d_mouse_up(data)
    end

    function mouse_not_move(~,~)
    end

file_menu=uimenu('Text','File');
uimenu(file_menu,'Text','Send data to work space','ForegroundColor','k','CallBack',@send_data_to_workspace_callback);
uimenu(file_menu,'Text','Show data','ForegroundColor','k','CallBack',@show_data);
uimenu(file_menu,'Text','Save data as ASCII','ForegroundColor','k','CallBack',@save_ASCII);
uimenu(file_menu,'Text','Show info data','ForegroundColor','k','CallBack',@show_info_callback);

data_analysis=uimenu('Text','Data Analysis');
uimenu(data_analysis,'Text','crop by dragging','ForegroundColor','k','CallBack',@crop);
uimenu(data_analysis,'Text','crop by entering values','ForegroundColor','k','CallBack',@crop_enter_values);
uimenu(data_analysis,'Text','change x_data','ForegroundColor','b','CallBack',@change_x_data);
uimenu(data_analysis,'Text','swtich x-y data','ForegroundColor','b','CallBack',@switch_x_y_data);
uimenu(data_analysis,'Text','flip data left-right','ForegroundColor','b','CallBack',@flip_lr);
uimenu(data_analysis,'Text','interpolate data','ForegroundColor','m','CallBack',@interpolate_data);
uimenu(data_analysis,'Text','add by a number','ForegroundColor','r','CallBack',@add_by_number);
uimenu(data_analysis,'Text','subtract by a number','ForegroundColor','r','CallBack',@subtract_by_number);
uimenu(data_analysis,'Text','multiply by a number','ForegroundColor','r','CallBack',@multiply_by_number);
uimenu(data_analysis,'Text','divide by a number','ForegroundColor','r','CallBack',@divide_by_number);
uimenu(data_analysis,'Text','area under the graph','ForegroundColor','b','CallBack',@area_under);
uimenu(data_analysis,'Text','find maximum','ForegroundColor','k','CallBack',@find_max);
uimenu(data_analysis,'Text','find minimum','ForegroundColor','k','CallBack',@find_min);
uimenu(data_analysis,'Text','add spectrum','ForegroundColor','r','CallBack',@add);
uimenu(data_analysis,'Text','subtract two spectrum','ForegroundColor','r','CallBack',@subtract);
uimenu(data_analysis,'Text','multiply spectrum','ForegroundColor','r','CallBack',@multiply);
uimenu(data_analysis,'Text','divide two spectrum','ForegroundColor','r','CallBack',@divide);
uimenu(data_analysis,'Text','mean spectrum','ForegroundColor','r','CallBack',@mean);
uimenu(data_analysis,'Text','derivative spectrum','ForegroundColor','r','CallBack',@derivative);
uimenu(data_analysis,'Text','log10','ForegroundColor','k','CallBack',@log);
uimenu(data_analysis,'Text','hilbert transform','ForegroundColor','k','CallBack',@hilbert_transform);
uimenu(data_analysis,'Text','shift x-data by some value','ForegroundColor','b','CallBack',@shift_data_by_value);
uimenu(data_analysis,'Text','shift x-data by values from external file','ForegroundColor','b','CallBack',@shift_data_by_file);
uimenu(data_analysis,'Text','combine spectrum to image','ForegroundColor','k','CallBack',@combine_to_image);
uimenu(data_analysis,'Text','subtract shirley background','ForegroundColor','k','CallBack',@subtract_shirley);
uimenu(data_analysis,'Text','broaden spectra by Gaussian convolution','ForegroundColor','r','CallBack',@gaussian_broadening);
uimenu(data_analysis,'Text','convolution between two functions','ForegroundColor','r','CallBack',@convolution);
uimenu(data_analysis,'Text','plot waterfall graph','ForegroundColor','r','CallBack',@plot_waterfall);
uimenu(data_analysis,'Text','plot waterfall graph','ForegroundColor','r','CallBack',@plot_arian);



fit_menu=uimenu('Text','Fit Functions');
uimenu(fit_menu,'Text','Fermi Function Fit','ForegroundColor','k','CallBack',@fermi_fit);
uimenu(fit_menu,'Text','Voigt Peak Fit','ForegroundColor','k','CallBack',@voigt_fit);
uimenu(fit_menu,'Text','Gold Fermi Edge FWHM Fit','ForegroundColor','k','CallBack',@gold_fermi_edge_fit);
uimenu(fit_menu,'Text','Linear Fit','ForegroundColor','k','CallBack',@linear_fit);
uimenu(fit_menu,'Text','Remove Linear Fit','ForegroundColor','k','CallBack',@remove_linear_fit);
uimenu(fit_menu,'Text','Log Normal Fit','ForegroundColor','k','CallBack',@log_normal_fit);


normalize_menu=uimenu('Text','Normalization');
uimenu(normalize_menu,'Text','Normalize to area under the graph','ForegroundColor','k','CallBack',@normalize_area);
uimenu(normalize_menu,'Text','Normalize to pre-edge and post-edge','ForegroundColor','k','CallBack',@normalize_per_post);
uimenu(normalize_menu,'Text','Normalize "to" "and"','ForegroundColor','k','CallBack',@normalize_to_and);
uimenu(normalize_menu,'Text','Normalize "to"','ForegroundColor','k','CallBack',@normalize_to);
uimenu(normalize_menu,'Text','Normalize "and"','ForegroundColor','k','CallBack',@normalize_and);
uimenu(normalize_menu,'Text','Normalize "to" values from external File','ForegroundColor','k','CallBack',@normalize_to_values);
uimenu(normalize_menu,'Text','Normalize "and" values from external File','ForegroundColor','k','CallBack',@normalize_and_values);

probability_menu=uimenu('Text','Probability');
uimenu(probability_menu,'Text','Log Normal Convolution Fit','ForegroundColor','k','CallBack',@log_normal_conv_fit);
uimenu(probability_menu,'Text','Histogram Plot','ForegroundColor','b','CallBack',@histogram_plot);
    
    function send_data_to_workspace_callback(~,~)
        send_data_to_workspace(data)
    end

    function save_ASCII(~,~)
        spectrum_1d_save_ASCII(data)
    end

    function show_info_callback(~,~)
        show_info(data{1})
    end

    function crop(~,~)
        spectrum_1d_crop(data)
    end

    function crop_enter_values(~,~)
        spectrum_1d_crop_enter_values(data)
    end

    function change_x_data(~,~)
        spectrum_1d_change_x_data(data)
    end

    function interpolate_data(~,~)
        spectrum_1d_interpolate_data(data)
    end

    function switch_x_y_data(~,~)
        spectrum_1d_switch_x_y_data(data)
    end

    function flip_lr(~,~)
        spectrum_1d_flip_lr(data)
    end

    function add_by_number(~,~)
        spectrum_1d_add_by_number(data)
    end

    function subtract_by_number(~,~)
        spectrum_1d_subtract_by_number(data)
    end

    function multiply_by_number(~,~)
        spectrum_1d_multiply_by_number(data)
    end

    function divide_by_number(~,~)
        spectrum_1d_divide_by_number(data)
    end

    function area_under(~,~)
        spectrum_1d_area(data)
    end

    function normalize_area(~,~)
        spectrum_1d_normalize_area(data)
    end

    function find_max(~,~)
        spectrum_1d_find_max(data)
    end

    function find_min(~,~)
        spectrum_1d_find_min(data)
    end

    function add(~,~)
        spectrum_1d_add_spectrum(data)
    end

    function subtract(~,~)
        spectrum_1d_subtract_spectrum(data)
    end

    function multiply(~,~)
        spectrum_1d_multiply_spectrum(data)
    end

    function divide(~,~)
        spectrum_1d_divide_spectrum(data)
    end

    function mean(~,~)
        spectrum_1d_mean_spectrum(data)
    end

    function derivative(~,~)
        spectrum_1d_derivative(data)
    end

    function log(~,~)
        spectrum_1d_log(data)
    end

    function hilbert_transform(~,~)
        spectrum_1d_hilbert_transform(data)
    end

    function convolution(~,~)
        spectrum_1d_convolution_spectrum(data)
    end

    function plot_waterfall(~,~)
        spectrum_1d_waterfall_plot(data)
    end

    function plot_arian(~,~)
        spectrum_1d_arian_plot(data)
    end

    function show_data(~,~)
        spectrum_1d_show_data(data)
    end

    function shift_data_by_value(~,~)
        spectrum_1d_shift_data_by_value(data)
    end

    function shift_data_by_file(~,~)
        spectrum_1d_shift_data_by_file(data)
    end

    function fermi_fit(~,~)
        spectrum_1d_fermi_fit(data)
    end

    function voigt_fit(~,~)
        spectrum_1d_voigt_fit(data)
    end

    function gold_fermi_edge_fit(~,~)
        spectrum_1d_gold_fermi_edge_fit(data)
    end

    function linear_fit(~,~)
        spectrum_1d_linear_fit(data)
    end

    function remove_linear_fit(~,~)
        spectrum_1d_remove_linear_fit(data);        
    end

    function log_normal_fit(~,~)
        spectrum_1d_log_normal_fit(data);        
    end

    function log_normal_conv_fit(~,~)
        spectrum_1d_log_normal_conv_fit(data);        
    end

    function normalize_per_post(~,~)
        spectrum_1d_norm_pre_post(data)
    end

    function normalize_to_and(~,~)
        spectrum_1d_norm_to_and(data)
    end

    function normalize_to(~,~)
        spectrum_1d_norm_to(data)
    end

    function normalize_and(~,~)
        spectrum_1d_norm_and(data)        
    end

    function normalize_to_values(~,~)
        spectrum_1d_norm_to_values(data)
    end

    function normalize_and_values(~,~)
        spectrum_1d_norm_and_values(data)
    end

    function combine_to_image(~,~)
        spectrum_1d_combine_to_image(data)
    end

    function subtract_shirley(~,~)
        spectrum_1d_subtract_shirley(data)
    end

    function gaussian_broadening(~,~)
        spectrum_1d_gaussian_broadening(data)
    end

    function histogram_plot(~,~)
        spectrum_1d_histogram_plot(data)
    end
end