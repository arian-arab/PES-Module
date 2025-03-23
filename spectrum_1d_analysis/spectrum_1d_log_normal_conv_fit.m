function spectrum_1d_log_normal_conv_fit(data)
input_values = inputdlg({'mu:','sigma:','number of convolutions:'},'',1,{'2.5','0.5','5'});
if isempty(input_values)==1
    return
else
    mu = str2double(input_values{1});
    sigma = str2double(input_values{2});
    N = str2double(input_values{3});    
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
        names{k} = data{k}.name;            
        [FIT,xq,yq,beta] = log_normal_conv_fit(x,y,mu,sigma,N);        
        mu_sigma{k,1}=sprintf('%2.4f',round(beta(1),4));
        mu_sigma{k,2}=sprintf('%2.4f',round(beta(2),4));
        data{k}.y_data = FIT;
        data{k}.x_data = xq;
        data{k}.name = [data{k}.name,'_log_normal_fit'];
        data_to_fit{k}.x_data = xq;
        data_to_fit{k}.y_data = yq;
        data_to_fit{k}.name = data{k}.name;
        data_to_fit{k}.type = 'spectrum_1d';
        data_to_fit{k}.info = 'NaN';
        clear x y beta0 beta FIT xq yq 
    end
    plot_log_normal_fit(data,data_to_fit,mu_sigma);
    data_to_send = [data,data_to_fit];
    spectrum_1d_plot(data_to_send)
    figure('name','Log Normal Fit Values','NumberTitle','off','Resize','off','units','normalized','Position',[0 0.1 1 0.4],'ToolBar','none','MenuBar', 'none')
    column_width{1} = 200;
    column_names = {'sigma','mu'};
    uitable('Data',mu_sigma,'units','normalized','Position',[0 0 1 1],'FontSize',12,'ColumnName',column_names,'RowName',names,'ColumnWidth',column_width);
end
end

function plot_log_normal_fit(data,data_to_fit,fermi_values)
figure()
set(gcf,'name','Log Normal Fit','NumberTitle','off','color','w','units','normalized','position',[0.4 0.3 0.4 0.6],'Menubar','none')

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
        title({'',regexprep(data_original.name,'_',' '),''},'interpreter','latex','fontsize',14)
        x = data_original.x_data;
        xlim([min(x) max(x)])
        set(gca,'TickDir','out','TickLength',[0.02 0.02],'FontName','TimesNewRoman','FontSize',12,'TickLabelInterpreter','latex')
        set(gcf,'color','w')
        box on
    end

end

function [FIT,xq,yq,beta] = log_normal_conv_fit(x,y,mu,sigma,N)
xq = linspace(min(x),max(x),1000);
yq = interp1(x,y,xq);
area = trapz(xq,yq);
yq = yq/area;
f1 = log_normal_distribution(sigma,mu,xq);
pdf_conv(1,:) = f1;
for i = 2:N
    temp = conv(pdf_conv(i-1,:),f1);
    temp = temp(1:length(f1));
    area = trapz(xq,temp);
    temp = temp/area;
    pdf_conv(i,:) = temp;
end
fgfit=@(b) sum(abs(b*pdf_conv-yq));

lb=zeros(1,size(pdf_conv,1));
ub=ones(1,size(pdf_conv,1));
beta0=ub/2;
A = ub;
Aeq = ub;
b = 1;
beq = 1;
beta = fmincon(fgfit,beta0,A,b,Aeq,beq,lb,ub);
conv_fun = @(b) b*pdf_conv;
FIT = conv_fun(beta);
end

function pdf = log_normal_distribution(sigma,mu,x)
pdf = ((1./x).*(1/(sqrt(2*pi)*sigma)).*exp(-((log(x)-mu).^2)/(2*sigma*sigma)));
area = trapz(x,pdf);
pdf = pdf/area;
end