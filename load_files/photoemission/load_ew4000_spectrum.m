function data_load = load_ew4000_spectrum()
[file_name,path] = uigetfile('*.txt','Select Scienta-EW-4000 file(s)','MultiSelect','on');
if isequal(file_name,0)
    data_load=[];
else
    file_name=cellstr(file_name);
    for i=1:size(file_name,2)
        try
            f=waitbar(0,'Please wait...');
            url=fullfile(path,file_name{i});
            
            opts=delimitedTextImportOptions("NumVariables",1);
            opts.DataLines=[1,Inf];
            opts.Delimiter=",";
            opts.VariableNames="Info";
            opts.VariableTypes="string";
            opts=setvaropts(opts,1,"WhitespaceRule","preserve");
            opts=setvaropts(opts,1,"EmptyFieldRule","auto");
            opts.ExtraColumnsRule="ignore";
            opts.EmptyLineRule="read";
            
            waitbar(0.1,f,'Please wait...');
            
            whole_data=readtable(url,opts);
            whole_data=table2array(whole_data);
            clear opts
            
            waitbar(0.2,f,'Please wait...');
            
            c_data_start=find(whole_data=='[Data 1]');
            info_data=whole_data(1:c_data_start);            
            
            for k=1:length(info_data)
                ans=contains(info_data(k),'Lens Mode');
                if ans==1
                    lens_mode=whole_data(k);
                    break
                end
            end
            
            waitbar(0.3,f,'Please wait...');
            
            if lens_mode=='Lens Mode=Angular60'
                for n=1:length(info_data)
                    test=strfind(info_data(n),'Dimension 1 scale');
                    if test==1
                        break
                    end
                end
                y_data=char(whole_data(n));
                y_data=y_data(19:end);
                y_data=strsplit(y_data,' ');
                y_data=str2double(y_data);
                
                waitbar(0.4,f,'Please wait...');
                
                for n=1:length(info_data)
                    test=strfind(info_data(n),'Dimension 2 scale');
                    if test==1
                        break
                    end
                end
                
                waitbar(0.5,f,'Please wait...');
                
                x_data=char(whole_data(n));
                x_data=x_data(19:end);
                x_data=strsplit(x_data,' ');
                x_data=str2double(x_data);
                
                waitbar(0.6,f,'Please wait...');
                
                c_data=whole_data(c_data_start+1:end);
                c_data=cellstr(c_data);
                c_data=cellfun(@(x) strsplit(x,' '),c_data,'UniformOutput',false);
                c_data=cellfun(@(x) x(3:end),c_data,'UniformOutput',false);
                c_data=cellfun(@str2double,c_data,'UniformOutput',false);
                c_data=[c_data{:}];
                c_data=reshape(c_data,[length(x_data),length(y_data)]);
                
                waitbar(0.7,f,'Please wait...');
                x_data = x_data';
                y_data = y_data';
                if x_data(2)<x_data(1)
                    x_data = flipud(x_data);
                    c_data = flipud(c_data);
                end
                if y_data(2)<y_data(1)
                    y_data = flipud(y_data);
                    c_data = fliplr(c_data);
                end                
                info_data=cellstr(info_data);
                data_load{i}.x_data=x_data;
                data_load{i}.y_data=y_data;
                data_load{i}.c_data=c_data';
                data_load{i}.type='spectrum_2d';
                data_load{i}.info=info_data;
                data_load{i}.name=file_name{i}(1:end-4);
                clear c_data_wanted c_data_test
                
                waitbar(1,f,'Please wait...');
                
            elseif lens_mode=='Lens Mode=Angular56'
                for n=1:length(info_data)
                    test=strfind(info_data(n),'Dimension 1 scale');
                    if test==1
                        break
                    end
                end
                y_data=char(whole_data(n));
                y_data=y_data(19:end);
                y_data=strsplit(y_data,' ');
                y_data=str2double(y_data);
                
                waitbar(0.4,f,'Please wait...');
                
                for n=1:length(info_data)
                    test=strfind(info_data(n),'Dimension 2 scale');
                    if test==1
                        break
                    end
                end
                
                waitbar(0.5,f,'Please wait...');
                
                x_data=char(whole_data(n));
                x_data=x_data(19:end);
                x_data=strsplit(x_data,' ');
                x_data=str2double(x_data);
                
                waitbar(0.6,f,'Please wait...');
                
                c_data=whole_data(c_data_start+1:end);
                c_data=cellstr(c_data);
                c_data=cellfun(@(x) strsplit(x,' '),c_data,'UniformOutput',false);
                c_data=cellfun(@(x) x(3:end),c_data,'UniformOutput',false);
                c_data=cellfun(@str2double,c_data,'UniformOutput',false);
                c_data=[c_data{:}];
                c_data=reshape(c_data,[length(x_data),length(y_data)]);
                
                waitbar(0.7,f,'Please wait...');
                x_data = x_data';
                y_data = y_data';
                if x_data(2)<x_data(1)
                    x_data = flipud(x_data);
                    c_data = flipud(c_data);
                end
                if y_data(2)<y_data(1)
                    y_data = flipud(y_data);
                    c_data = fliplr(c_data);
                end                
                info_data=cellstr(info_data);
                data_load{i}.x_data=x_data;
                data_load{i}.y_data=y_data;
                data_load{i}.c_data=c_data';
                data_load{i}.type='spectrum_2d';
                data_load{i}.info=info_data;
                data_load{i}.name=file_name{i}(1:end-4);
                clear c_data_wanted c_data_test
                
                waitbar(1,f,'Please wait...');
                
            elseif lens_mode=='Lens Mode=Angular45'
                for n=1:length(info_data)
                    test=strfind(info_data(n),'Dimension 1 scale');
                    if test==1
                        break
                    end
                end
                y_data=char(whole_data(n));
                y_data=y_data(19:end);
                y_data=strsplit(y_data,' ');
                y_data=str2double(y_data);
                
                waitbar(0.4,f,'Please wait...');
                
                for n=1:length(info_data)
                    test=strfind(info_data(n),'Dimension 2 scale');
                    if test==1
                        break
                    end
                end
                
                waitbar(0.5,f,'Please wait...');
                
                x_data=char(whole_data(n));
                x_data=x_data(19:end);
                x_data=strsplit(x_data,' ');
                x_data=str2double(x_data);
                
                waitbar(0.6,f,'Please wait...');
                
                c_data=whole_data(c_data_start+1:end);
                c_data=cellstr(c_data);
                c_data=cellfun(@(x) strsplit(x,' '),c_data,'UniformOutput',false);
                c_data=cellfun(@(x) x(3:end),c_data,'UniformOutput',false);
                c_data=cellfun(@str2double,c_data,'UniformOutput',false);
                c_data=[c_data{:}];
                c_data=reshape(c_data,[length(x_data),length(y_data)]);
                
                waitbar(0.7,f,'Please wait...');
                x_data = x_data';
                y_data = y_data';
                if x_data(2)<x_data(1)
                    x_data = flipud(x_data);
                    c_data = flipud(c_data);
                end
                if y_data(2)<y_data(1)
                    y_data = flipud(y_data);
                    c_data = fliplr(c_data);
                end                
                info_data=cellstr(info_data);
                data_load{i}.x_data=x_data;
                data_load{i}.y_data=y_data;
                data_load{i}.c_data=c_data';
                data_load{i}.type='spectrum_2d';
                data_load{i}.info=info_data;
                data_load{i}.name=file_name{i}(1:end-4);
                clear c_data_wanted c_data_test
                
                waitbar(1,f,'Please wait...');
                
            elseif lens_mode=='Lens Mode=Transmission'
                for n=1:length(info_data)
                    test=strfind(info_data(n),'Dimension 1 scale');
                    if test==1
                        break
                    end
                end
                x_data=char(whole_data(n));
                x_data=x_data(19:end);
                x_data=strsplit(x_data,' ');
                x_data=str2double(x_data);
                
                waitbar(0.3,f,'Please wait...');
                
                c_data=whole_data(c_data_start+1:end);
                for k=1:length(c_data)
                    c_data_test=strsplit(c_data(k),' ');
                    c_data_test=str2double(c_data_test);
                    c_data_wanted(k,:)=c_data_test;
                end
                c_data_wanted=c_data_wanted(1:end-1,3:end);
                y_data=sum(c_data_wanted,2)';
                
                waitbar(0.4,f,'Please wait...');
                x_data = x_data';
                y_data = y_data';
                if x_data(2)<x_data(1)
                    x_data = flipud(x_data);
                    y_data = flipud(y_data);
                end                
                info_data=cellstr(info_data);
                data_load{i}.x_data=x_data;
                data_load{i}.y_data=y_data;
                data_load{i}.type='spectrum_1d';
                data_load{i}.info=info_data;
                data_load{i}.name=file_name{i}(1:end-4);
                clear c_data_wanted c_data_test
                
                waitbar(1,f,'Please wait...');
            end
            close(f)
        catch
            msgbox('file selected is not from EW4000 Spectrometer')
            data_load{i} = [];
            close(f)
        end
    end
    data_load = data_load(~cellfun('isempty',data_load));    
end
end