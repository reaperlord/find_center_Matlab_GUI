%%find geomCenter

function [xCenter,yCenter] = findGeomCenter_GUIVer(handles)



hiFlag=handles.hi_pass_rad_but.Value;
loFlag=handles.lo_pass_rad_but.Value;
starMask=handles.image.starSelect;
cutOffThresh=str2double(handles.enter_threshold.String);

valueCoeff= hiFlag- loFlag;
threshCoeff= loFlag- hiFlag;

noOfRow=handles.image.size(1);
noOfCol=handles.image.size(2);

counter=0;
    
for xx=1:noOfCol
    for yy=1:noOfRow
        
        if starMask(yy,xx)==true
        
            value= handles.image.base.CData(yy,xx);

            if ((valueCoeff*value) + (threshCoeff*cutOffThresh))>0

                counter=counter+1;
                XVec(counter)=xx;
                YVec(counter)=yy;
            end
        end
    end
end

xCenter=mean(XVec);
yCenter=mean(YVec);