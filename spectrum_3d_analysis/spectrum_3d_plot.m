function spectrum_3d_plot(data)
figure();
set(gcf,'name','ARPES 3D','NumberTitle','off','color','w','units','normalized','position',[0.4 0.3 0.4 0.6],'menubar','none')
set(1,'defaultfiguretoolbar','figure');

slider_step=[1/(size(data.v_data,3)-1),0.25];
slider = uicontrol('style','slider','units','normalized','position',[0,0,0.8,0.05],'value',1,'min',1,'max',size(data.v_data,3),'sliderstep',slider_step,'Callback',{@sld_callback});

slider_value = 1;
integration = 1;
play_button = uicontrol('style','pushbutton','units','normalized','position',[0.8,0,0.1,0.05],'string','play','Callback',{@play_callback});
pause_button = uicontrol('style','pushbutton','units','normalized','position',[0.8,-0.1,0.1,0.05],'string','pause','Callback',{@pause_callback});
z_data = data.z_data;
z_edit = uicontrol('style','edit','units','normalized','position',[0.9,0,0.1,0.05],'string',num2str(round(z_data(slider_value),3)),'Callback',{@z_edit_callback});

spectrum_3d_mouse_up(data,slider_value,integration)

   function sld_callback(~,~,~)
        slider_value = round(slider.Value);
        z_edit.String = num2str(round(z_data(slider_value),3));
        spectrum_3d_mouse_up(data,slider_value,integration)
    end

    function z_edit_callback(~,~,~)
        [~,I] = min(abs(z_data-str2double(z_edit.String)));
        slider_value = I;
        slider.Value = I;
        z_edit.String = num2str(round(z_data(slider_value),3));
        spectrum_3d_mouse_up(data,slider_value,integration)
    end 

    function play_callback(~,~,~)
        global pause_call
        pause_call = 0;
        slider_value = round(slider.Value);
        play_button.Position = [0.8,-0.1,0.1,0.05];
        pause_button.Position = [0.8,0,0.1,0.05];
        for k = slider_value:size(data.v_data,3)
            if pause_call == 0
                slider.Value = k;
                slider_value = round(slider.Value);
                z_edit.String = num2str(round(z_data(slider_value),3));
                spectrum_3d_mouse_up(data,slider_value,integration)
                drawnow
            end
        end
        if slider_value == size(data.v_data,3)
            play_button.Position = [0.8,0,0.1,0.05];
            pause_button.Position = [0.8,-0.1,0.1,0.05];
        end
    end

    function pause_callback(~,~,~)
        global pause_call
        pause_call = 1;
        slider_value = round(slider.Value);
        z_edit.String = num2str(round(z_data(slider_value),3));
        spectrum_3d_mouse_up(data,slider_value,integration)
        play_button.Position = [0.8,0,0.1,0.05];
        pause_button.Position = [0.8,-0.1,0.1,0.05];
    end

file_menu=uimenu('Text','File');
uimenu(file_menu,'Text','Send data to work space','ForegroundColor','k','CallBack',@send_data_to_workspace_callback);
uimenu(file_menu,'Text','Show info data','ForegroundColor','k','CallBack',@show_info_callback);
uimenu(file_menu,'Text','Save data as h5 file','ForegroundColor','k','CallBack',@save_data_as_h5);

volume_menu=uimenu('Text','Volume');
uimenu(volume_menu,'Text','permute volume (xyz)','ForegroundColor','k','CallBack',@permute_volume);
uimenu(volume_menu,'Text','integration window','ForegroundColor','k','CallBack',@integration_z);
uimenu(volume_menu,'Text','rectangle crop through third dimension','ForegroundColor','k','CallBack',@crop_z_rectangle);

uimenu('Text','Extract Current Image','ForegroundColor','k','CallBack',@send_image);

uimenu('Text','Analyze Data','ForegroundColor','k','CallBack',@analyze_data);

    function permute_volume(~,~)
        data = spectrum_3d_permute_volume(data);        
        slider_value = 1;
        slider.Value = slider_value;
        slider.Max = size(data.v_data,3);
        z_data = data.z_data;
        z_edit.String = num2str(round(z_data(slider_value),3));
        slider_step=[1/(size(data.v_data,3)-1),0.25];
        slider.SliderStep = slider_step;
        spectrum_3d_mouse_up(data,slider_value,integration)
    end

    function integration_z(~,~)
        InputValues = inputdlg({'integration window:'},'',1, {'5'});
        if isempty(InputValues)~=1
            N=str2double(InputValues{1});
            v_data = data.v_data;
            for k=1:size(v_data,3)
                if k+N>size(data.v_data,3)
                    v_data(:,:,k)=sum(v_data(:,:,k:end),3);
                else
                    v_data(:,:,k)=sum(v_data(:,:,k:k+N),3);
                end
            end
            data.v_data = v_data;
            integration = N;
            slider_value = 1;
            slider.Value = slider_value;
            slider.Max = size(data.v_data,3);
            z_data = data.z_data;
            z_edit.String = num2str(round(z_data(slider_value),3));
            slider_step=[1/(size(data.v_data,3)-1),0.25];
            slider.SliderStep = slider_step;
            spectrum_3d_mouse_up(data,slider_value,integration)
        end
    end

    function send_image(~,~,~)
        slider_value = round(slider.Value);
        v_data = data.v_data;
        c_data = v_data(:,:,slider_value);
        data_to_send{1}.c_data = c_data;
        data_to_send{1}.x_data = data.y_data';
        data_to_send{1}.y_data = data.x_data';
        data_to_send{1}.name = [data.name,'_',num2str(round(data.z_data(slider_value),3))];
        data_to_send{1}.type = 'spectrum_2d';
        data_to_send{1}.info = data.info;
        spectrum_2d_plot(data_to_send);
    end

    function crop_z_rectangle(~,~)
        spectrum_3d_crop_z_rectangle(data)
    end

    function analyze_data(~,~)
        spectrum_3d_analyze_data(data)
    end

    function send_data_to_workspace_callback(~,~)
        send_data_to_workspace(data)
    end

    function show_info_callback(~,~)
        show_info(data)
    end

    function save_data_as_h5(~,~)
        spectrum_3d_save_data_as_h5(data)
    end
end