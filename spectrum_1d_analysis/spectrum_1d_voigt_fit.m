function spectrum_1d_voigt_fit(data)
input_values = inputdlg({'number of peaks:'},'',1,{'1'});
if isempty(input_values)==1
    return
else
    uiwait(msgbox('now click on the peak positions','modal'));
    no_of_peaks=str2double(input_values{1});
    set(gcf,'WindowButtonDownFCN',@peakfind)
    
    waitforbuttonpress
    mouse_location = get(gca,'CurrentPoint');
    par_initial(1,:)=[mouse_location(1);mouse_location(3);1;1];
    for i=2:no_of_peaks
        waitforbuttonpress
        par_initial(i,:)=[mouse_location(1);mouse_location(3);1;1];
    end
    
    answer = questdlg('Would you like to fix the Gaussian FWHM?','FWHM ','Yes','No','No');
    switch answer
        case 'Yes'
            gauss_fwhm=inputdlg({'Gaussian FWHM Min:','Gaussian FWHM Max:'},'',1,{'0.5','0.6'});
            width_gauss_min=str2double(gauss_fwhm{1,1})/2;
            width_gauss_max=str2double(gauss_fwhm{2,1})/2;
            if width_gauss_max==width_gauss_min
                uiwait(msgbox('Min and Max can not be the same','modal'))
                Gb=[0.0001 100];
            else
                Gb=[width_gauss_min width_gauss_max];     % Gaussian width range [lower upper]
            end
        case 'No'
            Gb=[0.0001 100];     % Gaussian width range [lower upper]
    end
    
    answer = questdlg('Would you like to fix the Lorentzian FWHM?','FWHM ','Yes','No','No');
    switch answer
        case 'Yes'
            lorentz_fwhm=inputdlg({'Lorentzian FWHM Min:','Lorentzian FWHM Max:'},'',1,{'0.5','0.6'});
            width_lorentz_min=str2double(lorentz_fwhm{1,1})/2;
            width_lorentz_max=str2double(lorentz_fwhm{2,1})/2;
            if width_lorentz_min==width_lorentz_max
                uiwait(msgbox('Min and Max can not be the same','modal'))
                Lb=[0.001 10];
            else
                Lb=[width_lorentz_min width_lorentz_max];     % Gaussian width range [lower upper]
            end
        case 'No'
            Lb=[0.001 10];  % Lorentzian width range [lower upper]
    end
    
    f = waitbar(0,'fitting started');
    for k=1:length(data)
        waitbar(k/length(data),f,'fitting started');        
        [data_fitted{k},fitted_parameters{k},under{k},residual{k}] = fit_voigt_spectra(data{k},Lb,Gb,par_initial,no_of_peaks);
    end
    close(f)
    plot_fitted_peak(data,data_fitted,fitted_parameters,under,residual)
    
    fitted_parameters = vertcat(fitted_parameters{:});
    figure('Resize','off','units','normalized','Position',[0 0.1 1 0.4],'ToolBar','none','MenuBar', 'none')
    column_width{1} = 400;
    for i = 2:14
        column_width{i} = 110;
    end    
    uitable('Data',fitted_parameters,'FontSize',13,'ColumnName',{'peak_no','x_c','x_c error','y_c','y_c error','fwhm_gauss','gauss error','fwhm_lorentz','lorentz error','fwhm_voigt','voigt error','sum(abs(residuals))','area','area error'},'units','normalized','Position',[0 0 1 1],'ColumnWidth',column_width,'RowStriping','on');
    
    
    
end
    function peakfind (~,~)
        mouse_location = get(gca,'CurrentPoint');
    end
end

function plot_fitted_peak(data_original,data_fitted,fitted_parameters,under,residual)
figure()
set(gcf,'name','Voigt Fit Plot','NumberTitle','off','color','w','units','normalized','position',[0.4 0.3 0.4 0.6],'Menubar','none')

uicontrol('style','pushbutton','units','normalized','position',[0.8,0,0.2,0.05],'string','send fitted data to work space','Callback',{@send_data});

