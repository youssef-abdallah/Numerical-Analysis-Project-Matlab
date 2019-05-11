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

% Last Modified by GUIDE v2.5 09-May-2019 23:16:34

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
global mode;
mode = 0;
set(handles.table,'ColumnName', {'', '', '', '', ''});

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
global v allarr;
allarr = [];
cla(handles.axes1);
set(handles.table,'Visible', 'Off');
set(handles.NP,'Visible', 'Off');
set(handles.RT,'Visible', 'Off');
set(handles.iteration,'String','');
switch contents
    case 1
        %Empty
        set(handles.methods, 'Val', 1);
        clearAll(handles);
        set(handles.Info,'Visible','Off');
        set(handles.NP,'Visible','Off');
        set(handles.PNright,'Visible','Off');
        set(handles.AxesRight, 'Visible' , 'Off');
        set(handles.AxesLeft, 'Visible' , 'Off');
        set(handles.RT,'Visible','Off');
        set(handles.open, 'Visible' , 'Off');
    case 2
        %Bisection
        set(handles.methods, 'Val', 2);
        set(handles.table,'ColumnName', {'Xl', 'Xu', 'Xr', 'F(Xr)', 'Ea'});
        set(handles.xx0,'String','Xl');
        set(handles.xx1,'String','Xu');
        set(handles.open, 'Visible' , 'Off');
        clearAll(handles);
    case 3
        %False Postion
        set(handles.methods, 'Val', 3);
        set(handles.table,'ColumnName', {'Xl', 'Xu', 'Xr', 'F(Xr)', 'Ea'});
        set(handles.xx0,'String','Xl');
        set(handles.xx1,'String','Xu');
        set(handles.open, 'Visible' , 'Off');
        clearAll(handles);
    case 4
        %Fixed Point
        set(handles.methods, 'Val', 4);
        set(handles.table,'ColumnName', {'Xi', 'F(Xi)', 'Xi+1', 'F(Xi+1)', 'Ea'});
        set(handles.xx0,'String','X0');
        clearAll(handles);
        set(handles.X1,'Visible','Off');
        set(handles.xx1,'Visible','Off');
        set(handles.open, 'Visible' , 'Off');
    case 5
        %Newton Raphson
        set(handles.methods, 'Val', 5);
        set(handles.table,'ColumnName', {'Xi', 'F(Xi)', 'Xi+1', 'F(Xi+1)', 'Ea'});
        set(handles.xx0,'String','X0');
        clearAll(handles);
        set(handles.X1,'Visible','Off');
        set(handles.xx1,'Visible','Off');
        set(handles.open, 'Visible' , 'Off');
    case 6
        %Secant
        set(handles.methods, 'Val', 6);
        set(handles.table,'ColumnName', {'Xi-1', 'Xi', 'Xi+1', 'F(Xi+1)', 'Ea'});
        set(handles.xx0,'String','Xi-1');
        set(handles.xx1,'String','Xi');
        set(handles.open, 'Visible' , 'Off');
        clearAll(handles);
    case 7
        %Bierge Vieta
        set(handles.methods, 'Val', 7);
        set(handles.table,'ColumnName', {'A', 'B', 'C', 'Xi+1', 'Ea'});
        clearAll(handles);
        set(handles.xx0,'String','X0');
        set(handles.X1,'Visible','Off');
        set(handles.xx1,'Visible','Off');
        set(handles.open, 'Visible' , 'Off');
    case 8
        %All
        v = 1;
        set(handles.methods, 'Val', 8);
        set(handles.PNright,'Visible','On');
        set(handles.AxesRight, 'Visible' , 'Off');
        set(handles.AxesLeft, 'Visible' , 'Off');
        set(handles.Calculate, 'Visible' , 'Off');
        set(handles.open, 'Visible' , 'Off');
        Change(v, handles);
    case 9
        % General Method
        set(handles.methods, 'Val', 9);
        set(handles.table,'ColumnName', {'A', 'B', 'C', 'M', 'Ea'});
        clearAll(handles);
        set(handles.X0,'Visible','Off');
        set(handles.xx0,'Visible','Off');
        set(handles.X1,'Visible','Off');
        set(handles.xx1,'Visible','Off');
        set(handles.open, 'Visible' , 'Off');
    otherwise
