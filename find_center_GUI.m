function varargout = find_center_GUI(varargin)
% FIND_CENTER_GUI MATLAB code for find_center_GUI.fig
%      FIND_CENTER_GUI, by itself, creates a new FIND_CENTER_GUI or raises the existing
%      singleton*.
%
%      H = FIND_CENTER_GUI returns the handle to a new FIND_CENTER_GUI or the handle to
%      the existing singleton*.
%
%      FIND_CENTER_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIND_CENTER_GUI.M with the given input arguments.
%
%      FIND_CENTER_GUI('Property','Value',...) creates a new FIND_CENTER_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before find_center_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to find_center_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help find_center_GUI

% Last Modified by GUIDE v2.5 23-Feb-2017 15:10:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @find_center_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @find_center_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
              
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end


if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


addpath('auxiliary_functions\');

% --- Executes just before find_center_GUI is made visible.
function find_center_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to find_center_GUI (see VARARGIN)

handles.input.image=struct([]);
%handles.input.image=evalin('base', 'F.*B');

for ii=1:length(varargin)
        
    [noRow,noCol]=size(varargin{ii});    
    
    if isnumeric(varargin{ii})&&(noRow>1)&&(noCol>1)
        handles.input.image=varargin{ii};    
    end
end

%hold; not necessary cause of nextplotproperty=add

if not(isempty(handles.input.image))
   handles.image.base=imagesc(handles.axes1, handles.input.image);axis square;colormap gray;
else
    handles.image.base=imagesc(handles.axes1);axis square;colormap gray;
end

set(handles.image.base,'HitTest','off');


%getting no of image pixels
[noOfRow,noOfCol]=size(get(handles.image.base,'CData'));
handles.image.size=[noOfRow,noOfCol];

%resetting axis limits
set(handles.axes1,'XLim',[1, noOfCol]); xlim manual;
set(handles.axes1,'YLim',[1, noOfRow]); ylim manual;

%make blue/low field
handles.image.loSelect=zeros(noOfRow,noOfCol,'logical'); 
handles.image.blue = image(cat(3, zeros(noOfRow,noOfCol,'logical'), zeros(noOfRow,noOfCol,'logical'), handles.image.loSelect));
set(handles.image.blue,'HitTest','off');
handles.image.blue.AlphaDataMapping = 'direct'; 
handles.image.blue.AlphaData = 35*handles.image.loSelect;

%make magenta/hi field
handles.image.hiSelect=zeros(noOfRow,noOfCol,'logical'); 
handles.image.magenta = image(cat(3, handles.image.hiSelect, zeros(noOfRow,noOfCol,'logical'), handles.image.hiSelect));
set(handles.image.magenta,'HitTest','off');
handles.image.magenta.AlphaDataMapping = 'direct'; 
handles.image.magenta.AlphaData = 35*handles.image.hiSelect;

%make yellow/star field
handles.image.starSelect=zeros(noOfRow,noOfCol,'logical'); 
handles.image.yellow = image(cat(3, handles.image.starSelect, handles.image.starSelect, zeros(noOfRow,noOfCol,'logical')));
set(handles.image.yellow,'HitTest','off');
handles.image.yellow.AlphaDataMapping = 'direct'; 
handles.image.yellow.AlphaData = 35*handles.image.starSelect;



%initialize userinput

handles.userInput.thresholdStr='threshold';
handles.userInput.thresh_percentStr='30';

%initialize calculated
handles.calculated.lo_mean=NaN;
handles.calculated.lo_std=NaN;
handles.calculated.hi_mean=NaN;
handles.calculated.hi_std=NaN;
handles.calculated.thresh=NaN;
handles.calculated.xCenter=NaN;
handles.calculated.yCenter=NaN;

% Choose default command line output for find_center_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes find_center_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = find_center_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in lo_vis_cBox.
function lo_vis_cBox_Callback(hObject, eventdata, handles)
% hObject    handle to lo_vis_cBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.image.blue.AlphaData = 35 * get(hObject,'Value')*handles.image.loSelect;
%{
if get(hObject,'Value') == get(hObject,'Min')
    handles.image.red.AlphaData = 0;
elseif get(hObject,'Value') == get(hObject,'Max')
    handles.image.red.AlphaData = 35;
end
%}
% Hint: get(hObject,'Value') returns toggle state of lo_vis_cBox


% --- Executes on button press in lo_select_but.
function lo_select_but_Callback(hObject, eventdata, handles)
% hObject    handle to lo_select_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
but_deselection_fct(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of lo_select_but


% --- Executes on button press in lo_deselect_but.
function lo_deselect_but_Callback(hObject, eventdata, handles)
% hObject    handle to lo_deselect_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
but_deselection_fct(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of lo_deselect_but


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in togglebutton4.
function togglebutton4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton4


% --- Executes on button press in togglebutton5.
function togglebutton5_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton5


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in togglebutton6.
function togglebutton6_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton6


% --- Executes on button press in togglebutton7.
function togglebutton7_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton7



function enter_threshold_Callback(hObject, eventdata, handles)
% hObject    handle to enter_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isnan(str2double(hObject.String))
    hObject.String=handles.userInput.thresh_percentStr;
else
    handles.userInput.thresholdStr=hObject.String;
    guidata(handles.figure1,handles);
end
% Hints: get(hObject,'String') returns contents of enter_threshold as text
%        str2double(get(hObject,'String')) returns contents of enter_threshold as a double


% --- Executes during object creation, after setting all properties.
function enter_threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to enter_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in hi_pass_rad_but.
function hi_pass_rad_but_Callback(hObject, eventdata, handles)
% hObject    handle to hi_pass_rad_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.hi_pass_rad_but,'Value', get(handles.hi_pass_rad_but,'Max')); 
set(handles.lo_pass_rad_but,'Value', get(handles.lo_pass_rad_but,'Min'));

handles.lo_hi_hi_lo_text.String='% of low to high';
% Hint: get(hObject,'Value') returns toggle state of hi_pass_rad_but

% --- Executes on button press in lo_pass_rad_but.
function lo_pass_rad_but_Callback(hObject, eventdata, handles)
% hObject    handle to lo_pass_rad_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.hi_pass_rad_but,'Value', get(handles.hi_pass_rad_but,'Min'))
set(handles.lo_pass_rad_but,'Value', get(handles.lo_pass_rad_but,'Max'));

handles.lo_hi_hi_lo_text.String='% of high to low';
% Hint: get(hObject,'Value') returns toggle state of lo_pass_rad_but



% --- Executes on button press in hi_vis_cBox.
function hi_vis_cBox_Callback(hObject, eventdata, handles)
% hObject    handle to hi_vis_cBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.image.magenta.AlphaData = 35 * get(hObject,'Value')*handles.image.hiSelect;
% Hint: get(hObject,'Value') returns toggle state of hi_vis_cBox


% --- Executes on button press in star_vis_cBox.
function star_vis_cBox_Callback(hObject, eventdata, handles)
% hObject    handle to star_vis_cBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.image.yellow.AlphaData = 35 * get(hObject,'Value')*handles.image.starSelect;
% Hint: get(hObject,'Value') returns toggle state of star_vis_cBox




% --- Executes on button press in hi_select_but.
function hi_select_but_Callback(hObject, eventdata, handles)
% hObject    handle to hi_select_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
but_deselection_fct(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of hi_select_but


% --- Executes on button press in hi_deselect_but.
function hi_deselect_but_Callback(hObject, eventdata, handles)
% hObject    handle to hi_deselect_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
but_deselection_fct(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of hi_deselect_but


% --- Executes on button press in star_select_but.
function star_select_but_Callback(hObject, eventdata, handles)
% hObject    handle to star_select_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
but_deselection_fct(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of star_select_but


% --- Executes on button press in star_deselect_but.
function star_deselect_but_Callback(hObject, eventdata, handles)
% hObject    handle to star_deselect_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
but_deselection_fct(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of star_deselect_but


% --- Executes on button press in find_center_but.
function find_center_but_Callback(hObject, eventdata, handles)


[xCenter,yCenter] = findGeomCenter_GUIVer(handles);

handles.calculated.xCenter=xCenter;
handles.calculated.yCenter=yCenter;

handles.center_disp_text.String=['[' num2str(round(xCenter*100)/100) ',' num2str(round(yCenter*100)/100) ']'];

guidata(handles.figure1,handles);




%but_deselection_fct
function but_deselection_fct(hObject, handles)

tagCell={'lo_select_but','hi_select_but','lo_deselect_but','hi_deselect_but','star_select_but','star_deselect_but'};

for ii=1:6
    
eval(['H=handles.' tagCell{ii} ';']);
    
if ne(H,hObject)
set(H,'Value', get(H,'Min')) 
end
end


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  if (isAboveImage(handles))    
    cursor_coordinate_AND_Val_UpdateFcn(handles.cursor_coordinate, eventdata, handles);
    %cursor_value_UpdateFcn(handles)
 end
%}
% CP= get(handles.axes1,'CurrentPoint');

   %X_CP= CP(1,1);
   %Y_CP= CP(1,2);
   
   %coordString= ['[' num2str(X_CP) ',' num2str(Y_CP) ']'];
   
   %set(handles.cursor_coordinate,'String',coordString);
   
   
function cursor_coordinate_AND_Val_UpdateFcn(hObject, eventdata, handles)

 CP= get(handles.axes1,'CurrentPoint');

   X_CP= CP(1,1);
   Y_CP= CP(1,2);
   
   coordString= ['[ ' num2str(round(X_CP*100)/100) ', ' num2str(round(Y_CP*100)/100) ' ]'];
   
   set(handles.cursor_coordinate,'String',coordString);
   
   %get img val=
   currentVal=handles.image.base.CData(round(Y_CP),round(X_CP));
   valString =  num2str(currentVal);
   set(handles.cursor_val,'String',valString); 

function pix_sel_rad_Callback(hObject, eventdata, handles)
% hObject    handle to pix_sel_rad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pix_sel_rad as text
%        str2double(get(hObject,'String')) returns contents of pix_sel_rad as a double


% --- Executes during object creation, after setting all properties.
function pix_sel_rad_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pix_sel_rad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'String', num2str(sqrt(0.5),3));
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if not(isAboveImage(handles))
    return;
end

tagCell={'lo_select_but','lo_deselect_but','hi_select_but','hi_deselect_but','star_select_but','star_deselect_but'};
jj=0;
% figures out which button is currently pressed
for ii=1:6
    
    eval(['H=handles.' tagCell{ii} ';']); 

    if get(H,'Value') %if it is 1
        jj=ii; break;
    elseif (ii==6)&&(jj==0) %if no button is pressed
        return; %end func
    end
end


CP= get(handles.axes1,'CurrentPoint');

   X_CP= CP(1,1);
   Y_CP= CP(1,2);

   pixel_selection_delta=str2double(get(handles.pix_sel_rad,'String'));
    
   
pixelsWithInRad = findCirclePixels( handles.image.size, [Y_CP,X_CP], 0, pixel_selection_delta); 


for kk=1:size(pixelsWithInRad,1)
    if jj<3 %select low selec mask
        handles.image.loSelect( pixelsWithInRad(kk,1), pixelsWithInRad(kk,2) ) = logical(mod(jj,2));
    elseif jj<5 %select hi selec mask
        handles.image.hiSelect( pixelsWithInRad(kk,1), pixelsWithInRad(kk,2) ) = logical(mod(jj,2));
    elseif jj<7 %select star selec mask
        handles.image.starSelect( pixelsWithInRad(kk,1), pixelsWithInRad(kk,2) ) = logical(mod(jj,2));
    end
end

guidata(handles.figure1,handles)
 
noOfRow=handles.image.size(1);
noOfCol=handles.image.size(2);

if jj<3 %select low selec mask
    set(handles.image.blue,'CData', cat(3, zeros(noOfRow,noOfCol,'logical'), zeros(noOfRow,noOfCol,'logical'), handles.image.loSelect) );
    handles.image.blue.AlphaData = 35 * get(handles.lo_vis_cBox,'Value')*handles.image.loSelect;
    
    %call mean_std_update
    mean_std_update_fcn(handles, 'lo'); 
    
elseif jj<5 %select hi selec mask
    set(handles.image.magenta,'CData', cat(3, handles.image.hiSelect, zeros(noOfRow,noOfCol,'logical'), handles.image.hiSelect) );
    handles.image.magenta.AlphaData = 35 * get(handles.hi_vis_cBox,'Value')*handles.image.hiSelect;
    
    %call mean_std_update
    mean_std_update_fcn(handles, 'hi');  
    
elseif jj<7 %selec star mask
    set(handles.image.yellow,'CData', cat(3, handles.image.starSelect, handles.image.starSelect, zeros(noOfRow,noOfCol,'logical')) );
    handles.image.yellow.AlphaData = 35 * get(handles.star_vis_cBox,'Value')*handles.image.starSelect;  
end

function mean_std_update_fcn(handles, lo_hi_Str)

if strcmp(lo_hi_Str,'lo')
    maskMatrix=handles.image.loSelect;
elseif  strcmp(lo_hi_Str,'hi')
    maskMatrix=handles.image.hiSelect;
else
    error('Second variable: lo_hi_Str does not contain a valid value');
end

%go through lo/hi select matrix and if its a one, read out value of
%image.base and add to a vector
noOfRow=handles.image.size(1);
noOfCol=handles.image.size(2);

selIndex=0;
selectionVec=[];

for yy=1:noOfRow
    for xx=1:noOfCol
        
        if maskMatrix(yy,xx)==true
            selIndex=selIndex+1;
            selectionVec(selIndex)=handles.image.base.CData(yy,xx);
        end
        
    end
end

meanVal=mean(selectionVec);
stdVal=std(selectionVec);

if strcmp(lo_hi_Str,'lo')
    set(handles.lo_mean,'String',num2str(meanVal));
    set(handles.lo_std,'String',num2str(stdVal));
    handles.calculated.lo_mean=meanVal;
    handles.calculated.lo_std=stdVal;
elseif  strcmp(lo_hi_Str,'hi')
    set(handles.hi_mean,'String',num2str(meanVal));
    set(handles.hi_std,'String',num2str(stdVal));
    handles.calculated.hi_mean=meanVal;
    handles.calculated.hi_std=stdVal;
else
    error('Second variable: lo_hi_Str does not contain a valid value');
end

guidata(handles.figure1,handles);    
%get mean and std and enter in appropriate field
%
%put mean and std in appropriate textbox
%
%update gui



     


% --- Executes on button press in thresh_calc_but.
function thresh_calc_but_Callback(hObject, eventdata, handles)
% hObject    handle to thresh_calc_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
thresh_percent=str2double(handles.userInput.thresh_percentStr);

lo_hi_dif=handles.calculated.hi_mean-handles.calculated.lo_mean;

if get(handles.hi_pass_rad_but,'Value')
    calc_thresh= handles.calculated.lo_mean + (lo_hi_dif*thresh_percent/100);
elseif get(handles.lo_pass_rad_but,'Value')
    calc_thresh= handles.calculated.hi_mean - (lo_hi_dif*thresh_percent/100);
else
    return;
end

handles.calculated.thresh=calc_thresh;
guidata(handles.figure1,handles);

sel_calc_thresh_Callback(handles.sel_calc_thresh, eventdata, handles);

 


% Hint: get(hObject,'Value') returns toggle state of thresh_calc_but


% --- Executes on button press in sel_calc_thresh.
function sel_calc_thresh_Callback(hObject, eventdata, handles)
% hObject    handle to sel_calc_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.sel_calc_thresh,'Value',1);
set(handles.sel_user_thresh,'Value',0);
set(handles.enter_threshold, 'Enable', 'inactive');
set(handles.enter_threshold, 'String', num2str(handles.calculated.thresh));

% Hint: get(hObject,'Value') returns toggle state of sel_calc_thresh


% --- Executes on button press in sel_user_thresh.
function sel_user_thresh_Callback(hObject, eventdata, handles)
% hObject    handle to sel_user_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.sel_user_thresh,'Value',1);
set(handles.sel_calc_thresh,'Value',0);
set(handles.enter_threshold, 'Enable', 'on');
set(handles.enter_threshold, 'String', handles.userInput.thresholdStr);
% Hint: get(hObject,'Value') returns toggle state of sel_user_thresh



function enter_thresh_percent_Callback(hObject, eventdata, handles)
% hObject    handle to enter_thresh_percent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input=get(hObject,'String');

inputNum=str2double(input);

if isnan(inputNum)
    set(hObject,'String',handles.userInput.thresh_percentStr);
    return;
else
    handles.userInput.thresh_percentStr=input;
    guidata(handles.figure1,handles);
end

    
% Hints: get(hObject,'String') returns contents of enter_thresh_percent as text
%        str2double(get(hObject,'String')) returns contents of enter_thresh_percent as a double


% --- Executes during object creation, after setting all properties.
function enter_thresh_percent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to enter_thresh_percent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
