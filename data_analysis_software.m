function data_analysis_software()
warning off
clear global;clear;clc;
addpath(strcat(pwd,'\load_files'))
addpath(strcat(pwd,'\load_files\photoemission'))
addpath(strcat(pwd,'\spectrum_1d_analysis'))
addpath(strcat(pwd,'\spectrum_1d_analysis\voigt_peak_fit'))
addpath(strcat(pwd,'\spectrum_2d_analysis'))
addpath(strcat(pwd,'\spectrum_3d_analysis'))
addpath(strcat(pwd,'\colormaps'))
addpath(strcat(pwd,'\general'))
figure()
set(gcf,'name','Data Analysis SOFTWARE','NumberTitle','off','color','w','units','normalized','position',[0.35 0.25 0.3 0.6],'menubar','none')

global listbox data
listbox = uicontrol('style','listbox','units','normalized','position',[0,0.05,1,0.95],'string','NaN','ForegroundColor','b','Callback',{@listbox_callback},'Max',100,'FontSize',12);
uicontrol('style','text','units','normalized','position',[0,0,0.15,0.05],'string','File Type:','BackgroundColor','w','Fontsize',12);
file_type = uicontrol('style','text','units','normalized','position',[0.15,0,0.3,0.05],'string','NaN','BackgroundColor','w','Fontsize',12);
uicontrol('style','text','units','normalized','position',[0.45,0,0.2,0.05],'string','File Size (MB):','BackgroundColor','w','Fontsize',12);
file_size = uicontrol('style','text','units','normalized','position',[0.65,0,0.3,0.05],'string','NaN','BackgroundColor','w','Fontsize',12);

    function listbox_callback(~,~,~)
        listbox = set_listbox_names(listbox);
        file_type = set_file_type(listbox,file_type);
        file_size = set_file_size(listbox,file_size);
    end
%---------------------file_menu---------------------
file_menu = uimenu('Text','File');

load_data_menu = uimenu(file_menu,'Text','Load Data');
uimenu(load_data_menu,'Text','TEXT Files(s)','Callback',{@load_txt_callback});
uimenu(load_data_menu,'Text','Igor h5 Files(s)','Callback',{@load_h5_callback});
uimenu(load_data_menu,'Text','Diamond Data (Spectrum 1D)','Callback',{@load_diamond_spectrum_1d_callback});
uimenu(load_data_menu,'Text','Diamond Data (Spectrum 2D)','Callback',{@load_diamond_spectrum_2d_callback});
uimenu(load_data_menu,'Text','EW4000 Data','Callback',{@load_ew4000});
uimenu(load_data_menu,'Text','Igor ibw Data','Callback',{@load_igor_ibw_data});

uimenu(file_menu,'Text','Load Session','Callback',{@load_session});
uimenu(file_menu,'Text','Save Session','Callback',{@save_session});

    function load_txt_callback(~,~,~)                
        data_load = load_txt_file();
        data = set_global_data(data,data_load);
        listbox = set_listbox_names(listbox);        
    end

    function load_h5_callback(~,~,~)                
        data_load = load_igor_h5();
        data = set_global_data(data,data_load);
        listbox = set_listbox_names(listbox);        
    end

    function load_diamond_spectrum_1d_callback(~,~,~)                
        data_load = load_diamond_spectrum_1d();
        data = set_global_data(data,data_load);
        listbox = set_listbox_names(listbox);        
    end

    function load_diamond_spectrum_2d_callback(~,~,~)                
        data_load = load_diamond_spectrum_2d();
        data = set_global_data(data,data_load);
        listbox = set_listbox_names(listbox);        
    end

    function load_ew4000(~,~,~)                
        data_load = load_ew4000_spectrum();
        data = set_global_data(data,data_load);
        listbox = set_listbox_names(listbox);        
    end

    function load_igor_ibw_data(~,~,~)                
        data_load = load_igor_ibw();
        data = set_global_data(data,data_load);
        listbox = set_listbox_names(listbox);        
    end
    
    function save_session(~,~,~)
        if isempty(data)
            msgbox('List is empty')
            return
        else
            [file,path] = uiputfile('.mat','Save Session');
            if isequal(file,0)
                return
            else                
                f = waitbar(0,'Saving, Please Wait...');                
                save(fullfile(path,file),'data','-v7.3')
                waitbar(1,f,'Saving, Please Wait...')
                close(f)
            end
        end
    end

    function load_session(~,~,~)
        [file_name,path] = uigetfile('*.mat','Select Session','MultiSelect','off');
        if isequal(file_name,0)
            return
        else
            try
                data_load=load(fullfile(path,file_name));
                data_load = data_load.data;
            catch
                msgbox('file selected is not correct')
                data_load=[];
            end
            data = set_global_data(data,data_load);
        end
        listbox = set_listbox_names(listbox);
        listbox.Value = 1;
    end