end 



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
global itr arr h1 h2 h3 h4 diff i equ;
v = get(handles.methods, 'Val');
s = size(arr,1);
if ishandle(h1)
    delete(h1);
end
if ishandle(h2)
    delete(h2);
end
if ishandle(h3)
    delete(h3);
end
if ishandle(h4)
    delete(h4);
end
switch v
    case 2
        %Bisection
        if (itr + 1) < (max(s)+1)
           itr = itr + 1;
           i = i + 1;
        end
        xx = arr{itr,1};
        yy = -10:10;
        h1 = plot(xx*ones(size(yy)),yy, 'k');
        xx = arr{itr,2};
        h2 = plot(xx*ones(size(yy)),yy, 'k');
        xx = arr{itr,3};
        h3 = plot(xx*ones(size(yy)),yy, '--m');
    case 3
      %False Postion
        if (itr + 1) < (max(s)+1)
           itr = itr + 1;
           i = i + 1;
        end
        xx = arr{itr,1};
        yy = -10:10;
        h1 = plot(xx*ones(size(yy)),yy, 'k');
        xx = arr{itr,2};
        h2 = plot(xx*ones(size(yy)),yy, 'k');
        xx = arr{itr,3};
        h4 = plot(xx*ones(size(yy)),yy, '--m');
        xx = [equ(arr{itr,1}) equ(arr{itr,2})];
        h3 = plot([arr{itr,1} arr{itr,2}], xx, 'g');
    case 4
        %Fixed Point
        if (itr + 1) < (max(s)+1)
           itr = itr + 1;
           i = i + 1;
        end
        xx = [arr{itr,1} arr{itr,2}];
        yy = [arr{itr,1} arr{itr,1}];
        h1 = plot(yy,xx, 'k');
        xx = [arr{itr,1} arr{itr,3}];
        yy = [arr{itr,2} arr{itr,2}];
        h2 = plot(xx,yy, 'k');
        xx = arr{itr,3};
        yy = -10:10;
        h3 = plot(xx*ones(size(yy)),yy, '--m');
    case 5
        %Newton Raphson
        if (itr + 1) < (max(s)+1)
           itr = itr + 1;
           i = i + 1;
        end
        xx = [arr{itr,1} arr{itr,1}];
        yy = [0 arr{itr,2}];
        h1 = plot(xx, yy, 'k');
        xx = [arr{itr,1} arr{itr,3}];
        yy = [arr{itr,2} 0];
        h2 = plot(xx, yy, 'k');
        xx = arr{itr,3};
        yy = -10:10;
        h3 = plot(xx*ones(size(yy)),yy, '--m');
    case 6
      %Secant
        if (itr + 1) < (max(s)+1)
           itr = itr + 1;
           i = i + 1;
        end
        xx = arr{itr,1};
        yy = -10:10;
        h1 = plot(xx*ones(size(yy)),yy, 'k');
        xx = arr{itr,2};
        h2 = plot(xx*ones(size(yy)),yy, 'k');
        xx = [arr{itr,2} arr{itr,3}];
        yy = [equ(arr{itr,2}) 0];
        h3 = plot(xx,yy, 'g');
        xx = arr{itr,3};
        yy = -10:10;
        h4 = plot(xx*ones(size(yy)),yy, '--m');
    case 7
        %Bierge Vieta
        if (itr + diff) < (max(s)+1)
           itr = itr + diff + 1;
           i = i + 1;
        end
        xx = [arr{(itr - diff - 1),4} arr{(itr - diff - 1),4}];
        yy = [0 arr{(itr - 1),2}];
        h1 = plot(xx, yy, 'k');
        xx = [arr{(itr - diff - 1),4} arr{itr,4}];
        yy = [arr{(itr - 1),2} 0];
        h2 = plot(xx, yy, 'k');
        xx = arr{itr,4};
        yy = -10:10;
        h3 = plot(xx*ones(size(yy)),yy, '--m');
    case 9
        %General
        if (itr + 1) < (max(s)+1)
           itr = itr + 1;
           i = i + 1;
        end
        xx = arr{itr,1};
        yy = -10:10;
        h1 = plot(xx*ones(size(yy)),yy, 'k');
        xx = arr{itr,3};
        yy = -10:10;
        h2 = plot(xx*ones(size(yy)),yy, 'k');
        xx = arr{itr,2};
        yy = -10:10;
        h3 = plot(xx*ones(size(yy)),yy, 'g');
        xx = arr{itr,4};
        yy = -10:10;
        h4 = plot(xx*ones(size(yy)),yy, '-- m');
    otherwise     
