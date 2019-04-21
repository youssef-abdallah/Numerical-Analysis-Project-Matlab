function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 16-Apr-2019 21:30:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in methods.
function methods_Callback(hObject, eventdata, handles)
% hObject    handle to methods (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns methods contents as cell array
%        contents{get(hObject,'Value')} returns selected item from methods
contents = get(hObject,'Value');

switch contents
    case 1
        %Empty
        v = 1;
        set(handles.Info,'Visible','Off');
        set(handles.NP,'Visible','Off');
        set(handles.RT,'Visible','Off');
    case 2
        %Bisection
        v = 2;
        %handle CoiumnNames in this Case-----------------------------------
        %handle String of xx0 ,xx1 in this Case----------------------------
        %handle Visiblity of Panes-----------------------------------------
    case 3
        %False Postion
        v = 3;
        set(handles.table,'ColumnName', {'Xl', 'Xu', 'Xr', 'F(Xr)', 'Es'});
        set(handles.xx0,'String','Xl');
        set(handles.xx1,'String','Xu');
        set(handles.Info,'Visible','On');
        set(handles.X1,'Visible','On');
        set(handles.xx1,'Visible','On');
    case 4
        %Fixed Point
        v = 4;
        %handle CoiumnNames in this Case-----------------------------------
        %handle String of xx0 ,xx1 in this Case----------------------------
        %handle Visiblity of Panes-----------------------------------------
    case 5
        %Newton Raphson
        v = 5;
        set(handles.table,'ColumnName', {'Xi', 'F(Xi)', 'Xi+1', 'F(Xi+1)', 'Es'});
        set(handles.xx0,'String','X0');
        set(handles.Info,'Visible','On');
        set(handles.X1,'Visible','Off');
        set(handles.xx1,'Visible','Off');
    case 6
        %Secant
        v = 6;
        set(handles.table,'ColumnName', {'Xi-1', 'Xi', 'Xi+1', 'F(Xi+1)', 'Es'});
        set(handles.xx0,'String','Xi-1');
        set(handles.xx1,'String','Xi');
        set(handles.Info,'Visible','On');
        set(handles.X1,'Visible','On');
        set(handles.xx1,'Visible','On');
    case 7
        %Bierge Vieta
        v = 7;
        %handle CoiumnNames in this Case-----------------------------------
        %handle String of xx0 ,xx1 in this Case----------------------------
        %handle Visiblity of Panes-----------------------------------------
    case 8
        %All
        v = 8;
        %handle CoiumnNames in this Case-----------------------------------
        %handle String of xx0 ,xx1 in this Case----------------------------
        set(handles.Info,'Visible','On');
        set(handles.X1,'Visible','Off');
        set(handles.xx1,'Visible','Off');
    otherwise
end 
set(handles.methods, 'Val', v);


% --- Executes during object creation, after setting all properties.
function methods_CreateFcn(hObject, eventdata, handles)
% hObject    handle to methods (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Next.
function Next_Callback(hObject, eventdata, handles)
% hObject    handle to Next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global itr arr h1 h2 h3;
v = get(handles.methods, 'Val');
% need for know how many plots  draw---------------------------------------
s = size(arr,1);
if itr ~= 0
    delete(h1);
    delete(h2);
    delete(h3);
end
if (itr + 1) < (max(s)+1)
    itr = itr + 1;
end
xx = arr{itr,1};
yy = -10:10;
h1 = plot(xx*ones(size(yy)),yy, 'k');
xx = arr{itr,2};
h2 = plot(xx*ones(size(yy)),yy, 'k');
xx = arr{itr,3};
h3 = plot(xx*ones(size(yy)),yy, 'g');

% --- Executes on button press in Previous.
function Previous_Callback(hObject, eventdata, handles)
% hObject    handle to Previous (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global itr arr h1 h2 h3;
v = get(handles.methods, 'Val');
% need for know how many plots  draw---------------------------------------
if itr ~= 0
    delete(h1);
    delete(h2);
    delete(h3);
end
if (itr - 1) > 0
    itr = itr - 1;
end
xx = arr{itr,1};
yy = -10:10;
h1 = plot(xx*ones(size(yy)),yy, 'k');
xx = arr{itr,2};
h2 = plot(xx*ones(size(yy)),yy, 'k');
xx = arr{itr,3};
h3 = plot(xx*ones(size(yy)),yy, 'g');


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Calculate.
function Calculate_Callback(hObject, eventdata, handles)
% hObject    handle to Calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1);
zoom on;
equation = get(handles.equation,'String');
x0 = get(handles.X0,'String');
xx0 = str2double(x0);
x1 = get(handles.X1,'String');
xx1 = str2double(x1);
m = get(handles.maxI,'String');
max = str2double(m);
e = get(handles.epsilonE,'String');
error = str2double(e);
v = get(handles.methods, 'Val');
global arr itr;
if isempty(x0) || isempty(equation)
   fprintf('Error: Enter Text first\n');
else
    % Need To Check if xx 1 empty or not-----------------------------------
   if isempty(m)
       max = 50;
   end
   if isempty(e)
       error = 0.00001;
   end
   set(handles.NP,'Visible','On');
   set(handles.RT,'Visible','On');
   set(handles.table,'Visible','On');
   axes(handles.axes1);
   switch v
    case 2
        %Bisection
    case 3
      %False Postion
      False_Postion(xx0,xx1,max,error,equation,handles);
    case 4
        %Fixed Point
    case 5
        %Newton Raphson
        Newton(xx0, equation, max, error, handles);
    case 6
      %Secant
      Secant(xx0,xx1,equation,max,error,handles);
    case 7
        %Bierge Vieta
    case 8
        %All
    otherwise
  end
end
set(handles.X0,'String','');
set(handles.X1,'String','');
set(handles.maxI,'String','');
set(handles.epsilonE,'String','');
arr = get(handles.table, 'Data');
itr = 0;



function equation_Callback(hObject, eventdata, handles)
% hObject    handle to equation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of equation as text
%        str2double(get(hObject,'String')) returns contents of equation as a double


% --- Executes during object creation, after setting all properties.
function equation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to equation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function X0_Callback(hObject, eventdata, handles)
% hObject    handle to X0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X0 as text
%        str2double(get(hObject,'String')) returns contents of X0 as a double


% --- Executes during object creation, after setting all properties.
function X0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function X1_Callback(hObject, eventdata, handles)
% hObject    handle to X1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X1 as text
%        str2double(get(hObject,'String')) returns contents of X1 as a double


% --- Executes during object creation, after setting all properties.
function X1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object deletion, before destroying properties.
function methods_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to methods (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function maxI_Callback(hObject, eventdata, handles)
% hObject    handle to maxI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxI as text
%        str2double(get(hObject,'String')) returns contents of maxI as a double


% --- Executes during object creation, after setting all properties.
function maxI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function epsilonE_Callback(hObject, eventdata, handles)
% hObject    handle to epsilonE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of epsilonE as text
%        str2double(get(hObject,'String')) returns contents of epsilonE as a double


% --- Executes during object creation, after setting all properties.
function epsilonE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epsilonE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
