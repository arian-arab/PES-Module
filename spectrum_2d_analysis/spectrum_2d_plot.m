function spectrum_2d_plot(data)
figure()
set(gcf,'name','2D Spectrum Toolbox','NumberTitle','off','color','w','units','normalized','position',[0.3 0.2 0.4 0.6],'WindowButtonDownFcn',@mouse_down,'WindowButtonUpFcn',@mouse_up,'Menubar','none')
set(1,'defaultfiguretoolbar','figure');

if length(data)>1
    slider_step=[1/(length(data)-1),1];
    uicontrol('style','slider','units','normalized','position',[0,0,1,0.05],'value',1,'min',1,'max',length(data),'sliderstep',slider_step,'Callback',{@sld_callback});
end
slider_value=1;
spectrum_2d_mouse_up(data{slider_value})

    function sld_callback(hobj,~,~)
        slider_value = round(get(hobj,'Value'));
        spectrum_2d_mouse_up(data{slider_value})
    end

    function mouse_down(~,~)
        if isequal(get(gcf,'SelectionType'),'normal')
            set(gcf,'WindowButtonMotionFcn',@mouse_move_left)
        elseif isequal(get(gcf,'SelectionType'),'alt')
            set(gcf,'WindowButtonMotionFcn',@mouse_move_right)
        end
    end

    function mouse_move_right(~,~)
        spectrum_2d_right_click(data{slider_value})
    end

    function mouse_move_left(~,~)
    end

    function mouse_up(~,~)
        set(gcf,'WindowButtonMotionFcn',@mouse_not_move)
        spectrum_2d_mouse_up(data{slider_value})
    end

    function mouse_not_move(~,~)
    end

file_menu=uimenu('Text','File');
uimenu(file_menu,'Text','Send data to work space','ForegroundColor','k','CallBack',@send_data_to_workspace_callback);
uimenu(file_menu,'Text','Show data','ForegroundColor','k','CallBack',@show_data);
uimenu(file_menu,'Text','Save data as ASCII','ForegroundColor','k','CallBack',@save_ASCII);
uimenu(file_menu,'Text','Save data as h5','ForegroundColor','k','CallBack',@save_h5);
uimenu(file_menu,'Text','Show info data','ForegroundColor','k','CallBack',@show_info_callback);