end
str = strcat('Num # ', int2str(i));
set(handles.iteration, 'String' , str);
% --- Executes on button press in Previous.
function Previous_Callback(hObject, eventdata, handles)
% hObject    handle to Previous (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global itr arr h1 h2 h3 h4 diff i equ;
v = get(handles.methods, 'Val');
if ishandle(h1)
    delete(h1);
end
if ishandle(h2)
    delete(h2);
end
if ishandle(h3)
    delete(h3);
end
if ishandle(h4)
    delete(h4);
end
switch v
    case 2
        %Bisection
        if (itr - 1) >= 1
            itr = itr - 1;
            i = i - 1;
        end
        xx = arr{itr,1};
        yy = -10:10;
        h1 = plot(xx*ones(size(yy)),yy, 'k');
        xx = arr{itr,2};
        h2 = plot(xx*ones(size(yy)),yy, 'k');
        xx = arr{itr,3};
        h3 = plot(xx*ones(size(yy)),yy, '--m');
    case 3
      %False Postion
        if (itr - 1) >= 1
            itr = itr - 1;
            i = i - 1;
        end
        xx = arr{itr,1};
        yy = -10:10;
        h1 = plot(xx*ones(size(yy)),yy, 'k');
        xx = arr{itr,2};
        h2 = plot(xx*ones(size(yy)),yy, 'k');
        xx = arr{itr,3};
        h4 = plot(xx*ones(size(yy)),yy, '--m');
        xx = [equ(arr{itr,1}) equ(arr{itr,2})];
        h3 = plot([arr{itr,1} arr{itr,2}], xx, 'g');
    case 4
        %Fixed Point
        if (itr - 1) >= 1
            itr = itr - 1;
            i = i - 1;
        end
        xx = [arr{itr,1} arr{itr,2}];
        yy = [arr{itr,1} arr{itr,1}];
        h1 = plot(yy,xx, 'k');
        xx = [arr{itr,1} arr{itr,3}];
        yy = [arr{itr,2} arr{itr,2}];
        h2 = plot(xx,yy, 'k');
        xx = arr{itr,3};
        yy = -10:10;
        h3 = plot(xx*ones(size(yy)),yy, '--m');
    case 5
        %Newton Raphson
        if (itr - 1) >= 1
            itr = itr - 1;
            i = i - 1;
        end
        xx = [arr{itr,1} arr{itr,1}];
        yy = [0 arr{itr,2}];
        h1 = plot(xx, yy, 'k');
        xx = [arr{itr,1} arr{itr,3}];
        yy = [arr{itr,2} 0];
        h2 = plot(xx, yy, 'k');
        xx = arr{itr,3};
        yy = -10:10;
        h3 = plot(xx*ones(size(yy)),yy, '--m');
    case 6
      %Secant
        if (itr - 1) >= 1
            itr = itr - 1;
            i = i - 1;
        end
        xx = arr{itr,1};
        yy = -10:10;
        h1 = plot(xx*ones(size(yy)),yy, 'k');
        xx = arr{itr,2};
        h2 = plot(xx*ones(size(yy)),yy, 'k');
        xx = [arr{itr,2} arr{itr,3}];
        yy = [equ(arr{itr,2}) 0];
        h3 = plot(xx,yy, 'g');
        xx = arr{itr,3};
        yy = -10:10;
        h4 = plot(xx*ones(size(yy)),yy, '--m');
    case 7
        %Bierge Vieta
        if (itr - diff - 1) > 1
           itr = itr - diff - 1;
           i = i - 1;
        end
        xx = [arr{(itr - diff - 1),4} arr{(itr - diff - 1),4}];
        yy = [0 arr{(itr - 1),2}];
        h1 = plot(xx, yy, 'k');
        xx = [arr{(itr - diff - 1),4} arr{itr,4}];
        yy = [arr{(itr - 1),2} 0];
        h2 = plot(xx, yy, 'k');
        xx = arr{itr,4};
        yy = -10:10;
        h3 = plot(xx*ones(size(yy)),yy, '--m');
    case 9
        %General
        if (itr - 1) >= 1
            itr = itr - 1;
            i = i - 1;
        end
        xx = arr{itr,1};
        yy = -10:10;
        h1 = plot(xx*ones(size(yy)),yy, 'k');
        xx = arr{itr,3};
        yy = -10:10;
        h2 = plot(xx*ones(size(yy)),yy, 'k');
        xx = arr{itr,2};
        yy = -10:10;
        h3 = plot(xx*ones(size(yy)),yy, 'g');
        xx = arr{itr,4};
        yy = -10:10;
        h4 = plot(xx*ones(size(yy)),yy, '-- m');
    otherwise
end
str = strcat('Num # ', int2str(i));
set(handles.iteration, 'String' , str);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mode;
if mode == 0
    pan on;
    zoom off;
    mode = 1;
else if mode == 1
        zoom on;
        pan off;
        mode = 0;
    end
end

% --- Executes on button press in Calculate.
function Calculate_Callback(hObject, eventdata, handles)
% hObject    handle to Calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1);
zoom on;
global arr itr diff i allarr equation xx0 xx1 Max error equ;
set(handles.extra, 'String','');
set(handles.extraInfo, 'String', '');
v = get(handles.methods, 'Val');
equation = get(handles.equation,'String');
equations = strcat('@(x)',equation);
equ = str2func(equations);
x0 = get(handles.X0,'String');
m = get(handles.maxI,'String');
e = get(handles.epsilonE,'String');
if v ~= 8
    x0 = get(handles.X0,'String');
    xx0 = str2double(x0);
    x1 = get(handles.X1,'String');
    xx1 = str2double(x1);
    m = get(handles.maxI,'String');
    Max = str2double(m);
    e = get(handles.epsilonE,'String');
    error = str2double(e);
