function spectrum_2d_plot_c_data(data)
figure()
set(gcf,'name','Plot','NumberTitle','off','color','w','units','normalized','position',[0.4 0.3 0.4 0.6])

if length(data)>1    
    slider_step=[1/(length(data)-1),1];
    slider = uicontrol('style','slider','units','normalized','position',[0,0,0.8,0.05],'value',1,'min',1,'max',length(data),'sliderstep',slider_step,'Callback',{@sld_callback});
    play_button = uicontrol('style','pushbutton','units','normalized','position',[0.8,0,0.1,0.05],'string','play','Callback',{@play_callback});
    pause_button = uicontrol('style','pushbutton','units','normalized','position',[0.8,-0.1,0.1,0.05],'string','pause','Callback',{@pause_callback});
    uicontrol('style','pushbutton','units','normalized','position',[0.9,0,0.1,0.05],'string','save video','Callback',{@save_video_callback});
end
slider_value=1;
data_plot(data{slider_value})

    function sld_callback(hobj,~,~)
        slider_value = round(get(hobj,'Value'));
        ax = gca; cla(ax);
        data_plot(data{slider_value})  
    end

    function data_plot(data) 
        ax = gca; cla(ax);
        imagesc('xdata',data.x_data,'ydata',data.y_data,'cdata',data.c_data)
        xlim([min(data.x_data) max(data.x_data)])
        ylim([min(data.y_data) max(data.y_data)])
        set(gca,'TickDir','out','TickLength',[0.02 0.02],'FontName','TimesNewRoman','FontSize',12,'TickLabelInterpreter','latex')
        title({'',regexprep(data.name,'_',' '),''},'interpreter','latex','fontsize',14)
        box on
        colormap('hot')
    end

    function play_callback(~,~,~)
        global pause_call
        pause_call = 0;
        slider_value = round(slider.Value);       
        play_button.Position = [0.8,-0.1,0.1,0.05];
        pause_button.Position = [0.8,0,0.1,0.05];
        for k = slider_value:length(data)
            if pause_call == 0
                slider.Value = k;
                slider_value = round(slider.Value);
                data_plot(data{slider_value})
                drawnow
            end
        end
        if slider.Value == length(data)
            play_button.Position = [0.8,0,0.1,0.05];
            pause_button.Position = [0.8,-0.1,0.1,0.05];
        end        
    end

    function pause_callback(~,~,~)
        global pause_call
        pause_call = 1;
        slider_value = round(slider.Value);        
        data_plot(data{slider_value})
        play_button.Position = [0.8,0,0.1,0.05];
        pause_button.Position = [0.8,-0.1,0.1,0.05];
    end

    function save_video_callback(~,~,~)
        [file,path] = uiputfile('*.avi');
        if file~=0
            v = VideoWriter([path,file]);
            v.Quality = 100;
            v.FrameRate = 10;
            open(v);
            slider_value = 1;
            for k = 1:length(data)
                slider.Value = k;
                slider_value = round(slider.Value);
                data_plot(data{slider_value})
                drawnow
                frame = getframe(gcf);
                writeVideo(v,frame);
            end
            close (v)
        end
    end
end