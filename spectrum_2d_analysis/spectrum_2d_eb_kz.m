function spectrum_2d_eb_kz(data)
InputValues = inputdlg({'Photon Energy(eV):','Work Function(eV)','Incidence Angle(degrees)','Inner Potential(eV)','Take off Angle'},'',1,{'600','5','20','10','0'});
if isempty(InputValues)==1
    return
else
    hv=str2double(InputValues{1});
    w=str2double(InputValues{2});
    inc=str2double(InputValues{3});
    inner_poten=str2double(InputValues{4});
    tof=str2double(InputValues{5});
    hv_p=0.506*(hv/1000);
    for k=1:length(data)        
        data{k}.x_data = 0.5124*sqrt((data{k}.x_data-w).*cosd(tof).*cosd(tof)+inner_poten)-hv_p*sind(inc);
    end
    spectrum_2d_plot(data)
end
end