function [ Y_or_No ] = isAboveAxes( handles )
%ISABOVEAXES Summary of this function goes here
%   Detailed explanation goes here

 CP= get(handles.figure1,'CurrentPoint');

   X_CP= CP(1,1);
   Y_CP= CP(1,2);
 
 axesPosition= get(handles.axes1,'Position');  

 if (X_CP>axesPosition(1)) &&(X_CP<axesPosition(1)+axesPosition(3))&&...
         (Y_CP>axesPosition(2))&&(Y_CP<axesPosition(2)+axesPosition(4))
     Y_or_No=true;
 else
     Y_or_No=false;
 end

end

