function [ Y_or_No ] = isAboveImage( handles )
%ISABOVEAXES Summary of this function goes here
%   Detailed explanation goes here

 CP= get(handles.axes1,'CurrentPoint');

   X_CP= CP(1,1);
   Y_CP= CP(1,2);
 
 noOfRow=handles.image.size(1);
 noOfCol=handles.image.size(2);
   
 %axesPosition= get(handles.axes1,'Position');  

 if (X_CP>0.5) &&(X_CP<noOfCol+0.5)&&...
         (Y_CP>0.5)&&(Y_CP<noOfRow+0.5)
     Y_or_No=true;
 else
     Y_or_No=false;
 end

end

