function [data,N] = spectrum_3d_integration_z(data)
InputValues = inputdlg({'integration window:'},'',1, {'5'});
if isempty(InputValues)==1
    N = 1;   
    return
else
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
end
end