if length(data_original)>1    
    slider_step=[1/(length(data_original)-1),1];
    uicontrol('style','slider','units','normalized','position',[0,0,0.8,0.05],'value',1,'min',1,'max',length(data_original),'sliderstep',slider_step,'Callback',{@sld_callback});
end
slider_value=1;
fitted_data_plot(data_original{slider_value},data_fitted{slider_value},fitted_parameters{slider_value},under{slider_value},residual{slider_value})

    function sld_callback(hobj,~,~)
        slider_value = round(get(hobj,'Value'));
        ax = gca; cla(ax);
        fitted_data_plot(data_original{slider_value},data_fitted{slider_value},fitted_parameters{slider_value},under{slider_value},residual{slider_value})
    end

    function send_data(~,~,~)
        send_fitted_data_to_workspace(data_original,data_fitted,under)        
    end

    function fitted_data_plot(data_original,data_fitted,fitted_parameters,under,residual) 
        hold on
        for i=1:size(fitted_parameters,1)            
            x_c = str2double(fitted_parameters{i,2});
            y_c = str2double(fitted_parameters{i,4});
            fwhm_voigt = str2double(fitted_parameters{i,10});
            plot([x_c x_c],[min(under(:,i)) y_c],'--','Color',[0.5 0.5 0.5]) % plot peak line
            plot([x_c-fwhm_voigt/2 x_c+fwhm_voigt/2],[y_c/2 y_c/2],'--','Color',[0.5 0.5 0.5]) % plot fwhm line
            area(data_fitted(:,1),under(:,i),'FaceColor',[0.5 0.5 0.5],'EdgeColor','none','FaceAlpha',0.5)   % plot fit profiles
            text(x_c,y_c/2,num2str(i),'interpreter','latex','FontName','TimesNewRoman','FontSize',18);
            clear x_c y_c                        
        end
        plot(data_original.x_data,data_original.y_data,'bo','MarkerSize',4,'MarkerFaceColor','b')
        plot(data_original.x_data,residual,'ko','MarkerSize',4,'MarkerFaceColor','k') % plot residuals
        area(data_fitted(:,1),data_fitted(:,2),'FaceColor','r','EdgeColor','r','FaceAlpha',0.1);  % plot fitted profiles
        xlim([min(data_original.x_data) max(data_original.x_data)])
        set(gca,'TickDir','out','TickLength',[0.02 0.02],'FontName','TimesNewRoman','FontSize',12,'TickLabelInterpreter','latex')
        title({'',regexprep(data_original.name,'_',' '),''},'interpreter','latex','fontsize',14)
        box on
    end
end

function [data_fitted,fitted_parameters,under,residual] = fit_voigt_spectra(data,Lb,Gb,par_initial,no_of_peaks)
data_to_fit(:,1) = data.x_data;
data_to_fit(:,2) = data.y_data;