%---------------------file_menu---------------------
%---------------------edit menu---------------------
edit_menu = uimenu('Text','Edit');
uimenu(edit_menu,'Text','Delete Files(s)','Callback',{@delete_callback});
uimenu(edit_menu,'Text','Rename Files(s)','Callback',{@rename_callback});

    function delete_callback(~,~,~)
        listbox_value = listbox.Value;
        if isempty(data)
            msgbox('List is empty')
            return
        else
            choice = questdlg('Are you sure you want to delete the selected files','Close','Yes','No','Yes');
            switch choice
                case 'Yes'
                    data(listbox_value) = [];
                    data = data(~cellfun('isempty',data));
                case 'No'
                    return
            end
        end
        listbox = set_listbox_names(listbox);
        listbox.Value = 1;
    end

    function rename_callback(~,~,~)
        listbox_value = listbox.Value;
        if isempty(data)
            msgbox('List is empty')
            return
        else
            input_values = inputdlg('chnage name(s) to:','',1,{data{listbox_value(1)}.name});
            if isempty(input_values)==1
                return
            else
                new_name = input_values{1};
                for i=1:length(listbox_value)
                    data{listbox_value(i)}.name = new_name;
                end
            end
        end
        listbox = set_listbox_names(listbox);
        listbox.Value = 1;
    end
%---------------------edit menu---------------------
%---------------------plot menu--------------------
uimenu('Text','Plot','Callback',{@plot_callback});

    function plot_callback(~,~,~)
        if isempty(data)~=1
            [same_type_file,type_file] = same_type(listbox);
            listbox_value = listbox.Value;
            if same_type_file==1
                if isequal(type_file,'spectrum_1d')
                    spectrum_1d_plot(data(listbox_value))
                elseif isequal(type_file,'loc_list')
                    loc_list_plot(data(listbox_value));
                elseif isequal(type_file,'spectrum_3d')
                    spectrum_3d_plot(data{listbox_value(1)});
                elseif isequal(type_file,'spectrum_2d')
                    spectrum_2d_plot(data(listbox_value))
                elseif isequal(type_file,'spt')
                    data(listbox_value) = spt_plot(data(listbox_value));
                elseif isequal(type_file,'image')
                    image_plot(data(listbox_value))
                elseif isequal(type_file,'voronoi_data')
                    voronoi_data_plot(data(listbox_value))
                end
            else
                msgbox('data selected should be the same data type')
            end
        end
    end
%---------------------plot menu--------------------
%---------------------help menu---------------------
help_menu = uimenu('Text','Help');
uimenu(help_menu,'Text','About','Callback',{@about_callback});

    function about_callback(~,~,~)
        dos('explorer https://www.arianarab.com');       
    end
%---------------------help menu---------------------
end

function listbox = set_listbox_names(listbox)
global data 
if isempty(data)==1
    listbox.String = 'NaN';
else
    for i=1:length(data)
        names{i} = data{i}.name;        
    end
    listbox.String = names;    
end
end

function [file_type]= set_file_size(listbox,file_type)
global data
listbox_value = listbox.Value;
if isempty(data)
    file_type.String = 'NaN';    
else
    for i=1:length(listbox_value)        
        total_size(i) = get_size(data{listbox_value(i)});
    end    
    total_size = sum(total_size);
    file_type.String = num2str(total_size);
end
end

function [file_size]= set_file_type(listbox,file_size)
global data
listbox_value = listbox.Value;
if isempty(data)
    file_size.String = 'NaN';    
else
    file_size.String = data{listbox_value(1)}.type;
end
end

function [same_type_file,type_file] = same_type(listbox)
global data
listbox_value = listbox.Value;
if isempty(data)~=1
    for i=1:length(listbox_value)
        data_type{i} = data{listbox_value(i)}.type;
    end
    same_type_file = length(unique(data_type));
    type_file = data_type{1};
end
end

function data = set_global_data(data,data_load)
if isempty(data)==1
    data=data_load;
else
    data= horzcat(data,data_load);
end
end