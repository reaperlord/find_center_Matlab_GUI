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

% Last Modified by GUIDE v2.5 17-Feb-2017 16:58:21

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


% --- Executes just before find_center_GUI is made visible.
function find_center_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to find_center_GUI (see VARARGIN)

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

% Hint: get(hObject,'Value') returns toggle state of lo_vis_cBox


% --- Executes on button press in lo_select_but.
function lo_select_but_Callback(hObject, eventdata, handles)
% hObject    handle to lo_select_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lo_select_but


% --- Executes on button press in lo_deselect_but.
function lo_deselect_but_Callback(hObject, eventdata, handles)
% hObject    handle to lo_deselect_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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

% Hint: get(hObject,'Value') returns toggle state of hi_pass_rad_but


% --- Executes on button press in hi_vis_cBox.
function hi_vis_cBox_Callback(hObject, eventdata, handles)
% hObject    handle to hi_vis_cBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hi_vis_cBox


% --- Executes on button press in star_vis_cBox.
function star_vis_cBox_Callback(hObject, eventdata, handles)
% hObject    handle to star_vis_cBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of star_vis_cBox


% --- Executes on button press in lo_pass_rad_but.
function lo_pass_rad_but_Callback(hObject, eventdata, handles)
% hObject    handle to lo_pass_rad_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lo_pass_rad_but


% --- Executes on button press in hi_select_but.
function hi_select_but_Callback(hObject, eventdata, handles)
% hObject    handle to hi_select_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hi_select_but


% --- Executes on button press in hi_deselect_but.
function hi_deselect_but_Callback(hObject, eventdata, handles)
% hObject    handle to hi_deselect_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hi_deselect_but


% --- Executes on button press in star_select_but.
function star_select_but_Callback(hObject, eventdata, handles)
% hObject    handle to star_select_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of star_select_but


% --- Executes on button press in star_deselect_but.
function star_deselect_but_Callback(hObject, eventdata, handles)
% hObject    handle to star_deselect_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of star_deselect_but


% --- Executes on button press in find_center_but.
function find_center_but_Callback(hObject, eventdata, handles)
% hObject    handle to find_center_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