[parmin,residual,jacobian]= fit2voigt(data_to_fit,par_initial',Gb,Lb);
standard_error = nlparci(parmin,residual,'jacobian',jacobian);

x_fit = linspace(data_to_fit(1,1),data_to_fit(end,1),2000)';
[y_fit,under]=voigt(x_fit,parmin);
residuals=sum(abs(residual));

for m = 1:no_of_peaks    
    x_c_min = standard_error(4*m-3,1);
    x_c_max = standard_error(4*m-3,2);
    y_c_min = standard_error(4*m-2,1);
    y_c_max = standard_error(4*m-2,2);
    fwhm_gauss = 2*parmin(3,m);
    fwhm_lorentz=2*parmin(4,m);
    fwhm_gauss_min = 2*standard_error(4*m-1,1);
    fwhm_gauss_max = 2*standard_error(4*m-1,2);
    fwhm_lorentz_min = 2*standard_error(4*m,1);
    fwhm_lorentz_max = 2*standard_error(4*m,2);  
    fwhm_voigt_min = 0.5346*fwhm_lorentz_min+sqrt(0.2166*fwhm_lorentz_min*fwhm_lorentz_min+fwhm_gauss_min*fwhm_gauss_min);
    fwhm_voigt_max = 0.5346*fwhm_lorentz_max+sqrt(0.2166*fwhm_lorentz_max*fwhm_lorentz_max+fwhm_gauss_max*fwhm_gauss_max);    
    [y_standard_error_min,~] = voigt(x_fit,standard_error(4*m-3:4*m,1));
    area_min = trapz(x_fit,y_standard_error_min);    
    [y_standard_error_max,~] = voigt(x_fit,standard_error(4*m-3:4*m,2));
    area_max = trapz(x_fit,y_standard_error_max);    
    x_c_error = abs(x_c_max-x_c_min);
    y_c_error = abs(y_c_max-y_c_min);
    fwhm_gauss_error = abs(fwhm_gauss_min-fwhm_gauss_max); 
    fwhm_lorentz_error = abs(fwhm_lorentz_min-fwhm_gauss_max); 
    fwhm_voigt_error = abs(fwhm_voigt_min-fwhm_voigt_max);
    area_error = abs(area_min-area_max);
    area = trapz(x_fit,under(:,m));
    [y_c,I_yc]=max(under(:,m));
    x_c=x_fit(I_yc);
    [~,I_half]=min(abs(under(:,m)-y_c/2));
    x_c_half=x_fit(I_half);
    fwhm_voigt=abs(x_c-x_c_half)*2;
    fitted_parameters{m,1}=strcat(data.name,'_',num2str(m));  
    fitted_parameters{m,2}=sprintf('%2.4f',round(x_c,4));
    fitted_parameters{m,3}=sprintf('%2.4f',round(x_c_error,4));    
    fitted_parameters{m,4}=sprintf('%2.4f',round(y_c,4));
    fitted_parameters{m,5}=sprintf('%2.4f',round(y_c_error,4));    
    fitted_parameters{m,6}=sprintf('%2.4f',round(fwhm_gauss,4));
    fitted_parameters{m,7}=sprintf('%2.4f',round(fwhm_gauss_error,4));    
    fitted_parameters{m,8}=sprintf('%2.4f',round(fwhm_lorentz,4));
    fitted_parameters{m,9}=sprintf('%2.4f',round(fwhm_lorentz_error,4));    
    fitted_parameters{m,10}=sprintf('%2.4f',round(fwhm_voigt,4));
    fitted_parameters{m,11}=sprintf('%2.4f',round(fwhm_voigt_error,4));
    fitted_parameters{m,12}=sprintf('%2.4f',round(residuals,4));
    fitted_parameters{m,13}=sprintf('%2.4f',round(area,4));
    fitted_parameters{m,14}=sprintf('%2.4f',round(area_error,4));     
end
data_fitted(:,1) = x_fit;
data_fitted(:,2) = y_fit;
end

function send_fitted_data_to_workspace(data_original,data_fitted,under)
global data listbox
for i=1:length(data_fitted)
    data_fit{i}.x_data = data_fitted{i}(:,1);
    data_fit{i}.y_data = data_fitted{i}(:,2);
    data_fit{i}.name = [data_original{i}.name,'_fitted_data'];
    data_fit{i}.type = 'spectrum_1d';    
    data_fit{i}.info = 'NaN';    
end

for i=1:length(data_fitted)    
    for j=1:size(under{i},2)
    under_data{j}.x_data = data_fitted{i}(:,1);
    under_data{j}.y_data = under{i}(:,j);
    under_data{j}.name = [data_original{i}.name,'_peak_',num2str(j)];
    under_data{j}.type = 'spectrum_1d';    
    under_data{j}.info = 'NaN';       
    end
    under_wanted{i} = under_data;
    clear under_data
end
under_wanted = horzcat(under_wanted{:});
data_to_send = [data_fit,under_wanted];
if isempty(data)==1
    if isempty(data_to_send)==1
        data=[];
    else
        data=data_to_send;
    end
else
    if isempty(data_to_send)==1
        return
    else
        data= horzcat(data,data_to_send);
    end
end
if isempty(data)==1
    listbox.String = 'NaN';
else
    for i=1:length(data)
        names{i} = data{i}.name;
    end
    listbox.String = names;
end
end