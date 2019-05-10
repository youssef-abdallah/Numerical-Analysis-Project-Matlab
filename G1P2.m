function varargout = G1P2(varargin)
% G1P2 MATLAB code for G1P2.fig
%      G1P2, by itself, creates a new G1P2 or raises the existing
%      singleton*.
%
%      H = G1P2 returns the handle to a new G1P2 or the handle to
%      the existing singleton*.
%
%      G1P2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in G1P2.M with the given input arguments.
%
%      G1P2('Property','Value',...) creates a new G1P2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before G1P2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to G1P2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help G1P2

% Last Modified by GUIDE v2.5 09-May-2019 23:17:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @G1P2_OpeningFcn, ...
                   'gui_OutputFcn',  @G1P2_OutputFcn, ...
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


% --- Executes just before G1P2 is made visible.
function G1P2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to G1P2 (see VARARGIN)

% Choose default command line output for G1P2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global coef res num equat ready;
num = 0;
ready = 0;
coef = [];
res = [];
equat = '';

% UIWAIT makes G1P2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = G1P2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on selection change in method.
function method_Callback(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = get(hObject,'Value');
set(handles.PN,'Visible','Off');
set(handles.table,'Visible','Off');
set(handles.Tpane,'Visible','Off');
switch contents
    case 1
        set(handles.method, 'Val', 1);
    case 2
        set(handles.method, 'Val', 2);
    case 3
        set(handles.method, 'Val', 3);
    case 4
        set(handles.method, 'Val', 4);
    case 5
        set(handles.method, 'Val', 5);
        set(handles.PN,'Visible','On');
    otherwise
end

% Hints: contents = cellstr(get(hObject,'String')) returns method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from method


% --- Executes during object creation, after setting all properties.
function method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in read.
function read_Callback(hObject, eventdata, handles)
% hObject    handle to read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uigetfile('*.txt');
if isequal(file,0)
   disp('User selected Cancel');
else
    filetext = fileread(fullfile(path,file));
    C = strsplit(filetext,'\n');
    str = strtrim(C{1,1});
    num = double(str) - 48;
    for i = 1 : num
        str = strtrim(C{1,(i + 1)});
        set(handles.equation,'String',str);
        next_Callback(hObject, eventdata, handles);
    end
    str = strtrim(C{1,(num + 2)});
    switch str
        case 'Gaussian-elimination'
            set(handles.method, 'Val', 2);
        case 'LU decomposition'
            set(handles.method, 'Val', 3);
        case 'Gaussian-Jordan'
            set(handles.method, 'Val', 4);
        case 'Gauss-Seidel'
            str = strtrim(C{1,(num + 3)});
            set(handles.xx,'String',str);
            set(handles.method, 'Val', 5);
        otherwise
    end
    calculate_Callback(hObject, eventdata, handles)
end



% --- Executes on button press in next.
function next_Callback(hObject, eventdata, handles)
% hObject    handle to next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global coef res num equat ready;
syms a b c d e;
equation = get(handles.equation,'String');
if ready == 0
else
    equat = '';
    ready = 0;
end
equat = strcat(equat,'!',equation);
if (isempty(equation))
    return;
end
equ = eval(equation);
[cc, var] = coeffs(equ);
temp = zeros(1,5);
for i = 1 : max(size(var))
    if (var(i) == a)
        temp(1) = double(cc(i));
    else if (var(i) == b)
        temp(2) = double(cc(i));
    else if (var(i) == c)
        temp(3) = double(cc(i));
    else if (var(i) == d)
        temp(4) = double(cc(i));
    else if (var(i) == e)
        temp(5) = double(cc(i));
    else if (var(i) == 1)
        rres = -1 * double(cc(i));
        end
        end
        end
        end
        end
    end
end
coef = [coef; temp];
res = [res rres];
num = num + 1;
set(handles.equation,'String','');

% --- Executes on button press in calculate.
function calculate_Callback(hObject, eventdata, handles)
% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global coef res num x0 ready;
for i = 1 : 5 % number of variable
    adder = 0;
    for j = 1 : num
        if coef(j,i) == 0
            adder = adder + 1;
        end
    end
    if (adder == num)
        break;
    end
end
if (i == 1)
    return;
else
    for k = i : 5
        coef (:,i) = [];
    end
end
v = get(handles.method, 'Val');
set(handles.table,'Visible','On');
set(handles.Tpane,'Visible','On');
set(handles.table,'ColumnName', {'Variable', 'Value'});
switch v
    case 2
        r = Gauss_Elimination(coef,res,num,.00001,handles);
    case 3
        r = LUdecomposition(coef, res,handles);
    case 4
        r = gaussJordan(coef,res,handles);
    case 5
        x0 = get(handles.xx,'String');
        Ix = strsplit(x0);
        if (max(size(Ix)) == num)
            xx0 = zeros(1,num);
            for i = 1 : num
                xx0(1,i) = str2double(Ix{1,i});
            end
        else
            return;
        end
        m = get(handles.MaxI,'String');
        Max = str2double(m);
        e = get(handles.Error,'String');
        Error = str2double(e);
        if isempty(x0)
            return;
        end
        if isempty(m)
            Max = 50;
        end
        if isempty(e)
            Error = 0.00001;
        end
        if (num == 3)
            set(handles.table,'ColumnName', {'A', 'Ea', 'B', 'Eb', 'C', 'Ec'});
        else if (num == 4)
            set(handles.table,'ColumnName', {'A', 'Ea', 'B', 'Eb', 'C', 'Ec', 'D', 'Ed'});
            end
        end
        [r,e] = Gauss_Seidel(coef,res,xx0,Max,Error,handles);
        %set(handles.table2,'Visible','On');
        %set(handles.table,'Visible','Off');
    otherwise
end
if (v ~= 5)
    set(handles.table, 'Data', {});
    for i = 1 : num
        row = {strcat('X',int2str((i))), r(i)};
        oldData = get(handles.table,'Data');
        newData = [oldData; row];
        set(handles.table,'Data',newData);
    end
else
    set(handles.table, 'Data', {});
    [rows,col] = size(r);
    for i = 1 : rows
        row = {};
        for j = 1 : (col*2)
            if (mod(j,2) == 1)
                row{1,j} = r(i,(j+1)/2);
            else
                row{1,j} = e(i,j/2);
            end
        end
        oldData = get(handles.table,'Data');
        newData = [oldData; row];
        set(handles.table,'Data',newData);
    end
    axes(handles.Axes);
    set(handles.Axes,'Visible','On');
    zoom on;
    for i = 1 : rows
        for j = 1 : col
            switch j
                case 1
                    if i == 1
                        plot([i (i-1)],[r(i,j) xx0(1)],'-o g');
                    else
                        plot([i (i-1)],[r(i,j) r((i-1),j)],'-o g');
                    end
                case 2
                    if i == 1
                        plot([i (i-1)],[r(i,j) xx0(2)],'-o b');
                    else
                        plot([i (i-1)],[r(i,j) r((i-1),j)],'-o b');
                    end
                case 3
                    if i == 1
                        plot([i (i-1)],[r(i,j) xx0(3)],'-o r');
                    else
                        plot([i (i-1)],[r(i,j) r((i-1),j)],'-o r');
                    end
                case 4
                    if i == 1
                        plot([i (i-1)],[r(i,j) xx0(4)],'-o c');
                    else
                        plot([i (i-1)],[r(i,j) r((i-1),j)],'-o c');
                    end
                case 5
                    if i == 1
                        plot([i (i-1)],[r(i,j) xx0(5)],'-o m');
                    else
                        plot([i (i-1)],[r(i,j) r((i-1),j)],'-o m');
                    end
                otherwise
            end
            hold on;
        end
    end
end
coef = [];
num = 0;
res = [];
ready = 1;


function num_Callback(hObject, eventdata, handles)
% hObject    handle to num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num as text
%        str2double(get(hObject,'String')) returns contents of num as a double


% --- Executes during object creation, after setting all properties.
function num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xx_Callback(hObject, eventdata, handles)
% hObject    handle to xx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xx as text
%        str2double(get(hObject,'String')) returns contents of xx as a double


% --- Executes during object creation, after setting all properties.
function xx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MaxI_Callback(hObject, eventdata, handles)
% hObject    handle to MaxI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MaxI as text
%        str2double(get(hObject,'String')) returns contents of MaxI as a double


% --- Executes during object creation, after setting all properties.
function MaxI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MaxI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Error_Callback(hObject, eventdata, handles)
% hObject    handle to Error (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Error as text
%        str2double(get(hObject,'String')) returns contents of Error as a double


% --- Executes during object creation, after setting all properties.
function Error_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Error (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% function [coef] = pivot (a)
% [~,rows] = size(a);
% for i = 1 : rows - 1
%     for j = i + 1 : rows
%         if a(i, i) == 0
%             temp = a(1, :);
%             a(1, :) = a(j, :);
%             a(j, :) = temp;
%         end
%     end
% end
% coef = a;


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global equat x0;
equ = strsplit(equat,'!');
arr = get(handles.table,'Data');
[c,w] = size(arr);
v = get(handles.method, 'Val');
fileID = fopen('ResultP2.txt','w');
for i = 2 : max(size(equ))
    fprintf(fileID,'Equation %d : %s\r\n',(i-1),equ{i});
end
switch v
    case 2
        fprintf(fileID,'Method : %s\r\n','Gaussian-elimination');
    case 3
        fprintf(fileID,'Method : %s\r\n','LU decomposition');
    case 4
        fprintf(fileID,'Method : %s\r\n','Gaussian-Jordan');
    case 5
        fprintf(fileID,'Method : %s\r\n','Gauss-Seidel');
    otherwise
end
if v == 5
    fprintf(fileID,'Initial Points : %s\r\n',x0);
    fprintf(fileID,'\r\n\r\n');
    if w == 6
        fprintf(fileID,'%22s %22s %22s %22s %22s %22s\r\n','A','Ea','B','Eb','C','Ec');
        fprintf(fileID,'%22s %22s %22s %22s %22s %22s\r\n','-','--','-','--','-','--');
        fprintf(fileID,'\r\n');
        for i = 1 : c
            fprintf(fileID,'%22d %22d %22d %22d %22d %22d\r\n',arr{i,1},arr{i,2},arr{i,3},arr{i,4},arr{i,5},arr{i,6});
        end
    else if w == 8
        fprintf(fileID,'%22s %22s %22s %22s %22s %22s %22s %22s\r\n','A','Ea','B','Eb','C','Ec','D','Ed');
        fprintf(fileID,'%22s %22s %22s %22s %22s %22s %22s %22s\r\n','-','--','-','--','-','--','-','--');
        fprintf(fileID,'\r\n');
        for i = 1 : c
            fprintf(fileID,'%22d %22d %22d %22d %22d %22d %22d %22d\r\n',arr{i,1},arr{i,2},arr{i,3},arr{i,4},arr{i,5},arr{i,6},arr{i,7},arr{i,8});
        end    
        end
    end
else
    fprintf(fileID,'\r\n\r\n');
    fprintf(fileID,'%22s %22s\r\n','Variable','Value');
    fprintf(fileID,'%22s %22s\r\n','--------','-----');
    fprintf(fileID,'\r\n');
    for i = 1 : c
        fprintf(fileID,'%22s %22d\r\n',arr{i,1},arr{i,2});
    end
end
equat = '';


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
run('Main');