else
    getxs(1);
end
if (isempty(x0) && v ~= 8 && v~= 9) || isempty(equation)
   fprintf('Error: Enter Text first\n');
else
   if isempty(m) && v ~= 8
       Max = 50;
   end
   if isempty(e) && v ~= 8
       error = 0.00001;
   end
   set(handles.NP,'Visible','On');
   set(handles.RT,'Visible','On');
   set(handles.table,'Visible','On');
   axes(handles.axes1);
   itr = 0;
   switch v
    case 2
        %Bisection
        Bisection(xx0,xx1,Max,error,equation,handles);
    case 3
      %False Postion
      False_Postion(xx0,xx1,Max,error,equation,handles);
    case 4
        %Fixed Point
        Fixed_Point(xx0,Max,error,equation,handles);
    case 5
         %Newton Raphson
         Newton(xx0, equation, Max, error, handles);
    case 6
         %Secant
         Secant(xx0,xx1,equation,Max,error,handles);
    case 7
        %Bierge Vieta
        [diff,~] = birgeVieta(equation, xx0, Max, error, handles);
        itr = 1;
    case 8
        %All
        % Will start with bisection
        set(handles.open, 'Visible' , 'On');
        set(handles.type, 'String' , 'Bisection');
        set(handles.methods, 'Val' , 2);
        Bisection(allarr{1,1},allarr{1,2},allarr{1,3},allarr{1,4},equation,handles);
        set(handles.AxesRight, 'Visible' , 'On');
        set(handles.AxesLeft, 'Visible' , 'On');
    case 9
        %General
        decker(equation,error,Max,handles);
    otherwise
  end
end
set(handles.X0,'String','');
set(handles.X1,'String','');
set(handles.maxI,'String','');
set(handles.pushbutton11,'Visible' , 'On');
set(handles.epsilonE,'String','');
arr = get(handles.table, 'Data');
i = 0;



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


% --- Executes on button press in ReadFile.
function ReadFile_Callback(hObject, eventdata, handles)
% hObject    handle to ReadFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uigetfile('*.txt');
if isequal(file,0)
   disp('User selected Cancel');
