function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 16-Jul-2022 03:53:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;
warning off
delete(timerfind);
handles.ht=timer;
set(handles.ht,'ExecutionMode','fixedRate');
set(handles.ht,'Period',1);
set(handles.ht,'TimerFcn',{@dispnow, handles});
start(handles.ht);

global theta
global phi
global deduceFlag
theta = 0;
phi = 0;
deduceFlag = 0;

global given_foreobj
given_foreobj=false;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function dispnow(hObject, eventdata, handles)
set(handles.disptime,'String',datestr(now));

function pushbutton1_Callback(hObject, eventdata, handles)
global image; 



% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[filename,filepath,index] = uigetfile({'*.bpm;*.jpg;*.png'},'insert a picture');
if filename == 0
    msgbox('Please choose a picture','Hint','help'); % 假如用户没有选择，那就不要继续往下执行
else
set(handles.axes1,'Visible','off');
set(handles.edit1,'string',[filepath filename]);
global road Realimage
road = get(handles.edit1,'string');
handles.road = get(handles.edit1,'string');
image = imread(road);
image = im2double(image);
Realimage=image;
axes(handles.axes1);
imshow(road);
end

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global X_VP Y_VP
global image 
global VP
global point_VP
         
delete(VP);
 [X,Y,b] = ginput(1);
 X_VP = round(X);
 Y_VP = round(Y);
    if b==1
        %set(handles.edit3 ,'string',round(X));
        %set(handles.edit4 ,'string',round(Y));
         
        hold on;
       VP = plot(X_VP,Y_VP,'ro','MarkerFaceColor','r');
       point_VP=findobj('MarkerFaceColor','r'); % 已经找到line的句柄值
       %加个box
       msgbox('A Vanishing point has been successfully added to the graph')
       point_VP_test=point_VP;     
    else
    end

    
   % pushbutton4_Callback(hObject, eventdata, handles);% 再检测VP是否改变，如果改变，则再次执行BG select

  
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function uipanel3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in BG_select.
function BG_select_Callback(hObject, eventdata, handles)
% 屏幕坐标计算
%通过选取背景左上和右下的点来确定背景
 %point_VP7 和 point_VP 2的选择  确定背景区域 并且计算平面中12个点
 p=msgbox('Please use the mouse to draw a rectangle as inner rectangle');
 waitfor(p);
 o=msgbox('If you want to change the shape of inner rectangle, click on BG_redefine after dragging and dropping');
 waitfor(o);
%  global X_coordinate_matrix Y_coordinate_matrix LINE4 BG1 BG2 gradient  %用来存储12个点的像素坐标
 global X_VP Y_VP image innerrectangle
 global Y_coordinate_matrix X_coordinate_matrix
  innerrectangle=drawrectangle('Label','inner rectangle','Color',[0 0 1],'LabelAlpha',0.02);
  %innerrectangle=findobj('LabelAlpha',0.02); % 获得移动矩形的句柄
  X_VP_1=X_VP;
  Y_VP_1=Y_VP;
  
  Position=get(innerrectangle,'Position');
  Position=round(Position);
  x_left=Position(1);%,y_up,width,height];
  y_up=Position(2);
 width=Position(3);
 height=Position(4);
 x_right=x_left+width;
 y_down=y_up+height;
 addlistener(innerrectangle,'MovingROI',@allevents);
 addlistener(innerrectangle,'ROIMoved',@allevents);
 X_coordinate_matrix(7) = x_left; 
 Y_coordinate_matrix(7) = y_up;
 X_coordinate_matrix(2) = x_right; 
 Y_coordinate_matrix(2) = y_down;
 X_coordinate_matrix(1) = x_left;
 Y_coordinate_matrix(1) = y_down;
 X_coordinate_matrix(8) = x_right;
 Y_coordinate_matrix(8) = y_up;
 
%  global inner_rectangle_position
%  inner_rectangle_position=[x_left x_right x_right x_left; 
%                            y_up y_up y_down y_down];

%    [X1,Y1] = ginput(1);
%   X1 = round(X1);
%   Y1 = round(Y1);
%   BG2 = plot(X1,Y1,'ro','MarkerFaceColor','g');
%  
%   [X2,Y2] = ginput(1);
%   X2 = round(X2);
%   Y2 = round(Y2);
%   BG1 = plot(X2,Y2,'ro','MarkerFaceColor','g');
%  X_coordinate_matrix(7) = X1; 
%  Y_coordinate_matrix(7) = Y1;
%  X_coordinate_matrix(2) = X2; 
%  Y_coordinate_matrix(2) = Y2;
%  X_coordinate_matrix(1) = X1;
%  Y_coordinate_matrix(1) = Y2;
%  X_coordinate_matrix(8) = X2;
%  Y_coordinate_matrix(8) = Y1;X_VP_1

 
 %从左下角逆时针分别计算VP点到四个顶点的斜率(inner rectangle)
 gradient(1) = abs(Y_coordinate_matrix(1) - Y_VP_1) / abs(X_coordinate_matrix(1) - X_VP_1);
 gradient(2) = abs(Y_coordinate_matrix(2) - Y_VP_1) / abs(X_coordinate_matrix(2) - X_VP_1);
 gradient(3) = abs(Y_coordinate_matrix(8) - Y_VP_1) / abs(X_coordinate_matrix(8) - X_VP_1);
 gradient(4) = abs(Y_coordinate_matrix(7) - Y_VP_1) / abs(X_coordinate_matrix(7) - X_VP_1);

% 左下角逆时针计算外矩形4个点的斜率(outer rectangle)
 gradient(5) = abs(size(image,1) - Y_VP_1) / abs(0 - X_VP_1); 
 gradient(6) = abs(size(image,1) - Y_VP_1) / abs(size(image,2) - X_VP_1);
 gradient(7) = abs(0 - Y_VP_1) / abs(size(image,2) - X_VP_1);
 gradient(8) = abs(0 - Y_VP_1) / abs(0 - X_VP_1);


 %计算其余剩下的点 (3 AND 5)
     % 3点
     X_coordinate_matrix(3) = round(X_VP_1 - ( (size(image,1)-Y_VP_1) / gradient(1) ));
     Y_coordinate_matrix(3) = size(image,1); 
     % 5点
     X_coordinate_matrix(5) = 0;
     Y_coordinate_matrix(5) = round(size(image,1) + X_coordinate_matrix(3)*gradient(1));

     X_coordinate_matrix(6) = size(image,2);
     Y_coordinate_matrix(6) = round(Y_VP_1 + (gradient(2)*(size(image,2)-X_VP_1)));
     X_coordinate_matrix(4) = round(size(image,2) + (X_coordinate_matrix(6)-X_VP_1)*(size(image,1)-Y_coordinate_matrix(6)) / (Y_coordinate_matrix(6)-Y_VP_1));
     Y_coordinate_matrix(4) = size(image,1);