data_analysis=uimenu('Text','Data Analysis');
uimenu(data_analysis,'Text','transpose','ForegroundColor','k','CallBack',@transpose);
uimenu(data_analysis,'Text','crop by dragging','ForegroundColor','k','CallBack',@crop);
uimenu(data_analysis,'Text','crop by entering values','ForegroundColor','k','CallBack',@crop_enter_values)
uimenu(data_analysis,'Text','change x_y_data','ForegroundColor','b','CallBack',@change_x_y_data);
uimenu(data_analysis,'Text','swtich x-y data','ForegroundColor','b','CallBack',@switch_x_y_data);
uimenu(data_analysis,'Text','flip c-data left-right','ForegroundColor','b','CallBack',@flip_lr);
uimenu(data_analysis,'Text','flip c-data ud-down','ForegroundColor','b','CallBack',@flip_ud);
uimenu(data_analysis,'Text','interpolate data','ForegroundColor','m','CallBack',@interpolate_data);
uimenu(data_analysis,'Text','add by a number','ForegroundColor','r','CallBack',@add_by_number);
uimenu(data_analysis,'Text','subtract by a number','ForegroundColor','r','CallBack',@subtract_by_number);
uimenu(data_analysis,'Text','multiply by a number','ForegroundColor','r','CallBack',@multiply_by_number);
uimenu(data_analysis,'Text','divide by a number','ForegroundColor','r','CallBack',@divide_by_number);
uimenu(data_analysis,'Text','integrate along x','ForegroundColor','b','CallBack',@integrate_along_x);
uimenu(data_analysis,'Text','integrate along y','ForegroundColor','b','CallBack',@integrate_along_y);
uimenu(data_analysis,'Text','add spectrum','ForegroundColor','r','CallBack',@add);
uimenu(data_analysis,'Text','subtract two spectrum','ForegroundColor','r','CallBack',@subtract);
uimenu(data_analysis,'Text','multiply spectrum','ForegroundColor','r','CallBack',@multiply);
uimenu(data_analysis,'Text','divide two spectrum','ForegroundColor','r','CallBack',@divide);
uimenu(data_analysis,'Text','mean spectrum','ForegroundColor','r','CallBack',@mean);
uimenu(data_analysis,'Text','derivative spectrum along x-axis','ForegroundColor','r','CallBack',@derivative);
uimenu(data_analysis,'Text','log10','ForegroundColor','k','CallBack',@log);
uimenu(data_analysis,'Text','reflect c-data along x-axis','ForegroundColor','k','CallBack',@reflect);
uimenu(data_analysis,'Text','rotate c-data','ForegroundColor','k','CallBack',@rotate);
uimenu(data_analysis,'Text','shift x-data by some value','ForegroundColor','b','CallBack',@shift_x_data_by_value);
uimenu(data_analysis,'Text','shift x-data by values from external file','ForegroundColor','b','CallBack',@shift_x_data_by_file);
uimenu(data_analysis,'Text','slice c-data along y-axis','ForegroundColor','r','CallBack',@slice);
uimenu(data_analysis,'Text','tilt c-data along x-axis','ForegroundColor','b','CallBack',@tilt);
uimenu(data_analysis,'Text','remove background','ForegroundColor','b','CallBack',@remove_background);
uimenu(data_analysis,'Text','combine data to volume data','ForegroundColor','b','CallBack',@combine_to_volume);


normalization_menu=uimenu('Text','Normalization');
uimenu(normalization_menu,'Text','normalize c-data to zero and one','ForegroundColor','k','CallBack',@normalize);
uimenu(normalization_menu,'Text','xpd normalization','ForegroundColor','k','CallBack',@xpd_normalization);
uimenu(normalization_menu,'Text','normalize "to"','ForegroundColor','k','CallBack',@normalize_to);
uimenu(normalization_menu,'Text','normalize "and"','ForegroundColor','k','CallBack',@normalize_and);
uimenu(normalization_menu,'Text','normalize along x-axis to one','ForegroundColor','k','CallBack',@normalize_along);

momentum_conversion=uimenu('Text','Momentum Conversion');
uimenu(momentum_conversion,'Text','Eb-kx conversion','ForegroundColor','k','CallBack',@eb_kx);
uimenu(momentum_conversion,'Text','Eb-kz conversion','ForegroundColor','k','CallBack',@eb_kz);
uimenu(momentum_conversion,'Text','kx-ky conversion','ForegroundColor','k','CallBack',@kx_ky);
uimenu(momentum_conversion,'Text','kx-kz conversion','ForegroundColor','k','CallBack',@kx_kz);

plot_menu=uimenu('Text','Plot');
uimenu(plot_menu,'Text','plot c-data','ForegroundColor','k','CallBack',@plot);
uimenu(plot_menu,'Text','surf c-data','ForegroundColor','k','CallBack',@surf);