else
    filetext = fileread(fullfile(path,file));
    C = strsplit(filetext,'\n');
    str = strtrim(C{1,1});
    str = editEquation(str);
    set(handles.equation, 'String', str);
    str = strtrim(C{1,2});
   switch str
       case 'bisection'
           set(handles.methods, 'Val' , 2);
           set(handles.table,'ColumnName', {'Xl', 'Xu', 'Xr', 'F(Xr)', 'Ea'});
       case 'false postion'
           set(handles.methods, 'Val' , 3);
           set(handles.table,'ColumnName', {'Xi', 'F(Xi)', 'Xi+1', 'F(Xi+1)', 'Ea'});
       case 'fixed point'
           set(handles.methods, 'Val' , 4);
           set(handles.table,'ColumnName', {'Xi', 'F(Xi)', 'Xi+1', 'F(Xi+1)', 'Ea'});
       case 'newton raphson'
           set(handles.methods, 'Val' , 5);
           set(handles.table,'ColumnName', {'Xi', 'F(Xi)', 'Xi+1', 'F(Xi+1)', 'Ea'});
       case 'secant'
           set(handles.methods, 'Val' , 6);
           set(handles.table,'ColumnName', {'Xi-1', 'Xi', 'Xi+1', 'F(Xi+1)', 'Ea'});
       case 'bierge vieta'
           set(handles.methods, 'Val' , 7);
           set(handles.table,'ColumnName', {'A', 'B', 'C', 'Xi+1', 'Ea'});
       otherwise
   end
   str = strtrim(C{1,3});
   splitt = strsplit(str);
   if max(size(splitt)) == 1
       set(handles.X0, 'string' , splitt(1));
   else
       set(handles.X0, 'string' , splitt(1));
       set(handles.X1, 'string' , splitt(2));
   end
   str = strtrim(C{1,4});
   c = str2double(str);
   if (floor(c) == c)
       set(handles.maxI, 'String' , str);
   else
       set(handles.epsilonE, 'String' , str);
   end
   set(handles.Info,'Visible','Off');
   Calculate_Callback(hObject, eventdata, handles);
end


% --- Executes on button press in PNright.
function PNright_Callback(hObject, eventdata, handles)
% hObject    handle to PNright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global v allarr;
v = v + 1;
Change(v ,handles);
if v  == 7
    set(handles.PNright,'Visible','Off');
    set(handles.Calculate, 'Visible' , 'On');
end
x0 = get(handles.X0,'String');
xx0 = str2double(x0);
x1 = get(handles.X1,'String');
xx1 = str2double(x1);
m = get(handles.maxI,'String');
max = str2double(m);
e = get(handles.epsilonE,'String');
error = str2double(e);
if isempty(x0)
   fprintf('Error: Enter Text first\n');
else
   if isempty(m)
       max = 50;
   end
   if isempty(e)
       error = 0.00001;
   end
end
row = {xx0, xx1, max, error};
allarr = [allarr; row];



% --- Executes on button press in AxesRight.
function AxesRight_Callback(hObject, eventdata, handles)
% hObject    handle to AxesRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global v diff itr allarr equation i arr;
set(handles.extra, 'String','');
set(handles.extraInfo, 'String', '');
cla(handles.axes1);
v = mod((v + 1) , 6);
i = 0;
itr = 0;
set(handles.iteration, 'String' , '');
switch v
    case 1
        %Bisection
        set(handles.methods, 'Val' , 2);
        set(handles.type, 'String' , 'Bisection');
        Bisection(allarr{1,1},allarr{1,2},allarr{1,3},allarr{1,4},equation,handles);
        getxs(1);
         set(handles.table,'ColumnName', {'Xl', 'Xu', 'Xr', 'F(Xr)', 'Ea'});
    case 2
      %False Postion
      set(handles.methods, 'Val' , 3);
      set(handles.type, 'String' , 'False_Postion');
      False_Postion(allarr{1,1},allarr{2,2},allarr{2,3},allarr{2,4},equation,handles);
      getxs(2);
      set(handles.table,'ColumnName', {'Xi', 'F(Xi)', 'Xi+1', 'F(Xi+1)', 'Ea'});
    case 3
        %Fixed Point
        set(handles.methods, 'Val' , 4);
        set(handles.type, 'String' , 'Fixed_Point');
        getxs(3);
        Fixed_Point(allarr{3,1},allarr{3,3},allarr{3,4},equation,handles);
        set(handles.table,'ColumnName', {'Xi', 'F(Xi)', 'Xi+1', 'F(Xi+1)', 'Ea'});
    case 4
        %Newton Raphson
        getxs(4);
        set(handles.methods, 'Val' , 5);
        set(handles.type, 'String' , 'Newton_Raphson');
        Newton(allarr{4,1}, equation, allarr{4,3},allarr{4,4}, handles);
        set(handles.table,'ColumnName', {'Xi', 'F(Xi)', 'Xi+1', 'F(Xi+1)', 'Ea'});
    case 5
      %Secant
      getxs(5);
      set(handles.methods, 'Val' , 6);
      set(handles.type, 'String' , 'Secant');
      Secant(allarr{5,1},allarr{5,2},equation,allarr{5,3},allarr{5,4},handles);
      set(handles.table,'ColumnName', {'Xi-1', 'Xi', 'Xi+1', 'F(Xi+1)', 'Ea'});
    case 0
        %Bierge Vieta
        getxs(6);
        set(handles.methods, 'Val' , 7);
        set(handles.type, 'String' , 'Bierge_Vieta');
        diff = birgeVieta(equation, allarr{6,1}, allarr{6,3},allarr{6,4}, handles);
        set(handles.table,'ColumnName', {'A', 'B', 'C', 'Xi+1', 'Ea'});
        itr = 1;
    otherwise