% 12 AND 10 point_VP

    X_coordinate_matrix(12) = size(image,2);
    Y_coordinate_matrix(12) = round(Y_VP_1 - gradient(3)*(size(image,2)-X_VP_1));

    X_coordinate_matrix(10) = round(size(image,2) + Y_coordinate_matrix(12)*(size(image,2)-X_VP_1) / (Y_VP_1 - Y_coordinate_matrix(12)));
    Y_coordinate_matrix(10) = 0;

    % 9 AND 11 point_VP
    X_coordinate_matrix(9) = round(X_VP_1 - Y_VP_1/gradient(4));
    Y_coordinate_matrix(9) = 0;
    
    X_coordinate_matrix(11) = 0;
    Y_coordinate_matrix(11) = -1 * round(gradient(4) * X_coordinate_matrix(9));


%%

% save Y_coordinate_matrix.mat Y_coordinate_matrix
% save X_coordinate_matrix.mat X_coordinate_matrix
%左侧border

coordinate_matrix = [X_coordinate_matrix',Y_coordinate_matrix'];
% coordinate_matrix = array2table(coordinate_matrix);
coordinate_matrix = [X_VP_1 Y_VP_1;coordinate_matrix];
   set(handles.uitable2,'data',coordinate_matrix);%将12个点和VP点的数据填入GUI表格中

%加个border给可以动的边界
set(innerrectangle,'Position',[Position(1),Position(2),width,height]);

%   x_left=Position(1);%,y_up,width,height];
%   y_up=Position(2);
%  width=Position(3);
%  height=Position(4);
 %标出4个背景点
 hold on;
 %delete(BG1);
 %delete(BG2);
 plot(X_VP_1,Y_VP_1,'ro','MarkerFaceColor','r');
 

 plot(X_coordinate_matrix(2),Y_coordinate_matrix(2),'ro','MarkerFaceColor','g');
 plot(X_coordinate_matrix(7),Y_coordinate_matrix(7),'ro','MarkerFaceColor','g');
plot(X_coordinate_matrix(8),Y_coordinate_matrix(8),'ro','MarkerFaceColor','g');
plot(X_coordinate_matrix(1),Y_coordinate_matrix(1),'ro','MarkerFaceColor','g');

 %连线
 LINE3 = line([X_coordinate_matrix(7),X_coordinate_matrix(8)],[Y_coordinate_matrix(7),Y_coordinate_matrix(8)],'Color','blue','LineWidth',2,'LineStyle','-')
 LINE2 =line([X_coordinate_matrix(8),X_coordinate_matrix(2)],[Y_coordinate_matrix(8),Y_coordinate_matrix(2)],'Color','blue','LineWidth',2,'LineStyle','-')
 LINE1 = line([X_coordinate_matrix(2),X_coordinate_matrix(1)],[Y_coordinate_matrix(2),Y_coordinate_matrix(1)],'Color','blue','LineWidth',2,'LineStyle','-')
 LINE4 = line([X_coordinate_matrix(1),X_coordinate_matrix(7)],[Y_coordinate_matrix(1),Y_coordinate_matrix(7)],'Color','blue','LineWidth',2,'LineStyle','-');

line([X_VP_1,X_coordinate_matrix(5)],[Y_VP_1,Y_coordinate_matrix(5)],'Color','blue','LineWidth',2,'LineStyle','-')
line([X_VP_1,X_coordinate_matrix(4)],[Y_VP_1,Y_coordinate_matrix(4)],'Color','blue','LineWidth',2,'LineStyle','-')
line([X_VP_1,X_coordinate_matrix(10)],[Y_VP_1,Y_coordinate_matrix(10)],'Color','blue','LineWidth',2,'LineStyle','-')
line([X_VP_1,X_coordinate_matrix(11)],[Y_VP_1,Y_coordinate_matrix(11)],'Color','blue','LineWidth',2,'LineStyle','-')
global all_line
all_line=findobj('LineStyle','-');
%line([X_coordinate_matrix(12),X_coordinate_matrix(6)],[Y_coordinate_matrix(12),Y_coordinate_matrix(6)],'Color','blue','LineWidth',2,'LineStyle','-')
%line([X_coordinate_matrix(9),X_coordinate_matrix(10)],[Y_coordinate_matrix(9),Y_coordinate_matrix(10)],'Color','blue','LineWidth',2,'LineStyle','-')
%line([X_coordinate_matrix(3),X_coordinate_matrix(4)],[Y_coordinate_matrix(3),Y_coordinate_matrix(4)],'Color','blue','LineWidth',2,'LineStyle','-')
%line([X_coordinate_matrix(11),X_coordinate_matrix(5)],[Y_coordinate_matrix(11),Y_coordinate_matrix(5)],'Color','blue','LineWidth',2,'LineStyle','-')

plot(X_coordinate_matrix(3),Y_coordinate_matrix(3),'ro','MarkerFaceColor','g');
plot(X_coordinate_matrix(5),Y_coordinate_matrix(5),'ro','MarkerFaceColor','g');
plot(X_coordinate_matrix(6),Y_coordinate_matrix(6),'ro','MarkerFaceColor','g');
plot(X_coordinate_matrix(4),Y_coordinate_matrix(4),'ro','MarkerFaceColor','g');
plot(X_coordinate_matrix(12),Y_coordinate_matrix(12),'ro','MarkerFaceColor','g');
plot(X_coordinate_matrix(10),Y_coordinate_matrix(10),'ro','MarkerFaceColor','g');
plot(X_coordinate_matrix(9),Y_coordinate_matrix(9),'ro','MarkerFaceColor','g');
plot(X_coordinate_matrix(11),Y_coordinate_matrix(11),'ro','MarkerFaceColor','g');
global BG_obj
BG_obj=findobj('MarkerFaceColor','g');
p=msgbox('If you want to change the shape of inner recktangle, you can drag the rectangular border in the figure, and then click on  Redefine inner recktangle below','Hint');
waitfor(p);


 % pic_1 = imcrop(pic,[x(1),y(1),abs(x(1)-x(2)),abs(y(1)-y(2))]);

% hObject    handle to BG_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%  addlistener(h,'MovingROI',@allevents);
%  addlistener(h,'ROIMoved',@allevents);

%%




 function edit5_Callback(hObject, eventdata, handles)
    
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)


% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.