color_map_menu=uimenu('Text','Colormaps');
uimenu(color_map_menu,'Text','blue','ForegroundColor','k','CallBack',@blue_colormap);
uimenu(color_map_menu,'Text','hot','ForegroundColor','k','CallBack',@hot_colormap);
uimenu(color_map_menu,'Text','jet','ForegroundColor','k','CallBack',@jet_colormap);
uimenu(color_map_menu,'Text','hsv','ForegroundColor','k','CallBack',@hsv_colormap);

    function send_data_to_workspace_callback(~,~)
        send_data_to_workspace(data)
    end

    function show_data(~,~)
        spectrum_2d_show_data(data)
    end

    function save_ASCII(~,~)
        spectrum_2d_save_ASCII(data)
    end

    function save_h5(~,~)
        spectrum_2d_save_h5(data)
    end

    function show_info_callback(~,~)
        show_info(data{1})
    end

    function transpose(~,~)
        spectrum_2d_transpose(data)
    end

    function crop(~,~)
        spectrum_2d_crop(data)
    end

    function crop_enter_values(~,~)
        spectrum_2d_crop_enter_values(data)
    end

    function change_x_y_data(~,~)
        spectrum_2d_change_x_y_data(data)
    end

    function switch_x_y_data(~,~)
        spectrum_2d_switch_x_y_data(data)
    end

    function flip_lr(~,~)
        spectrum_2d_flip_lr(data)
    end

    function flip_ud(~,~)
        spectrum_2d_flip_ud(data)
    end

    function interpolate_data(~,~)
        spectrum_2d_interpolate_data(data)
    end

    function add_by_number(~,~)
        spectrum_2d_add_by_number(data)
    end

    function subtract_by_number(~,~)
        spectrum_2d_subtract_by_number(data)
    end

    function multiply_by_number(~,~)
        spectrum_2d_multiply_by_number(data)
    end

    function divide_by_number(~,~)
        spectrum_2d_divide_by_number(data)
    end

    function integrate_along_x(~,~)
        spectrum_2d_integrate_along_x(data)
    end

    function integrate_along_y(~,~)
        spectrum_2d_integrate_along_y(data)
    end

    function add(~,~)
        spectrum_2d_add_spectrum(data)
    end

    function subtract(~,~)
        spectrum_2d_subtract_spectrum(data)
    end

    function multiply(~,~)
        spectrum_2d_multiply_spectrum(data)
    end

    function divide(~,~)
        spectrum_2d_divide_spectrum(data)
    end

    function mean(~,~)
        spectrum_2d_mean_spectrum(data)
    end

    function derivative(~,~)
        spectrum_2d_derivative(data)
    end

    function log(~,~)
        spectrum_2d_log(data)
    end

    function reflect(~,~)
        spectrum_2d_reflect(data)
    end

    function rotate(~,~)
        spectrum_2d_rotate(data)
    end

    function normalize(~,~)
        spectrum_2d_normalize(data)
    end

    function shift_x_data_by_value(~,~)
        spectrum_2d_shift_x_data_by_value(data)
    end

    function shift_x_data_by_file(~,~)
        spectrum_2d_shift_x_data_by_file(data)
    end

    function slice(~,~)
        spectrum_2d_slice(data)
    end

    function tilt(~,~)
        spectrum_2d_tilt(data)
    end

    function remove_background(~,~)
        spectrum_2d_remove_background(data)
    end

    function combine_to_volume(~,~)
        spectrum_2d_combine_to_volume(data)
    end

    function xpd_normalization(~,~)
        spectrum_2d_xpd_normalization(data)
    end

    function normalize_to(~,~)
        spectrum_2d_normalize_to(data)
    end

    function normalize_and(~,~)
        spectrum_2d_normalize_and(data)
    end

    function normalize_along(~,~)
        spectrum_2d_normalize_along(data)
    end

    function surf(~,~)
        spectrum_2d_surf(data)
    end

    function plot(~,~)
        spectrum_2d_plot_c_data(data)
    end

    function eb_kx(~,~)
        spectrum_2d_eb_kx(data)
    end

    function eb_kz(~,~)
        spectrum_2d_eb_kz(data)
    end

    function kx_ky(~,~)
        spectrum_2d_kx_ky(data)
    end

    function kx_kz(~,~)
        spectrum_2d_kx_kz(data)
    end

    function blue_colormap(~,~)
        blue_colormap_inside()
    end

    function hot_colormap(~,~)
        colormap('hot')
    end

    function hsv_colormap(~,~)
        colormap('hsv')
    end

    function jet_colormap(~,~)
        colormap('jet')
    end
end