end
arr = get(handles.table,'Data');

        


% --- Executes on button press in AxesLeft.
function AxesLeft_Callback(hObject, eventdata, handles)
% hObject    handle to AxesLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global v diff itr allarr equation i arr;
cla(handles.axes1);
set(handles.extra, 'String','');
set(handles.extraInfo, 'String', '');
v = mod((v - 1) , 6);
set(handles.iteration, 'String' , '');
i = 0;
itr = 0;
switch v
    case 1
        %Bisection
        getxs(1);
        set(handles.methods, 'Val' , 2);
        set(handles.type, 'String' , 'Bisection');
        Bisection(allarr{1,1},allarr{1,2},allarr{1,3},allarr{1,4},equation,handles);
         set(handles.table,'ColumnName', {'Xl', 'Xu', 'Xr', 'F(Xr)', 'Ea'});
    case 2
      %False Postion
      getxs(2);
      set(handles.methods, 'Val' , 3);
      set(handles.type, 'String' , 'False_Postion');
      False_Postion(allarr{2,1},allarr{2,2},allarr{2,3},allarr{2,4},equation,handles);
      set(handles.table,'ColumnName', {'Xi', 'F(Xi)', 'Xi+1', 'F(Xi+1)', 'Ea'});
    case 3
        %Fixed Point
        getxs(3);
        set(handles.methods, 'Val' , 4);
        set(handles.type, 'String' , 'Fixed_Point');
        Fixed_Point(allarr{3,1},allarr{3,3},allarr{3,4},equation,handles);
        set(handles.table,'ColumnName', {'Xi', 'F(Xi)', 'Xi+1', 'F(Xi+1)', 'Ea'});
    case 4
        %Newton Raphson
        getxs(4);
        set(handles.methods, 'Val' , 5);
        set(handles.type, 'String' , 'Newton_Raphson');
        Newton(allarr{4,1}, equation, allarr{4,3},allarr{4,4}, handles);
        set(handles.table,'ColumnName', {'Xi', 'F(Xi)', 'Xi+1', 'F(Xi+1)', 'Ea'});
    case 5
      %Secant
      getxs(5);
      set(handles.methods, 'Val' , 6);
      set(handles.type, 'String' , 'Secant');
      Secant(allarr{5,1},allarr{5,2},equation,allarr{5,3},allarr{5,4},handles);
      set(handles.table,'ColumnName', {'Xi-1', 'Xi', 'Xi+1', 'F(Xi+1)', 'Ea'});
    case 0
        %Bierge Vieta
        getxs(6);
        set(handles.methods, 'Val' , 7);
        set(handles.type, 'String' , 'Bierge_Vieta');
        diff = birgeVieta(equation, allarr{6,1}, allarr{6,3},allarr{6,4}, handles);
        set(handles.table,'ColumnName', {'A', 'B', 'C', 'Xi+1', 'Ea'});
        itr = 1;
    otherwise
end
arr = get(handles.table,'Data');