function uitable2_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global point_VP


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global ButtonDown pos1 point_VP;
% if strcmp(get(gcf,'SelectionType'), 'normal') & strcmp(get(handles.axes1,'Currentpoint_VP'),get(point_VP,'Positon'))
%     ButtonDown=1;
%     pos1=get(handles.axes1,'Currentpoint_VP');
% end
% global point_VP X_VP Y_VP;
%      pos=get(handles.axes1,'Currentpoint');
%      set(point_VP,'XData',round(pos(1,1)));
%      set(point_VP,'YData',round(pos(1,2)));
%      X_VP=round(pos(1,1));
%      Y_VP=round(pos(1,2));
     
% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% global ButtonDown pos1 point_VP;
% if strcmp(get(gcf,'SelectionType'), 'normal') & strcmp(get(handles.axes1,'Currentpoint_VP'),[get(point_VP,'XData') get(point_VP,'YData')])
%     ButtonDown=1;
%     pos1=get(handles.axes1,'Currentpoint_VP');
% end
%      pos=get(handles.axes1,'Currentpoint_VP');
%      X_VP=pos(1,1);
%      Y_VP=pos(1,2);


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ButtonDown X_VP Y_VP;
% if ButtonDown == 1
%     pos=get(handles.axes1,'Currentpoint_VP');
%     X_VP=pos(1,1);
%     Y_VP=pos(1,2);
% end

    


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global ButtonDown 
% ButtonDown=[];


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VP
delete(VP);
h=findobj('MarkerFaceColor','r');
delete(h);
%set(handles.axes1,'Visible','on');


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global all_line BG_obj
delete(all_line);
delete(BG_obj);



% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla;
set(handles.axes1,'Visible','on');


% --- Executes on button press in Foreground_1.
function Foreground_1_Callback(hObject, eventdata, handles)
% hObject    handle to Foreground_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 hold on

 global image
 o=msgbox('Next, the rectangle will be used to select the desired inner recktangle','Hint');
 waitfor(o);
 h=drawrectangle('Label','Foreground','Color',[1 0 0],'LabelAlpha',0.01);
 Position=get(h,'Position');
 Position=round(Position);
 x_left=Position(1);%,y_up,width,height];
 y_up=Position(2);
 width=Position(3);
 height=Position(4);
 x_right=x_left+width;
 y_down=y_up+height;
 global foreobj_2D
 foreobj_2D(:,1)=[x_left;y_up];
 foreobj_2D(:,2)=[x_right;y_up];
 foreobj_2D(:,3)=[x_right;y_down];
 foreobj_2D(:,4)=[x_left;y_down];
 %set(handles.uitable2,'data',Vordergrund_Punkt);
%  save foreobj_2D.mat Foreground_Point_1
 Foreground_1=imcrop(image,Position); % 第一个前景图片,到时候把位置信息对应进去
 save Foreground.mat  Foreground_1
 global mask_1 
 mask_1 = createMask(h,image);
 %montage({image,mask});显示多个图像
 global Background
 Background = inpaintExemplar(image,mask_1); %这个很重要！
 image = Background;
 delete(h);
 set(handles.Foreground_1,'UserData',1);
 
 global on_ceiling on_floor on_rightwall on_leftwall
 judge_VG_Position=inputdlg('Please enter where the foreground is, either floor or ceiling');
 n_1=strlength(judge_VG_Position);
 if n_1 == 5
     on_floor=true;
     on_leftwall=false;
     on_ceiling=false;
     on_rightwall=false;
 elseif n_1 == 7
     on_floor=false;
     on_leftwall=false;
     on_ceiling=true;
     on_rightwall=false;
 else 
     msgbox('please enter the right position of foreground')
     judge_VG_Position=inputdlg('Please enter where the foreground is, either floor or ceiling');
     n_1=strlength(judge_VG_Position);
               if n_1 == 5
     on_floor=true;
     on_leftwall=false;
     on_ceiling=false;
     on_rightwall=false;
               elseif n_1 == 7
     on_floor=false;
     on_leftwall=false;
     on_ceiling=true;
     on_rightwall=false;
               else 
     on_floor=false;
     on_leftwall=false;
     on_ceiling=false;
     on_rightwall=false;
               end
 end
 

 %axes(handles.axes1)
 %imshow(Background)

 

 
% --- Executes during object creation, after setting all properties.
function Foreground_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Foreground_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function BG_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Foreground_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% global innerrectangle
%  addlistener(innerrectangle,'MovingROI',@allevents);
%  addlistener(innerrectangle,'ROIMoved',@allevents);




% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc,clear,close all


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Foreground_2.
function Foreground_2_Callback(hObject, eventdata, handles)
% hObject    handle to Foreground_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image Background BG_obj all_line
o=msgbox('It is not yet possible to select the second foreground, but this function can be used to capture the area you like, and the captured image will be stored directly in the folder','Hint');
waitfor(o);
 h=drawrectangle('Label','Vordergrund','Color',[1 0 0],'LabelAlpha',0);
 Position=get(h,'Position');
 Position=round(Position);
 %set(handles.pushbutton13,'String',Position);
 %save12312 position_VG.mat Position
 %imCp=imcrop(image,Position);
 x_left=Position(1);%,y_up,width,height];
 y_up=Position(2);
 width=Position(3);
 height=Position(4);
 x_right=x_left+width;
 y_down=y_up+height;
 global Foreground_Point_2
 Foreground_Point_2(:,1)=[x_left;y_up];
 Foreground_Point_2(:,2)=[x_right;y_up];
 Foreground_Point_2(:,3)=[x_right;y_down];
 Foreground_Point_2(:,4)=[x_left;y_down];
 %set(handles.uitable2,'data',Vordergrund_Punkt);
 %save foreobj_2D_2.mat Foreground_Point_2
 Foreground_2=imcrop(image,Position); % 第二个前景图片,到时候把位置信息对应进去
 save foreobj_2D_2.mat  Foreground_2
 global mask_2
 mask_2 = createMask(h);
 %montage({image,mask});显示多个图像
 global Background
 Background = inpaintExemplar(Background,mask_2); %这个很重要！
 delete(h);
 set(handles.Foreground_2,'UserData',1);





