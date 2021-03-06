function disp_pix_selection( handles )

noOfRow=handles.image.size(1);
noOfCol=handles.image.size(2);

CP= get(handles.axes1,'CurrentPoint');

   X_CP= CP(1,1);
   Y_CP= CP(1,2);

   pixel_selection_delta=str2double(get(handles.pix_sel_rad,'String'));
    
   
pixelsWithInRad = findCirclePixels( handles.image.size, [Y_CP,X_CP], 0, pixel_selection_delta); 

if isempty(pixelsWithInRad)
    return;
end

for kk=1:size(pixelsWithInRad,1)
    if isnan(pixelsWithInRad(kk,1))
        break;
    else
    handles.image.currentSelect( pixelsWithInRad(kk,1), pixelsWithInRad(kk,2) ) = true;
    end
end

set(handles.image.cyan,'CData', cat(3, zeros(noOfRow,noOfCol,'logical'), handles.image.currentSelect, handles.image.currentSelect) );
handles.image.cyan.AlphaData = 35 *handles.image.currentSelect;
drawnow;
end