function Change(v , handles)
switch v
    case 1
        %Bisection
        set(handles.Info, 'Title', 'Bisection');
        set(handles.X0,'Visible','On');
        set(handles.xx0,'Visible','On');
        set(handles.xx0,'String','Xl');
        set(handles.xx1,'String','Xu');
        set(handles.Info,'Visible','On');
        set(handles.X1,'Visible','On');
        set(handles.xx1,'Visible','On');
    case 2
        %False Postion
        set(handles.Info, 'Title', 'False_Postion');
        set(handles.xx0,'String','Xl');
        set(handles.xx1,'String','Xu');
        set(handles.Info,'Visible','On');
        set(handles.X1,'Visible','On');
        set(handles.xx1,'Visible','On');
    case 3
        %Fixed Point
        set(handles.Info, 'Title', 'Fixed_Point');
        set(handles.xx0,'String','X0');
        set(handles.Info,'Visible','On');
        set(handles.X1,'Visible','Off');
        set(handles.xx1,'Visible','Off');
    case 4
        %Newton Raphson
        set(handles.Info, 'Title', 'Newton_Raphson');
        set(handles.xx0,'String','X0');
        set(handles.Info,'Visible','On');
        set(handles.X1,'Visible','Off');
        set(handles.xx1,'Visible','Off');
    case 5
        %Secant
        set(handles.Info, 'Title', 'Secant');
        set(handles.xx0,'String','Xi-1');
        set(handles.xx1,'String','Xi');
        set(handles.Info,'Visible','On');
        set(handles.X1,'Visible','On');
        set(handles.xx1,'Visible','On');
    case 6
        %Bierge Vieta
        set(handles.Info, 'Title', 'Bierge_Vieta');
        set(handles.xx0,'String','X0');
        set(handles.Info,'Visible','On');
        set(handles.X1,'Visible','Off');
        set(handles.xx1,'Visible','Off');
    otherwise
end 

function clearAll(handles)
    set(handles.Info,'Title','');
    set(handles.type,'String','');
    set(handles.X0,'Visible','On');
    set(handles.xx0,'Visible','On');
    set(handles.Calculate,'Visible','On');
    set(handles.Info,'Visible','On');
    set(handles.PNright,'Visible','Off');
    set(handles.AxesRight, 'Visible' , 'Off');
    set(handles.AxesLeft, 'Visible' , 'Off');
    set(handles.X1,'Visible','On');
    set(handles.xx1,'Visible','On');
    set(handles.pushbutton11,'Visible' , 'Off');


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global equation xx0 xx1 Max error arr;
v = get(handles.methods, 'Val');
fileID = fopen('ResultP1.txt','w');
fprintf(fileID,'Equation : %s\r\n',equation);
switch v
    case 2
        fprintf(fileID,'Method : %s\r\n','Bisection');
    case 3
        fprintf(fileID,'Method : %s\r\n','False_Postion');
    case 4
        fprintf(fileID,'Method : %s\r\n','Fixed_Point');
    case 5
        fprintf(fileID,'Method : %s\r\n','Newton_Raphson');
    case 6
        fprintf(fileID,'Method : %s\r\n','Secant');
    case 7
        fprintf(fileID,'Method : %s\r\n','Bierge_Vieta');
    case 9
        fprintf(fileID,'Method : %s\r\n','General_Method');
    otherwise
end
if v ~= 9
    fprintf(fileID,'First Point : %d\r\n',xx0);
    if (v == 2 || v == 3 || v == 6)
        fprintf(fileID,'Second Point : %d\r\n',xx1);
    end