% --- Executes on button press in Foreground_3.
function Foreground_3_Callback(hObject, eventdata, handles)
% hObject    handle to Foreground_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image Background BG_obj all_line
o=msgbox('It is not yet possible to select the third foreground, but this function can be used to capture the area you like, and the captured image will be stored directly in the folder','Hint');
waitfor(o);
 h=drawrectangle('Label','Vordergrund','Color',[1 0 0],'LabelAlpha',0);
 Position=get(h,'Position');
 Position=round(Position);
 %set(handles.pushbutton13,'String',Position);
 %save12312 position_VG.mat Position
 %imCp=imcrop(image,Position);
 x_left=Position(1);%,y_up,width,height];
 y_up=Position(2);
 width=Position(3);
 height=Position(4);
 x_right=x_left+width;
 y_down=y_up+height;
 global Foreground_Point_3
 Foreground_Point_3(:,1)=[x_left;y_up];
 Foreground_Point_3(:,2)=[x_right;y_up];
 Foreground_Point_3(:,3)=[x_right;y_down];
 Foreground_Point_3(:,4)=[x_left;y_down];
 %set(handles.uitable2,'data',Vordergrund_Punkt);
 %save foreobj_2D_3.mat Foreground_Point_3
 Foreground_3=imcrop(image,Position); % 第三个前景图片,到时候把位置信息对应进去
 save   foreobj_2D_3.mat  Foreground_3
 global mask_3
 mask_3 = createMask(h);
 %montage({image,mask});显示多个图像
 global Background
 Background = inpaintExemplar(Background,mask_3); %这个很重要！是要逐次叠加
 
 delete(h);
 set(handles.Foreground_3,'UserData',1);


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(handles.popupmenu3,'value');
if a == 2         % 1是默认的第一个String！！
    %set(handles.Foreground_1,'Value',1);
    %set(handles.popupmenu3,'Callback',{@Foreground_2_Callback,handles});
    Foreground_1_Callback(hObject, eventdata, handles);
end
if a == 3 
    %set(handles.Foreground_2,'Value',1);
    Foreground_2_Callback(hObject, eventdata, handles);
end
if a==4
        Foreground_3_Callback(hObject, eventdata, handles);
end
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function Origin_Callback(hObject, eventdata, handles)
% hObject    handle to Origin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global road
figure
imshow(road);


% --------------------------------------------------------------------
function Background_Callback(hObject, eventdata, handles)
% hObject    handle to Background (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Background
figure
imshow(Background)


% --------------------------------------------------------------------
function Mask_Callback(hObject, eventdata, handles)
% hObject    handle to Mask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mask_1 mask_2 mask_3
figure
hold on
imshow(mask_1);
imshow(mask_2);
imshow(mask_3);
hold off


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global phi estimatedVertex
global transferedForeObj
 global theta
 global transferedEstimatedVertex
  global oevminx oevmaxx oevminy oevmaxy oevdiffx oevdiffy
    global tevminx tevmaxx tevminy tevmaxy tevdiffx tevdiffy
    global tevminx0 tevmaxx0 tevminy0 tevmaxy0 tevdiffx0 tevdiffy0
    global R
    global deduceFlag
    global foreObj
    global eye
    global mat
    global invisLw
    global invisRw
    global invisCe
    global invisFl
phi=get(handles.slider2,'Value');
phi=-phi;

[eye,mat] = getPerspectiveTransferMatrix();
  transferedEstimatedVertex = getTransferedEstimatedVerticesScreenCoordinates();
    
a=get(handles.slider2,'Value');
a=num2str(a);
set(handles.show_phi,'String',['Vertical rotation angle' 'phi is ' a]);




% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Rotate_90_Callback(hObject, eventdata, handles)
% hObject    handle to Rotate_90 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image rotate_image
rotate_image=imrotate(image,90,'bilinear','loose');
image=rotate_image;
axes(handles.axes1);
imshow(image);



% --------------------------------------------------------------------
function Rotate_180_Callback(hObject, eventdata, handles)
% hObject    handle to Rotate_180 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image rotate_image
rotate_image=imrotate(image,180,'bilinear','loose');
image=rotate_image;
axes(handles.axes1);
imshow(image);


% --------------------------------------------------------------------
function Rotate_270_Callback(hObject, eventdata, handles)
% hObject    handle to Rotate_270 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image rotate_image
rotate_image=imrotate(image,270,'bilinear','loose');
image=rotate_image;
axes(handles.axes1);
imshow(image);


% --------------------------------------------------------------------
% function save12312_Callback(hObject, eventdata, handles)
% % hObject    handle to save12312 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% %global image
% saveas(gca,'image.jpg');


% --------------------------------------------------------------------
function Save_Background12_Callback(hObject, eventdata, handles)
% hObject    handle to Save_Background12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Background
imwrite(Background,'Background.jpg');


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function current_image_Callback(hObject, eventdata, handles)
% hObject    handle to current_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
saveas(gca,'image.jpg');

function Save_Background_Callback(hObject, eventdata, handles)
% hObject    handle to Save_Background12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Background
saveas(Background,'Background.jpg');


% --------------------------------------------------------------------
function Save_Foreground_1_Callback(hObject, eventdata, handles)
% hObject    handle to Save_Foreground_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=load('Foreground_1.mat');
imwrite(h,'Foreground_1.jpg');


% --------------------------------------------------------------------
function Save_Foreground_2_Callback(hObject, eventdata, handles)
% hObject    handle to Save_Foreground_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=load('Foreground_2.mat');
imwrite(h,'Foreground_2.jpg');


% --------------------------------------------------------------------
function Save_Foreground_3_Callback(hObject, eventdata, handles)
% hObject    handle to Save_Foreground_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=load('Foreground_3.mat');
saveas(h,'Foreground_3.jpg');


% --- Executes on button press in on_floor.
function on_floor_Callback(hObject, eventdata, handles)
% hObject    handle to on_floor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global on_floor
on_floor=true;

% Hint: get(hObject,'Value') returns toggle state of on_floor


% --- Executes on button press in on_ceiling.
function on_ceiling_Callback(hObject, eventdata, handles)
% hObject    handle to on_ceiling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global on_ceiling
on_ceiling=true;

% Hint: get(hObject,'Value') returns toggle state of on_ceiling


% --- Executes on button press in on_leftwall.
function on_leftwall_Callback(hObject, eventdata, handles)
% hObject    handle to on_leftwall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global on_leftwall
on_leftwall=true;

% Hint: get(hObject,'Value') returns toggle state of on_leftwall


% --- Executes on button press in on_rightwall.
function on_rightwall_Callback(hObject, eventdata, handles)
% hObject    handle to on_rightwall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global on_rightwall
on_rightwall=true;

% Hint: get(hObject,'Value') returns toggle state of on_rightwall


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global phi estimatedVertex
global transferedForeObj
 global theta
 global transferedEstimatedVertex
  global oevminx oevmaxx oevminy oevmaxy oevdiffx oevdiffy
    global tevminx tevmaxx tevminy tevmaxy tevdiffx tevdiffy
    global tevminx0 tevmaxx0 tevminy0 tevmaxy0 tevdiffx0 tevdiffy0
    global R
    global deduceFlag
    global foreObj
    global eye
    global mat
        global invisLw
    global invisRw
    global invisCe
    global invisFl
theta=get(handles.slider3,'Value');
theta=-theta;
 [eye,mat] = getPerspectiveTransferMatrix();
  transferedEstimatedVertex = getTransferedEstimatedVerticesScreenCoordinates();  
a=get(handles.slider3,'Value');
a=num2str(a);
set(handles.show_theta,'String',['Horizontal rotation angle' 'theta is ' a]);



% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in BG_Redefine.
function BG_Redefine_Callback(hObject, eventdata, handles)
% hObject    handle to BG_Redefine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%global X_coordinate_matrix Y_coordinate_matrix LINE4 gradient BG1 BG %用来存储12个点的像素坐标
     global X_VP Y_VP image innerrectangle road d_left d_up
     global Foreground_Point_1 Foreground_Point_2 Foreground_Point_3
     global Y_coordinate_matrix X_coordinate_matrix
     Position_1=get(innerrectangle,'Position');
     cla;
     delete(innerrectangle);
     axes(handles.axes1);
     imshow(road);
     %VP = plot(X_VP,Y_VP,'ro','MarkerFaceColor','r');
     %innerrectangle=drawrectangle('Position',Position,'StripeColor','r');
     % Position=get(innerrectangle,'Position');
  Position_1=round(Position_1);
  x_left=Position_1(1);%,y_up,width,height];
  y_up=Position_1(2);
  width=Position_1(3);
  height=Position_1(4);
  X_VP_1=X_VP;
  Y_VP_1=Y_VP;

 
 
 x_right=x_left+width;
 y_down=y_up+height;
