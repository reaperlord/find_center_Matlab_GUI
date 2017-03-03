function getDistanceBtwnPoints(fig_handle, varargin )
%GETDISTANCEBTWNPOINTS Summary of this function goes here
%   Detailed explanation goes here

%check whether both points are defined or center is taken as 2nd point

handles=guidata(fig_handle); %updatesHandles

pos_pt1=[];
pos_pt2=[];

if nargin>1        
    if varargin{2}==1
      pos_pt1=varargin{1};  
    elseif varargin{2}==2
      pos_pt2=varargin{1};
    else
        return;
    end
end


if isempty(pos_pt2) %if not empty pt2 was being moved

    if handles.use_cntr_chkbox.Value %use center as second
        if isfield(handles, 'centerPoint')
            pt2=handles.centerPoint;
        else
            handles.pt1_pt2_dist_txt.String=num2str(nan);
            return
        end

    else %dont use centr as second => use second as second
        if isempty(handles.pt2)
            handles.pt1_pt2_dist_txt.String=num2str(nan);
            return % no pt2 defined
        else
            pt2=handles.pt2;
        end 
    end

   pos_pt2=pt2.getPosition; 
    
end

if isempty(pos_pt1)

    if isempty(handles.pt1)
        handles.pt1_pt2_dist_txt.String=num2str(nan);
        return;    
    else
        pt1=handles.pt1;
    end
    
    pos_pt1=pt1.getPosition;
end



euclidDist=sqrt( (pos_pt1(1)-pos_pt2(1))^2 + (pos_pt1(2)-pos_pt2(2))^2 );

handles.calculated.distance=euclidDist;

handles.pt1_pt2_dist_txt.String=num2str(euclidDist,'%.2f');

guidata(handles.figure1,handles);

end