end
fprintf(fileID,'Max Iteration : %d\r\n',Max);
fprintf(fileID,'Epsilon : %d\r\n',error);
fprintf(fileID,'\r\n\r\n');
[r,~] = size(arr);
switch v
    case 2
        fprintf(fileID,'%4s %22s %22s %22s %22s %22s\r\n','I','Xl','Xu','Xr','F(Xr)','Ea');
        fprintf(fileID,'%4s %22s %22s %22s %22s %22s\r\n','-','--','--','--','-----','--');
        fprintf(fileID,'\r\n');
        for i = 1 : r
            fprintf(fileID,'%4d %22.10d %22.10d %22.10d %22.10d %22.10d\r\n',i,arr{i,1},arr{i,2},arr{i,3},arr{i,4},arr{i,5});
        end
    case 3
        fprintf(fileID,'%4s %22s %22s %22s %22s %22s\r\n','I','Xl','Xu','Xr','F(Xr)','Ea');
        fprintf(fileID,'%4s %22s %22s %22s %22s %22s\r\n','-','--','--','--','-----','--');
        fprintf(fileID,'\r\n');
        for i = 1 : r
            fprintf(fileID,'%4d %22.10d %22.10d %22.10d %22.10d %22.10d\r\n',i,arr{i,1},arr{i,2},arr{i,3},arr{i,4},arr{i,5});
        end
    case 4
        fprintf(fileID,'%4s %22s %22s %22s %22s %22s\r\n','I','Xi','F(Xi)','Xi+1','F(Xi+1)','Ea');
        fprintf(fileID,'%4s %22s %22s %22s %22s %22s\r\n','-','--','-----','----','-------','--');
        fprintf(fileID,'\r\n');
        for i = 1 : r
            fprintf(fileID,'%4d %22.10d %22.10d %22.10d %22.10d %22.10d\r\n',i,arr{i,1},arr{i,2},arr{i,3},arr{i,4},arr{i,5});
        end
    case 5
        fprintf(fileID,'%4s %22s %22s %22s %22s %22s\r\n','I','Xi','F(Xi)','Xi+1','F(Xi+1)','Ea');
        fprintf(fileID,'%4s %22s %22s %22s %22s %22s\r\n','-','--','-----','----','-------','--');
        fprintf(fileID,'\r\n');
        for i = 1 : r
            fprintf(fileID,'%4d %22.10d %22.10d %22.10d %22.10d %22.10d\r\n',i,arr{i,1},arr{i,2},arr{i,3},arr{i,4},arr{i,5});
        end
    case 6
        fprintf(fileID,'%4s %22s %22s %22s %22s %22s\r\n','I','Xi-1','Xi','Xi+1','F(Xi+1)','Ea');
        fprintf(fileID,'%4s %22s %22s %22s %22s %22s\r\n','-','----','--','----','-------','--');
        fprintf(fileID,'\r\n');
        for i = 1 : r
            fprintf(fileID,'%4d %22.10d %22.10d %22.10d %22.10d %22.10d\r\n',i,arr{i,1},arr{i,2},arr{i,3},arr{i,4},arr{i,5});
        end
    case 7
        fprintf(fileID,'%4s %22s %22s %22s %22s %22s\r\n','I','A','B','C','Xi+1','Ea');
        fprintf(fileID,'%4s %22s %22s %22s %22s %22s\r\n','-','-','-','-','----','--');
        fprintf(fileID,'\r\n');
        j = 1;
        for i = 1 : r
            if (arr{i,1} ~= '-')
                fprintf(fileID,'%4s %22.10d %22.10d %22.10d %22.10s %22.10s\r\n','-',arr{i,1},arr{i,2},arr{i,3},arr{i,4},arr{i,5});
            else
                if i == 1
                    fprintf(fileID,'%4d %22s %22s %22s %22.10d %22s\r\n',j,arr{i,1},arr{i,2},arr{i,3},arr{i,4},arr{i,5});
                else
                    fprintf(fileID,'%4d %22s %22s %22s %22.10d %22.10d\r\n',j,arr{i,1},arr{i,2},arr{i,3},arr{i,4},arr{i,5});
                end
                j = j + 1;
            end
        end
      case 9
        fprintf(fileID,'%4s %22s %22s %22s %22s %22s\r\n','I','A','B','C','M','Ea');
        fprintf(fileID,'%4s %22s %22s %22s %22s %22s\r\n','-','-','-','-','-','--');
        fprintf(fileID,'\r\n');
        for i = 1 : r
            fprintf(fileID,'%4d %22.10d %22.10d %22.10d %22.10d %22.10d\r\n',i,arr{i,1},arr{i,2},arr{i,3},arr{i,4},arr{i,5});
        end
    otherwise
end


% --- Executes on button press in open.
function open_Callback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
G2P1();

function getxs(i)
global xx0 xx1 Max Error allarr;
xx0 = allarr{i,1};
xx1 = allarr{i,2};
Max = allarr{i,3};
Error = allarr{i,4};
    


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
run('Main');