%  addlistener(h,'MovingROI',@allevents);
%  addlistener(h,'ROIMoved',@allevents);
%innerrectangle=drawrectangle('Position',[x_left,y_up,width,height],'StripeColor','r');
 X_coordinate_matrix(7) = x_left; 
 Y_coordinate_matrix(7) = y_up;
 X_coordinate_matrix(2) = x_right; 
 Y_coordinate_matrix(2) = y_down;
 X_coordinate_matrix(1) = x_left;
 Y_coordinate_matrix(1) = y_down;
 X_coordinate_matrix(8) = x_right;
 Y_coordinate_matrix(8) = y_up;
  %从左下角逆时针分别计算VP点到四个顶点的斜率(inner rectangle)
 gradient(1) = abs(Y_coordinate_matrix(1) - Y_VP_1) / abs(X_coordinate_matrix(1) - X_VP_1);
 gradient(2) = abs(Y_coordinate_matrix(2) - Y_VP_1) / abs(X_coordinate_matrix(2) - X_VP_1);
 gradient(3) = abs(Y_coordinate_matrix(8) - Y_VP_1) / abs(X_coordinate_matrix(8) - X_VP_1);
 gradient(4) = abs(Y_coordinate_matrix(7) - Y_VP_1) / abs(X_coordinate_matrix(7) - X_VP_1);

% 左下角逆时针计算外矩形4个点的斜率(outer rectangle)
 gradient(5) = abs(size(image,1) - Y_VP_1) / abs(0 - X_VP_1); 
 gradient(6) = abs(size(image,1) - Y_VP_1) / abs(size(image,2) - X_VP_1);
 gradient(7) = abs(0 - Y_VP_1) / abs(size(image,2) - X_VP_1);
 gradient(8) = abs(0 - Y_VP_1) / abs(0 - X_VP_1);


 %计算其余剩下的点 (3 AND 5)

     % 3点
     X_coordinate_matrix(3) = round(X_VP_1 - ( (size(image,1)-Y_VP_1) / gradient(1) ));
     Y_coordinate_matrix(3) = size(image,1); 
     % 5点
     X_coordinate_matrix(5) = 0;
     Y_coordinate_matrix(5) = round(size(image,1) + X_coordinate_matrix(3)*gradient(1));

 %  6 AND 4 point_VP
 


     X_coordinate_matrix(6) = size(image,2);
     Y_coordinate_matrix(6) = round(Y_VP_1 + (gradient(2)*(size(image,2)-X_VP_1)));
     X_coordinate_matrix(4) = round(size(image,2) + (X_coordinate_matrix(6)-X_VP_1)*(size(image,1)-Y_coordinate_matrix(6)) / (Y_coordinate_matrix(6)-Y_VP_1));
     Y_coordinate_matrix(4) = size(image,1);
 

% 12 AND 10 point_VP


    X_coordinate_matrix(12) = size(image,2);
    Y_coordinate_matrix(12) = round(Y_VP_1 - gradient(3)*(size(image,2)-X_VP_1));

    X_coordinate_matrix(10) = round(size(image,2) + Y_coordinate_matrix(12)*(size(image,2)-X_VP_1) / (Y_VP_1 - Y_coordinate_matrix(12)));
    Y_coordinate_matrix(10) = 0;

    % 9 AND 11 point_VP

    X_coordinate_matrix(9) = round(X_VP_1 - Y_VP_1/gradient(4));
    Y_coordinate_matrix(9) = 0;
    
    X_coordinate_matrix(11) = 0;
    Y_coordinate_matrix(11) = -1 * round(gradient(4) * X_coordinate_matrix(9));

%左侧border
%VP_point=[X_VP_1;Y_VP_1];
%save VP.mat VP_point % 这个才是每次新的VP坐标

 x_left=X_coordinate_matrix(7); 
 y_up=Y_coordinate_matrix(7);
innerrectangle=drawrectangle('Position',[x_left,y_up,width,height],'StripeColor','r');
% 
% save Y_coordinate_matrix.mat Y_coordinate_matrix
% save X_coordinate_matrix.mat X_coordinate_matrix


coordinate_matrix = [X_coordinate_matrix',Y_coordinate_matrix']; %现在成列向量了
% coordinate_matrix = array2table(coordinate_matrix);
coordinate_matrix = [X_VP_1 Y_VP_1;coordinate_matrix];
   set(handles.uitable2,'data',coordinate_matrix);%将12个点和VP点的数据填入GUI表格中

