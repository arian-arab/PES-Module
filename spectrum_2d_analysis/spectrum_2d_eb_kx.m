function spectrum_2d_eb_kx(data)
InputValues = inputdlg({'Photon Energy(eV):','Work Function(eV)','Incidence Angle(degrees)'},'',1,{'600','5','20'});
if isempty(InputValues)==1
    return
else
    hv=str2double(InputValues{1});
    w=str2double(InputValues{2});
    inc=str2double(InputValues{3});
    r=0.5124*sqrt(hv-w);
    hv_p=0.506*(hv/1000);
    for k=1:length(data)        
        data{k}.x_data = r*sind(data{k}.x_data)+hv_p*cosd(inc);
    end
    spectrum_2d_plot(data)
end
end