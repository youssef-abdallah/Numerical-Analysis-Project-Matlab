function varargout = G2P1(varargin)
% G2P1 MATLAB code for G2P1.fig
%      G2P1, by itself, creates a new G2P1 or raises the existing
%      singleton*.
%
%      H = G2P1 returns the handle to a new G2P1 or the handle to
%      the existing singleton*.
%
%      G2P1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in G2P1.M with the given input arguments.
%
%      G2P1('Property','Value',...) creates a new G2P1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before G2P1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to G2P1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help G2P1

% Last Modified by GUIDE v2.5 06-May-2019 17:19:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @G2P1_OpeningFcn, ...
                   'gui_OutputFcn',  @G2P1_OutputFcn, ...
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


% --- Executes just before G2P1 is made visible.
function G2P1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to G2P1 (see VARARGIN)

% Choose default command line output for G2P1
handles.output = hObject;
global equation allarr;
axes(handles.Axes);
er1 = Bisection(allarr{1,1},allarr{1,2},allarr{1,3},allarr{1,4},equation,handles);
er2 = False_Postion(allarr{2,1},allarr{2,2},allarr{2,3},allarr{2,4},equation,handles);
[er3,~] = Fixed_Point(allarr{3,1},allarr{3,3},allarr{3,4},equation,handles);
er4 = Newton(allarr{4,1}, equation, allarr{4,3},allarr{4,4}, handles);
er5 = Secant(allarr{5,1},allarr{5,2},equation,allarr{5,3},allarr{5,4},handles);
[~,er6] = birgeVieta(equation, allarr{6,1}, allarr{6,3},allarr{6,4}, handles);
cla(handles.Axes);
reset(handles.Axes);
zoom on;
hold on;
[~,m] = size(er1);
for i = 2 : m
    if (er1(i) > 10)
        break;
    end
    plot([i (i-1)],[er1(i) er1(i-1)],'-o g');
end
[~,m] = size(er2);
for i = 2 : m
    if (er2(i) > 10)
        break;
    end
    plot([i (i-1)],[er2(i) er2(i-1)],'-o b');
end
[~,m] = size(er3);
for i = 2 : m
    if (er3(i) > 10)
        break;
    end
    plot([i (i-1)],[er3(i) er3(i-1)],'-o r');
end
[~,m] = size(er4);
for i = 2 : m
    if (er4(i) > 10)
        break;
    end
    plot([i (i-1)],[er4(i) er4(i-1)],'-o c');
end
[~,m] = size(er5);
for i = 2 : m
    if (er5(i) > 10)
        break;
    end
    plot([i (i-1)],[er5(i) er5(i-1)],'-o m');
end
[~,m] = size(er6);
for i = 2 : m
    if (er6(i) > 10)
        break;
    end
    plot([i (i-1)],[er6(i) er6(i-1)],'-o y');
end
% Update handles structure



% UIWAIT makes G2P1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = G2P1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