%加个border给可以动的边界
%set(innerrectangle,'Position',[Position_1(1)+d_left,Position_1(2)+d_up,width,height]);



 %标出4个背景点
 hold on;
 %delete(BG1);
 %delete(BG2);
 %global VP
 
 %delete(VP);
 plot(X_VP_1,Y_VP_1,'ro','MarkerFaceColor','r');
 

 plot(X_coordinate_matrix(2),Y_coordinate_matrix(2),'ro','MarkerFaceColor','g');
 plot(X_coordinate_matrix(7),Y_coordinate_matrix(7),'ro','MarkerFaceColor','g');
 BG3 = plot(X_coordinate_matrix(8),Y_coordinate_matrix(8),'ro','MarkerFaceColor','g');
 BG4 = plot(X_coordinate_matrix(1),Y_coordinate_matrix(1),'ro','MarkerFaceColor','g');

 %连线
 LINE3 = line([X_coordinate_matrix(7),X_coordinate_matrix(8)],[Y_coordinate_matrix(7),Y_coordinate_matrix(8)],'Color','blue','LineWidth',2,'LineStyle','-')
 LINE2 =line([X_coordinate_matrix(8),X_coordinate_matrix(2)],[Y_coordinate_matrix(8),Y_coordinate_matrix(2)],'Color','blue','LineWidth',2,'LineStyle','-')
 LINE1 = line([X_coordinate_matrix(2),X_coordinate_matrix(1)],[Y_coordinate_matrix(2),Y_coordinate_matrix(1)],'Color','blue','LineWidth',2,'LineStyle','-')
 LINE4 = line([X_coordinate_matrix(1),X_coordinate_matrix(7)],[Y_coordinate_matrix(1),Y_coordinate_matrix(7)],'Color','blue','LineWidth',2,'LineStyle','-');

line([X_VP_1,X_coordinate_matrix(5)],[Y_VP_1,Y_coordinate_matrix(5)],'Color','blue','LineWidth',2,'LineStyle','-')
line([X_VP_1,X_coordinate_matrix(4)],[Y_VP_1,Y_coordinate_matrix(4)],'Color','blue','LineWidth',2,'LineStyle','-')
line([X_VP_1,X_coordinate_matrix(10)],[Y_VP_1,Y_coordinate_matrix(10)],'Color','blue','LineWidth',2,'LineStyle','-')
line([X_VP_1,X_coordinate_matrix(11)],[Y_VP_1,Y_coordinate_matrix(11)],'Color','blue','LineWidth',2,'LineStyle','-')
global all_line
all_line=findobj('LineStyle','-');
%line([X_coordinate_matrix(12),X_coordinate_matrix(6)],[Y_coordinate_matrix(12),Y_coordinate_matrix(6)],'Color','blue','LineWidth',2,'LineStyle','-')
%line([X_coordinate_matrix(9),X_coordinate_matrix(10)],[Y_coordinate_matrix(9),Y_coordinate_matrix(10)],'Color','blue','LineWidth',2,'LineStyle','-')
%line([X_coordinate_matrix(3),X_coordinate_matrix(4)],[Y_coordinate_matrix(3),Y_coordinate_matrix(4)],'Color','blue','LineWidth',2,'LineStyle','-')
%line([X_coordinate_matrix(11),X_coordinate_matrix(5)],[Y_coordinate_matrix(11),Y_coordinate_matrix(5)],'Color','blue','LineWidth',2,'LineStyle','-')

plot(X_coordinate_matrix(3),Y_coordinate_matrix(3),'ro','MarkerFaceColor','g');
plot(X_coordinate_matrix(5),Y_coordinate_matrix(5),'ro','MarkerFaceColor','g');
plot(X_coordinate_matrix(6),Y_coordinate_matrix(6),'ro','MarkerFaceColor','g');
plot(X_coordinate_matrix(4),Y_coordinate_matrix(4),'ro','MarkerFaceColor','g');
plot(X_coordinate_matrix(12),Y_coordinate_matrix(12),'ro','MarkerFaceColor','g');
plot(X_coordinate_matrix(10),Y_coordinate_matrix(10),'ro','MarkerFaceColor','g');
plot(X_coordinate_matrix(9),Y_coordinate_matrix(9),'ro','MarkerFaceColor','g');
plot(X_coordinate_matrix(11),Y_coordinate_matrix(11),'ro','MarkerFaceColor','g');
global BG_obj
BG_obj=findobj('MarkerFaceColor','g');
%%


% --- Executes on button press in remove_all_marks.
function remove_all_marks_Callback(hObject, eventdata, handles)
% hObject    handle to remove_all_marks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
     global road
     cla;
     axes(handles.axes1);
     imshow(road);

     
 
     


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 global theta
 global phi
 global deduceFlag
 global transferedEstimatedVertex

 global transferedEstimatedVertex
  global estimatedVertex
  global oevminx oevmaxx oevminy oevmaxy oevdiffx oevdiffy
    global tevminx tevmaxx tevminy tevmaxy tevdiffx tevdiffy
    global tevminx0 tevmaxx0 tevminy0 tevmaxy0 tevdiffx0 tevdiffy0
    global mat
    global R
    global foreObj
    global transferedForeObj
    global eye
    global invisLw
    global invisRw
    global invisCe
    global invisFl
    global given_foreobj
    if get(handles.Foreground_1,'UserData') == 1
        given_foreobj=true;
    else 
        given_foreobj=false;
    end
%inputdlg('Do you want to see the 3D_Model,please enter yes or no','Hint');


theta = 0;
phi = 0;
deduceFlag = 0;
virtual_output = Build3DModel();
[eye,mat] = getPerspectiveTransferMatrix();
transferedEstimatedVertex = getTransferedEstimatedVerticesScreenCoordinates();
deduceFlag = 1;

