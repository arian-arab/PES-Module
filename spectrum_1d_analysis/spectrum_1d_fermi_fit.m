function spectrum_1d_fermi_fit(data)
kB=0.086173324;

for k=1:length(data)
    if size(data{k}.x_data,1)>1
        data{k}.x_data = data{k}.x_data';
    end
    if size(data{k}.y_data,1)>1
        data{k}.y_data = data{k}.y_data';
    end    
    y=data{k}.y_data;
    x=data{k}.x_data;
    if x(2)<x(1)
        x = fliplr(x);
        y = fliplr(y);
    end    
    y=y-y(end);
    y=y/y(1);
    names{k} = data{k}.name;     
    modelfun= @(b,x)(1./(exp((x-b(1))./(kB*b(2)))+1));
    beta0 = [(x(1)+x(end))/2,1];%,y(1),y(end)];
    beta = nlinfit(x,y,modelfun,beta0);
    FIT=(1./((exp((x-beta(1))./(kB*beta(2)))+1)));        
    fermi_values{k}=sprintf('%2.4f',round(beta(1),4));
    data{k}.y_data = FIT;
    data{k}.name = [data{k}.name,'_fermi_fit'];    
    data_to_fit{k}.x_data = x;
    data_to_fit{k}.y_data = y;
    data_to_fit{k}.name = data{k}.name;
    data_to_fit{k}.type = 'spectrum_1d';
    data_to_fit{k}.info = 'NaN';
    clear x y beta0 beta FIT 
end
plot_fermi_fit(data,data_to_fit,fermi_values);
data_to_send = [data,data_to_fit];
spectrum_1d_plot(data_to_send)
figure('name','Fermi Values','NumberTitle','off','Resize','off','units','normalized','Position',[0 0.1 1 0.4],'ToolBar','none','MenuBar', 'none')
column_width{1} = 200;
column_names = {'Chemical Potential'};
uitable('Data',fermi_values','units','normalized','Position',[0 0 1 1],'FontSize',12,'ColumnName',column_names,'RowName',names,'ColumnWidth',column_width);
end

function plot_fermi_fit(data,data_to_fit,fermi_values)
figure()
set(gcf,'name','Fermi Fit','NumberTitle','off','color','w','units','normalized','position',[0.4 0.3 0.4 0.6],'Menubar','none')

if length(data)>1    
    slider_step=[1/(length(data)-1),1];
    uicontrol('style','slider','units','normalized','position',[0,0,1,0.05],'value',1,'min',1,'max',length(data),'sliderstep',slider_step,'Callback',{@sld_callback});
end
slider_value=1;
fitted_data_plot(data{slider_value},data_to_fit{slider_value},fermi_values{slider_value})

    function sld_callback(hobj,~,~)
        slider_value = round(get(hobj,'Value'));
        ax = gca; cla(ax);
        fitted_data_plot(data{slider_value},data_to_fit{slider_value},fermi_values{slider_value})
    end

    function fitted_data_plot(data_original,data_fitted,fitted_parameters) 
        hold on
        fitted_parameters = str2double(fitted_parameters);
        plot(data_original.x_data,data_original.y_data,'k')
        plot(data_fitted.x_data,data_fitted.y_data,'b')
        text(fitted_parameters,0.5,strcat('\mu=',num2str(fitted_parameters)),'Rotation',90,'FontSize',14);
        line([fitted_parameters fitted_parameters],[0 0.5],'Color','b','LineStyle','--')        
        title({'',regexprep(data_original.name,'_',' '),''},'interpreter','latex','fontsize',14)
        x = data_original.x_data;        
        xlim([min(x) max(x)])
        set(gca,'TickDir','out','TickLength',[0.02 0.02],'FontName','TimesNewRoman','FontSize',12,'TickLabelInterpreter','latex')
        set(gcf,'color','w')
        box on        
    end

end