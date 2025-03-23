function spectrum_2d_kx_ky(data)
InputValues = inputdlg({'Photon Energy(eV):','Work Function(eV)','Incidence Angle(degrees)'},'',1,{'600','5','20'});
if isempty(InputValues)==1
    return
else
    hv=str2double(InputValues{1});
    w=str2double(InputValues{2});
    inc=str2double(InputValues{3});
    e_p=0.5124.*sqrt(hv-w);
    hv_p=0.506*(hv/1000);
    f = waitbar(0,'momentum convertion');
    for k=1:length(data)        
        [x,y] = meshgrid(data{k}.x_data,data{k}.y_data);
        k_x{k} = e_p*sind(x)+hv_p*cosd(inc);
        k_y{k} = e_p*cosd(x).*sind(y);
        clear x y
        waitbar(k/length(data),f,'momentum convertion')
    end
    close(f)
    plot_arpes(data,k_x,k_y)   
end
end
    
function plot_arpes(data,kx,ky)
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
data_plot(data{slider_value},kx{slider_value},ky{slider_value}) 




    function sld_callback(hobj,~,~)
        slider_value = round(get(hobj,'Value'));
        ax = gca; cla(ax);
        data_plot(data{slider_value},kx{slider_value},ky{slider_value})  
    end

    function data_plot(data,kx,ky) 
        ax = gca; cla(ax);
        surf(kx,ky,kx-kx,data.c_data,'linestyle','none')
        xlim([min(kx(:)) max(kx(:))])
        ylim([min(ky(:)) max(ky(:))])
        set(gca,'TickDir','out','TickLength',[0.02 0.02],'FontName','TimesNewRoman','FontSize',12,'TickLabelInterpreter','latex','units','normalized','position',[0.17 0.2 0.7 0.7])
        title({'',regexprep(data.name,'_',' '),''},'interpreter','latex','fontsize',14)
        xlabel('$k_{x} (\AA^{-1}) $','interpreter','latex','fontsize',18)
        ylabel('$k_{y} (\AA^{-1})$','interpreter','latex','fontsize',18)
        view(0,90)
        box on
        axis equal
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
                data_plot(data{slider_value},kx{slider_value},ky{slider_value})  
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
        data_plot(data{slider_value},kx{slider_value},ky{slider_value})  
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
                data_plot(data{slider_value},kx{slider_value},ky{slider_value}) 
                drawnow
                frame = getframe(gcf);
                writeVideo(v,frame);
            end
            close (v)
        end
    end
end