%n1=strlength(show_3DModel);
figure
    % drawing lines for background
    line([transferedEstimatedVertex(1,2),transferedEstimatedVertex(1,3)],[transferedEstimatedVertex(2,2),transferedEstimatedVertex(2,3)],'color','b')
    hold on
    line([transferedEstimatedVertex(1,3),transferedEstimatedVertex(1,9)],[transferedEstimatedVertex(2,3),transferedEstimatedVertex(2,9)],'color','b')
    line([transferedEstimatedVertex(1,9),transferedEstimatedVertex(1,8)],[transferedEstimatedVertex(2,9),transferedEstimatedVertex(2,8)],'color','b')
    line([transferedEstimatedVertex(1,8),transferedEstimatedVertex(1,2)],[transferedEstimatedVertex(2,8),transferedEstimatedVertex(2,2)],'color','b')
    line([transferedEstimatedVertex(1,2),transferedEstimatedVertex(1,6)],[transferedEstimatedVertex(2,2),transferedEstimatedVertex(2,6)],'color','b')
    line([transferedEstimatedVertex(1,4),transferedEstimatedVertex(1,5)],[transferedEstimatedVertex(2,4),transferedEstimatedVertex(2,5)],'color','b')
    line([transferedEstimatedVertex(1,5),transferedEstimatedVertex(1,3)],[transferedEstimatedVertex(2,5),transferedEstimatedVertex(2,3)],'color','b')
    line([transferedEstimatedVertex(1,5),transferedEstimatedVertex(1,3)],[transferedEstimatedVertex(2,5),transferedEstimatedVertex(2,3)],'color','b')
    line([transferedEstimatedVertex(1,6),transferedEstimatedVertex(1,12)],[transferedEstimatedVertex(2,6),transferedEstimatedVertex(2,12)],'color','b')
    line([transferedEstimatedVertex(1,12),transferedEstimatedVertex(1,8)],[transferedEstimatedVertex(2,12),transferedEstimatedVertex(2,8)],'color','b')
    line([transferedEstimatedVertex(1,10),transferedEstimatedVertex(1,11)],[transferedEstimatedVertex(2,10),transferedEstimatedVertex(2,11)],'color','b')
    line([transferedEstimatedVertex(1,11),transferedEstimatedVertex(1,9)],[transferedEstimatedVertex(2,11),transferedEstimatedVertex(2,9)],'color','b')
    line([transferedEstimatedVertex(1,13),transferedEstimatedVertex(1,7)],[transferedEstimatedVertex(2,13),transferedEstimatedVertex(2,7)],'color','b')
    % Adding highlights and numbers for the Vertices
    
    % scatter3(transferedEstimatedVertex(1,:),transferedEstimatedVertex(2,:),'color','g')
    if get(handles.Foreground_1,'UserData') == 1
     line([transferedForeObj(1,4),transferedForeObj(1,3)],[transferedForeObj(2,4),transferedForeObj(2,3)],'color','r')
     line([transferedForeObj(1,3),transferedForeObj(1,2)],[transferedForeObj(2,3),transferedForeObj(2,2)],'color','r')
     line([transferedForeObj(1,2),transferedForeObj(1,1)],[transferedForeObj(2,2),transferedForeObj(2,1)],'color','r')
     line([transferedForeObj(1,1),transferedForeObj(1,4)],[transferedForeObj(2,1),transferedForeObj(2,4)],'color','r')
    end
     
    for i=1:13
        num = num2str(i-1);
        text(transferedEstimatedVertex(1,i),transferedEstimatedVertex(2,i),num,'color','red')
    end
    % Drawing lines for foreobject (to be implemented)
    xlabel('x')
    ylabel('y')
    %hold off


    a = zeros(3,1);
    a(1,1) = estimatedVertex(1,2);
    a(2,1) = estimatedVertex(2,2);
    a(3,1) = estimatedVertex(3,2);
    b = zeros(3,1);
    b(1,1) = estimatedVertex(1,3);
    b(2,1) = estimatedVertex(2,3);
    b(3,1) = estimatedVertex(3,3);
    c = zeros(3,1);
    c(1,1) = estimatedVertex(1,8);
    c(2,1) = estimatedVertex(2,8);
    c(3,1) = estimatedVertex(3,8);
    d = zeros(3,1);
    d(1,1) = estimatedVertex(1,9);
    d(2,1) = estimatedVertex(2,9);
    d(3,1) = estimatedVertex(3,9);
    v1 = getInitialScreenCoordinates(a);
    v2 = getInitialScreenCoordinates(b);
    v7 = getInitialScreenCoordinates(c);
    v8 = getInitialScreenCoordinates(d);
    

    %figure   
    line([v1(1,1),v2(1,1)],[v1(2,1),v2(2,1)],'color','b');
    % hold on
    line([v2(1,1),v8(1,1)],[v2(2,1),v8(2,1)],'color','b');
    line([v8(1,1),v7(1,1)],[v8(2,1),v7(2,1)],'color','b');
    line([v7(1,1),v1(1,1)],[v7(2,1),v1(2,1)],'color','b');
%     line([v1(1,1),v3(1,1)],[v1(2,1),v3(2,1)],'color','b');
%     line([v3(1,1),v4(1,1)],[v3(2,1),v4(2,1)],'color','b');
%     line([v4(1,1),v2(1,1)],[v4(2,1),v2(2,1)],'color','b');
%     line([v7(1,1),v9(1,1)],[v7(2,1),v9(2,1)],'color','b');
%     line([v9(1,1),v10(1,1)],[v9(2,1),v10(2,1)],'color','b');
%     line([v10(1,1),v8(1,1)],[v10(2,1),v8(2,1)],'color','b');    
%     line([estimatedVertex(4,2),estimatedVertex(4,3)],[estimatedVertex(5,2),estimatedVertex(5,3)],'color','red');
%     line([estimatedVertex(4,3),estimatedVertex(4,9)],[estimatedVertex(5,3),estimatedVertex(5,9)],'color','red');
%     line([estimatedVertex(4,9),estimatedVertex(4,8)],[estimatedVertex(5,9),estimatedVertex(5,8)],'color','red');
%     line([estimatedVertex(4,8),estimatedVertex(4,2)],[estimatedVertex(5,8),estimatedVertex(5,2)],'color','red');
    hold off

   
    
  


% --- Executes on button press in confirm.
function confirm_Callback(hObject, eventdata, handles)
% hObject    handle to confirm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global phi estimatedVertex 
global transferedForeObj
 global theta
 global transferedEstimatedVertex
  global oevminx oevmaxx oevminy oevmaxy oevdiffx oevdiffy
    global tevminx tevmaxx tevminy tevmaxy tevdiffx tevdiffy
    global tevminx0 tevmaxx0 tevminy0 tevmaxy0 tevdiffx0 tevdiffy0
    global R
    global deduceFlag
    global foreObj
    global eye
    global mat
        global invisLw
    global invisRw
    global invisCe
    global invisFl given_foreobj

theta=get(handles.slider3,'Value');
theta=-theta;   
phi=get(handles.slider2,'Value');
phi=-phi;   
[eye,mat] = getPerspectiveTransferMatrix();
transferedEstimatedVertex = getTransferedEstimatedVerticesScreenCoordinates();
global image OrIm foreObj Realimage
OrIm=image;
rough_coefficient=0.01;
b=msgbox('Image is being rendered, please wait','Hint');
waitfor(b);
figure
[GeIm] = DrawGeneratedImage(estimatedVertex,foreObj, Realimage,OrIm, rough_coefficient);
    


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global phi estimatedVertex
global transferedForeObj
 global theta
 global transferedEstimatedVertex
  global oevminx oevmaxx oevminy oevmaxy oevdiffx oevdiffy
    global tevminx tevmaxx tevminy tevmaxy tevdiffx tevdiffy
    global tevminx0 tevmaxx0 tevminy0 tevmaxy0 tevdiffx0 tevdiffy0
    global R
    global deduceFlag
    global foreObj
    global eye
    global mat
        global invisLw
    global invisRw
    global invisCe
    global invisFl
