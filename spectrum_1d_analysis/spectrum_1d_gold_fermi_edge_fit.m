function spectrum_1d_gold_fermi_edge_fit(data)
input_values = inputdlg({'Gaussian FWHM min (eV):','Gaussian FWHM max (eV):','Temperature Min (K)','Temperature Max (K)'},'',1,{'0.1','2','293','293'});
if isempty(input_values)==1
    return
else
    column_names = {'Gaussian FWHM (eV)','Temperature (K)','Chemical Potential'};
    f = waitbar(0,'fitting');
    for k=1:length(data)
        if size(data{k}.x_data,1)>1
            data{k}.x_data = data{k}.x_data';
        end
        if size(data{k}.y_data,1)>1
            data{k}.y_data = data{k}.y_data';
        end
        y=data{k}.y_data;
        x=data{k}.x_data;
        y=y-y(end);
        y=y/y(1);
        names{k} = data{k}.name;
        fwhm_down=str2double(input_values{1,1});
        fwhm_up=str2double(input_values{2,1});
        T_down=str2double(input_values{3,1});
        T_up=str2double(input_values{4,1});
        fgfit=@(b) fd_gaussian_convolution(b(1),b(2),b(3),x)-y;
        mu_up=max(x);
        mu_down=min(x);
        lb=[fwhm_down,T_down,mu_down];
        ub=[fwhm_up,T_up,mu_up];
        beta0=[(fwhm_down+fwhm_up)/2,(T_down+T_up)/2,(mu_down+mu_up)/2];
        options=statset('TolFun',1e-11,'Display','iter');
        beta=lsqnonlin(fgfit,beta0,lb,ub,options);        
        yf=fgfit(beta)+y;        
        fitted_parameters(k,1)=beta(1);
        fitted_parameters(k,2)=beta(2);
        fitted_parameters(k,3)=beta(3);      
        data_fit{k}.x_data = x;
        data_fit{k}.y_data = yf;
        data_fit{k}.name = ['fermi_edge_',data{k}.name];
        data_fit{k}.type = 'spectrum_1d';
        data_fit{k}.info = 'NaN';        
        data_to_fit{k}.x_data = x;
        data_to_fit{k}.y_data = y;
        data_to_fit{k}.name = data{k}.name;
        data_to_fit{k}.type = 'spectrum_1d';
        data_to_fit{k}.info = 'NaN';
        clear fwhm_down fwhm_up T_down T_up mu_up mu_down lb ub beta0 beta yf x y 
        waitbar(k/length(data),f,'fitting')
    end
    close(f)
end
data_to_send = [data_fit,data_to_fit];
spectrum_1d_plot(data_to_send)
plot_fermi_fit(data_fit,data_to_fit,fitted_parameters);
figure('name','Gold Fermi Edge Fit','NumberTitle','off','Resize','off','units','normalized','Position',[0 0.1 1 0.4],'ToolBar','none','MenuBar', 'none')
column_width{1} = 200;
uitable('Data',fitted_parameters,'units','normalized','Position',[0 0 1 1],'FontSize',12,'ColumnName',column_names,'RowName',names,'ColumnWidth',column_width);
end

function [y_conv_data]=fd_gaussian_convolution(fwhm,temperature,chemical_potential,x_data)
kB=8.6173303*10^(-5);
x = -10:0.05:10;
x = x+mean(x_data);
y_conv=zeros(length(x),1);
y_fermi=1./(exp((x-chemical_potential)/(kB*temperature))+1); 
a = (2*sqrt(log(2)))/(pi*fwhm);
b = -4*log(2)/(fwhm^2);
for i=1:length(x)
    x0 = x(i);
    gaussian_profile =  a*exp(b*((x-x0).^2));
    y_conv(i) = trapz(x,gaussian_profile.*y_fermi); 
end
y_conv = y_conv/max(y_conv);
y_conv_data = interp1(x,y_conv,x_data);
end

function plot_fermi_fit(data,data_to_fit,fermi_values)
figure()
set(gcf,'name','Fermi Fit','NumberTitle','off','color','w','units','normalized','position',[0.4 0.3 0.4 0.6],'Menubar','none')

if length(data)>1    
    slider_step=[1/(length(data)-1),1];
    uicontrol('style','slider','units','normalized','position',[0,0,1,0.05],'value',1,'min',1,'max',length(data),'sliderstep',slider_step,'Callback',{@sld_callback});
end
slider_value=1;
fitted_data_plot(data{slider_value},data_to_fit{slider_value},fermi_values(slider_value,:))

    function sld_callback(hobj,~,~)
        slider_value = round(get(hobj,'Value'));
        ax = gca; cla(ax);
        fitted_data_plot(data{slider_value},data_to_fit{slider_value},fermi_values(slider_value,:))
    end

    function fitted_data_plot(data_original,data_fitted,fitted_parameters)
        hold on
        plot(data_original.x_data,data_original.y_data,'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','b','linewidth',2)
        plot(data_fitted.x_data,data_fitted.y_data,'k','linewidth',1)
        text(fitted_parameters(3),0.5,{['FWHM=',num2str(fitted_parameters(1))],['T=',num2str(fitted_parameters(2))],['$\mu=$',num2str(fitted_parameters(3))]},'interpreter','latex','fontsize',14,'HorizontalAlignment', 'left');
        line([fitted_parameters(3) fitted_parameters(3)],[0 0.5],'color','k')
        title({'',regexprep(data_original.name,'_',' '),''},'interpreter','latex','fontsize',14)
        set(gca,'TickDir','out','TickLength',[0.02 0.02],'FontName','TimesNewRoman','FontSize',12,'TickLabelInterpreter','latex')
        set(gcf,'color','w')
        box on
        x = data_original.x_data;  
        xlim([min(x) max(x)])
    end
end