%show_3DModel=inputdlg('Do you want to see the 3D Model after the rotation, please enter yes or no');
%n_2=strlength(show_3DModel)
 figure
    % drawing lines for background
    line([transferedEstimatedVertex(1,2),transferedEstimatedVertex(1,3)],[transferedEstimatedVertex(2,2),transferedEstimatedVertex(2,3)],'color','b')
    hold on
    line([transferedEstimatedVertex(1,3),transferedEstimatedVertex(1,9)],[transferedEstimatedVertex(2,3),transferedEstimatedVertex(2,9)],'color','b')
    line([transferedEstimatedVertex(1,9),transferedEstimatedVertex(1,8)],[transferedEstimatedVertex(2,9),transferedEstimatedVertex(2,8)],'color','b')
    line([transferedEstimatedVertex(1,8),transferedEstimatedVertex(1,2)],[transferedEstimatedVertex(2,8),transferedEstimatedVertex(2,2)],'color','b')
    line([transferedEstimatedVertex(1,2),transferedEstimatedVertex(1,6)],[transferedEstimatedVertex(2,2),transferedEstimatedVertex(2,6)],'color','b')
    line([transferedEstimatedVertex(1,4),transferedEstimatedVertex(1,5)],[transferedEstimatedVertex(2,4),transferedEstimatedVertex(2,5)],'color','b')
    line([transferedEstimatedVertex(1,5),transferedEstimatedVertex(1,3)],[transferedEstimatedVertex(2,5),transferedEstimatedVertex(2,3)],'color','b')
    line([transferedEstimatedVertex(1,5),transferedEstimatedVertex(1,3)],[transferedEstimatedVertex(2,5),transferedEstimatedVertex(2,3)],'color','b')
    line([transferedEstimatedVertex(1,6),transferedEstimatedVertex(1,12)],[transferedEstimatedVertex(2,6),transferedEstimatedVertex(2,12)],'color','b')
    line([transferedEstimatedVertex(1,12),transferedEstimatedVertex(1,8)],[transferedEstimatedVertex(2,12),transferedEstimatedVertex(2,8)],'color','b')
    line([transferedEstimatedVertex(1,10),transferedEstimatedVertex(1,11)],[transferedEstimatedVertex(2,10),transferedEstimatedVertex(2,11)],'color','b')
    line([transferedEstimatedVertex(1,11),transferedEstimatedVertex(1,9)],[transferedEstimatedVertex(2,11),transferedEstimatedVertex(2,9)],'color','b')
    line([transferedEstimatedVertex(1,13),transferedEstimatedVertex(1,7)],[transferedEstimatedVertex(2,13),transferedEstimatedVertex(2,7)],'color','b')
    % Adding highlights and numbers for the Vertices
    
    % scatter3(transferedEstimatedVertex(1,:),transferedEstimatedVertex(2,:),'color','g')
    if get(handles.Foreground_1,'UserData') == 1
     line([transferedForeObj(1,4),transferedForeObj(1,3)],[transferedForeObj(2,4),transferedForeObj(2,3)],'color','r')
     line([transferedForeObj(1,3),transferedForeObj(1,2)],[transferedForeObj(2,3),transferedForeObj(2,2)],'color','r')
     line([transferedForeObj(1,2),transferedForeObj(1,1)],[transferedForeObj(2,2),transferedForeObj(2,1)],'color','r')
     line([transferedForeObj(1,1),transferedForeObj(1,4)],[transferedForeObj(2,1),transferedForeObj(2,4)],'color','r')
    end
     
    for i=1:13
        num = num2str(i-1);
        text(transferedEstimatedVertex(1,i),transferedEstimatedVertex(2,i),num,'color','red')
    end
    % Drawing lines for foreobject (to be implemented)
    xlabel('x')
    ylabel('y')
    %hold off


    a = zeros(3,1);
    a(1,1) = estimatedVertex(1,2);
    a(2,1) = estimatedVertex(2,2);
    a(3,1) = estimatedVertex(3,2);
    b = zeros(3,1);
    b(1,1) = estimatedVertex(1,3);
    b(2,1) = estimatedVertex(2,3);
    b(3,1) = estimatedVertex(3,3);
    c = zeros(3,1);
    c(1,1) = estimatedVertex(1,8);
    c(2,1) = estimatedVertex(2,8);
    c(3,1) = estimatedVertex(3,8);
    d = zeros(3,1);
    d(1,1) = estimatedVertex(1,9);
    d(2,1) = estimatedVertex(2,9);
    d(3,1) = estimatedVertex(3,9);
    v1 = getInitialScreenCoordinates(a);
    v2 = getInitialScreenCoordinates(b);
    v7 = getInitialScreenCoordinates(c);
    v8 = getInitialScreenCoordinates(d);
    

    %figure   
    line([v1(1,1),v2(1,1)],[v1(2,1),v2(2,1)],'color','b');
    % hold on
    line([v2(1,1),v8(1,1)],[v2(2,1),v8(2,1)],'color','b');
    line([v8(1,1),v7(1,1)],[v8(2,1),v7(2,1)],'color','b');
    line([v7(1,1),v1(1,1)],[v7(2,1),v1(2,1)],'color','b');   
    line([estimatedVertex(4,2),estimatedVertex(4,3)],[estimatedVertex(5,2),estimatedVertex(5,3)],'color','red');
    line([estimatedVertex(4,3),estimatedVertex(4,9)],[estimatedVertex(5,3),estimatedVertex(5,9)],'color','red');
    line([estimatedVertex(4,9),estimatedVertex(4,8)],[estimatedVertex(5,9),estimatedVertex(5,8)],'color','red');
    line([estimatedVertex(4,8),estimatedVertex(4,2)],[estimatedVertex(5,8),estimatedVertex(5,2)],'color','red');
    hold off
    
a=get(handles.slider3,'Value');
a=num2str(a);
set(handles.show_theta,'String',['Horizontal rotation angle' 'theta is ' a]);


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in radiobutton8.
function radiobutton8_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global rough_coefficient
rough_coefficient = 0.05;

% Hint: get(hObject,'Value') returns toggle state of radiobutton8



% --- Executes on button press in radiobutton9.
function radiobutton9_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton9
global rough_coefficient
rough_coefficient = 0.01;


% --- Executes on button press in radiobutton10.
function radiobutton10_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton10
global rough_coefficient
rough_coefficient = 0.005;


% --- Executes on button press in radiobutton11.
function radiobutton11_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton11
global rough_coefficient
msgbox('This will take hours'); 
rough_coefficient = 0.001;
