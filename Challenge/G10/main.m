



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

% Last Modified by GUIDE v2.5 19-Jul-2022 17:13:43

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
clear global;
global pop_up
pop_up=0;
handles.output = hObject;
warning off
delete(timerfind);
handles.ht=timer;
set(handles.ht,'ExecutionMode','fixedRate');
set(handles.ht,'Period',1);
set(handles.ht,'TimerFcn',{@dispnow, handles});
start(handles.ht);


global rough_coefficient
rough_coefficient = 0.1;


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


[filename,filepath,index] = uigetfile({'*.bpm;*.jpg;*.png;*.jpeg;*.'},'insert a picture');
if filename == 0
    msgbox('Please choose a picture','Hint','help'); 
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
imshow(image);
global pop_up
if pop_up == 0
msgbox('You can follow the Roman numerals on the right to complete the main steps in sequence');
end
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
       point_VP=findobj('MarkerFaceColor','r'); 
       %box
       global pop_up
       if pop_up == 0
       msgbox('A Vanishing point has been successfully added to the graph');
       end
       point_VP_test=point_VP;     
    else
    end

   
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
global pop_up
if pop_up == 0
 p=msgbox('Please use the mouse to draw a rectangle as inner rectangle');
 waitfor(p);
 o=msgbox('If you want to change the shape of inner rectangle, click on BG_redefine after dragging and dropping');
 waitfor(o);
end

%  global X_coordinate_matrix Y_coordinate_matrix LINE4 BG1 BG2 gradient 
 global X_VP Y_VP image innerrectangle
 global Y_coordinate_matrix X_coordinate_matrix
  innerrectangle=drawrectangle('Label','inner rectangle','Color',[0 0 1],'LabelAlpha',0.02);
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
 

 
 %Calculate the slopes from the VP point to the four vertices counterclockwise from the lower left corner(inner rectangle)
 gradient(1) = abs(Y_coordinate_matrix(1) - Y_VP_1) / abs(X_coordinate_matrix(1) - X_VP_1);
 gradient(2) = abs(Y_coordinate_matrix(2) - Y_VP_1) / abs(X_coordinate_matrix(2) - X_VP_1);
 gradient(3) = abs(Y_coordinate_matrix(8) - Y_VP_1) / abs(X_coordinate_matrix(8) - X_VP_1);
 gradient(4) = abs(Y_coordinate_matrix(7) - Y_VP_1) / abs(X_coordinate_matrix(7) - X_VP_1);


     % 3 point
     X_coordinate_matrix(3) = round(X_VP_1 - ( (size(image,1)-Y_VP_1) / gradient(1) ));
     Y_coordinate_matrix(3) = size(image,1); 
     % 5 point
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

    % 9 AND 11 point
    X_coordinate_matrix(9) = round(X_VP_1 - Y_VP_1/gradient(4));
    Y_coordinate_matrix(9) = 0;
    
    X_coordinate_matrix(11) = 0;
    Y_coordinate_matrix(11) = -1 * round(gradient(4) * X_coordinate_matrix(9));





    coordinate_matrix = [X_coordinate_matrix',Y_coordinate_matrix'];

    coordinate_matrix = [X_VP_1 Y_VP_1;coordinate_matrix];

    set(innerrectangle,'Position',[Position(1),Position(2),width,height]);

    hold on;

    plot(X_VP_1,Y_VP_1,'ro','MarkerFaceColor','r');
 

    plot(X_coordinate_matrix(2),Y_coordinate_matrix(2),'ro','MarkerFaceColor','g');
    plot(X_coordinate_matrix(7),Y_coordinate_matrix(7),'ro','MarkerFaceColor','g');
    plot(X_coordinate_matrix(8),Y_coordinate_matrix(8),'ro','MarkerFaceColor','g');
    plot(X_coordinate_matrix(1),Y_coordinate_matrix(1),'ro','MarkerFaceColor','g');


    line([X_coordinate_matrix(7),X_coordinate_matrix(8)],[Y_coordinate_matrix(7),Y_coordinate_matrix(8)],'Color','blue','LineWidth',2,'LineStyle','-');
    line([X_coordinate_matrix(8),X_coordinate_matrix(2)],[Y_coordinate_matrix(8),Y_coordinate_matrix(2)],'Color','blue','LineWidth',2,'LineStyle','-');
    line([X_coordinate_matrix(2),X_coordinate_matrix(1)],[Y_coordinate_matrix(2),Y_coordinate_matrix(1)],'Color','blue','LineWidth',2,'LineStyle','-');
    line([X_coordinate_matrix(1),X_coordinate_matrix(7)],[Y_coordinate_matrix(1),Y_coordinate_matrix(7)],'Color','blue','LineWidth',2,'LineStyle','-');

    line([X_VP_1,X_coordinate_matrix(5)],[Y_VP_1,Y_coordinate_matrix(5)],'Color','blue','LineWidth',2,'LineStyle','-')
    line([X_VP_1,X_coordinate_matrix(4)],[Y_VP_1,Y_coordinate_matrix(4)],'Color','blue','LineWidth',2,'LineStyle','-')
    line([X_VP_1,X_coordinate_matrix(10)],[Y_VP_1,Y_coordinate_matrix(10)],'Color','blue','LineWidth',2,'LineStyle','-')
    line([X_VP_1,X_coordinate_matrix(11)],[Y_VP_1,Y_coordinate_matrix(11)],'Color','blue','LineWidth',2,'LineStyle','-')
    global all_line
    all_line=findobj('LineStyle','-');

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
           global pop_up
       if pop_up == 0
    p=msgbox('If you want to change the shape of inner recktangle, you can drag the rectangular border in the figure, and then click on  Redefine inner recktangle below','Hint');
    waitfor(p);
       end






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


     
% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ButtonDown X_VP Y_VP;

   

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


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global all_line BG_obj innerrectangle
delete(innerrectangle);
delete(all_line);
delete(BG_obj);



% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla reset;
set(handles.axes1,'Visible','on');


% --- Executes on button press in Foreground_1.
function Foreground_1_Callback(hObject, eventdata, handles)
% hObject    handle to Foreground_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 hold on

 global image
        global pop_up
       if pop_up == 0
 o=msgbox('Next, the rectangle will be used to select the desired inner rectangle','Hint');
 waitfor(o);
       end
 h =drawrectangle('Label','Foreground','Color',[1 0 0],'LabelAlpha',0.01);
 Position=get(h,'Position');

xmin = Position(1);
ymin = Position(2);
width = Position(3);
height = Position(4);
point = [xmin,ymin;
         xmin+width, ymin;
         xmin+width, ymin+width;
         xmin,ymin+width];
roi = poly2mask(point(:,1),point(:,2),size(image,1),size(image,2));
L = superpixels(image,500);
 
mask = double(grabcut(image, L, roi));

image_fg= image.*mask;
 
Foreground_1= imcrop(image_fg,Position);

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
 global mask_1 
 mask_1 = double(createMask(h,image));
 mask_2 = abs(mask_1 -1);
 global new_image;

 new_image = mask_1.*image_fg + mask_2.*image;
 
 %imshow(new_image);
 


 save Foreground.mat  Foreground_1



 global Background
 Background = inpaintExemplar(image,logical(mask_1)); 
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
clear global,clc,clear,close all


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
 Foreground_2=imcrop(image,Position); % 
 save foreobj_2D_2.mat  Foreground_2
 global mask_2
 mask_2 = createMask(h);

 global Background
 Background = inpaintExemplar(Background,mask_2); 
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
 Foreground_3=imcrop(image,Position); 
 save   foreobj_2D_3.mat  Foreground_3
 global mask_3
 mask_3 = createMask(h);
 global Background
 Background = inpaintExemplar(Background,mask_3); 
 
 delete(h);
 set(handles.Foreground_3,'UserData',1);


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(handles.popupmenu3,'value');
if a == 2         % 1 is first String！！
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
global mask_1
figure
imshow(mask_1);



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

% [eye,mat] = getPerspectiveTransferMatrix();
% transferedEstimatedVertex = getTransferedEstimatedVerticesScreenCoordinates();
    
a=get(handles.slider2,'Value');
a=num2str(-a);
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
%  [eye,mat] = getPerspectiveTransferMatrix();
%   transferedEstimatedVertex = getTransferedEstimatedVerticesScreenCoordinates();  
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

    
    
     global X_VP Y_VP image innerrectangle road d_left d_up Realimage
     global Foreground_Point_1 Foreground_Point_2 Foreground_Point_3
     global Y_coordinate_matrix X_coordinate_matrix
     Position_1=get(innerrectangle,'Position');
     cla reset;
     delete(innerrectangle);

if get(handles.slider7,'Value') == 0
image = imread(road);
image = im2double(image);  
Realimage=image;
axes(handles.axes1);
imshow(image);
else
image = imread(road);
image = im2double(image);    
rank_list=get(handles.slider7,'Value');
rank_list=rank_list*10;
rr=rank(image(:,:,1));%source_red
rg=rank(image(:,:,2));%source_green
rb=rank(image(:,:,3));%source_blue
[sr vr dr]=svd(image(:,:,1));
[sg vg dg]=svd(image(:,:,2));
[sb vb db]=svd(image(:,:,3));

%re=s*v*d'; Reconstruction
rer=sr(:,:)*vr(:,1:rank_list)*dr(:,1:rank_list)';
reg=sg(:,:)*vg(:,1:rank_list)*dg(:,1:rank_list)';
reb=sb(:,:)*vb(:,1:rank_list)*db(:,1:rank_list)';
re(:,:,1)=rer;
re(:,:,2)=reg;
re(:,:,3)=reb;
image=mat2gray(re);
Realimage=image;
axes(handles.axes1);
imshow(image);
end


  Position_1=round(Position_1);
  x_left=Position_1(1);%,y_up,width,height];
  y_up=Position_1(2);
  width=Position_1(3);
  height=Position_1(4);
  X_VP_1=X_VP;
  Y_VP_1=Y_VP;

 
 
 x_right=x_left+width;
 y_down=y_up+height;

 X_coordinate_matrix(7) = x_left; 
 Y_coordinate_matrix(7) = y_up;
 X_coordinate_matrix(2) = x_right; 
 Y_coordinate_matrix(2) = y_down;
 X_coordinate_matrix(1) = x_left;
 Y_coordinate_matrix(1) = y_down;
 X_coordinate_matrix(8) = x_right;
 Y_coordinate_matrix(8) = y_up;

 gradient(1) = abs(Y_coordinate_matrix(1) - Y_VP_1) / abs(X_coordinate_matrix(1) - X_VP_1);
 gradient(2) = abs(Y_coordinate_matrix(2) - Y_VP_1) / abs(X_coordinate_matrix(2) - X_VP_1);
 gradient(3) = abs(Y_coordinate_matrix(8) - Y_VP_1) / abs(X_coordinate_matrix(8) - X_VP_1);
 gradient(4) = abs(Y_coordinate_matrix(7) - Y_VP_1) / abs(X_coordinate_matrix(7) - X_VP_1);


 

     % 3
     X_coordinate_matrix(3) = round(X_VP_1 - ( (size(image,1)-Y_VP_1) / gradient(1) ));
     Y_coordinate_matrix(3) = size(image,1); 
     % 5
     X_coordinate_matrix(5) = 0;
     Y_coordinate_matrix(5) = round(size(image,1) + X_coordinate_matrix(3)*gradient(1));

     %  6 AND 4 point_VP

     X_coordinate_matrix(6) = size(image,2);
     Y_coordinate_matrix(6) = round(Y_VP_1 + (gradient(2)*(size(image,2)-X_VP_1)));
     X_coordinate_matrix(4) = round(size(image,2) + (X_coordinate_matrix(6)-X_VP_1)*(size(image,1)-Y_coordinate_matrix(6)) / (Y_coordinate_matrix(6)-Y_VP_1));
     Y_coordinate_matrix(4) = size(image,1);

    % 12 AND 10 point

    X_coordinate_matrix(12) = size(image,2);
    Y_coordinate_matrix(12) = round(Y_VP_1 - gradient(3)*(size(image,2)-X_VP_1));

    X_coordinate_matrix(10) = round(size(image,2) + Y_coordinate_matrix(12)*(size(image,2)-X_VP_1) / (Y_VP_1 - Y_coordinate_matrix(12)));
    Y_coordinate_matrix(10) = 0;

    % 9 AND 11 point_VP

    X_coordinate_matrix(9) = round(X_VP_1 - Y_VP_1/gradient(4));
    Y_coordinate_matrix(9) = 0;
    
    X_coordinate_matrix(11) = 0;
    Y_coordinate_matrix(11) = -1 * round(gradient(4) * X_coordinate_matrix(9));

 x_left=X_coordinate_matrix(7); 
 y_up=Y_coordinate_matrix(7);
innerrectangle=drawrectangle('Position',[x_left,y_up,width,height],'StripeColor','r');

coordinate_matrix = [X_coordinate_matrix',Y_coordinate_matrix']; 
coordinate_matrix = [X_VP_1 Y_VP_1;coordinate_matrix];
   set(handles.uitable2,'data',coordinate_matrix);
 hold on;

 plot(X_VP_1,Y_VP_1,'ro','MarkerFaceColor','r');
 plot(X_coordinate_matrix(2),Y_coordinate_matrix(2),'ro','MarkerFaceColor','g');
 plot(X_coordinate_matrix(7),Y_coordinate_matrix(7),'ro','MarkerFaceColor','g');
 BG3 = plot(X_coordinate_matrix(8),Y_coordinate_matrix(8),'ro','MarkerFaceColor','g');
 BG4 = plot(X_coordinate_matrix(1),Y_coordinate_matrix(1),'ro','MarkerFaceColor','g');

 %line
 line([X_coordinate_matrix(7),X_coordinate_matrix(8)],[Y_coordinate_matrix(7),Y_coordinate_matrix(8)],'Color','blue','LineWidth',2,'LineStyle','-');
 line([X_coordinate_matrix(8),X_coordinate_matrix(2)],[Y_coordinate_matrix(8),Y_coordinate_matrix(2)],'Color','blue','LineWidth',2,'LineStyle','-');
 line([X_coordinate_matrix(2),X_coordinate_matrix(1)],[Y_coordinate_matrix(2),Y_coordinate_matrix(1)],'Color','blue','LineWidth',2,'LineStyle','-');
 line([X_coordinate_matrix(1),X_coordinate_matrix(7)],[Y_coordinate_matrix(1),Y_coordinate_matrix(7)],'Color','blue','LineWidth',2,'LineStyle','-');

line([X_VP_1,X_coordinate_matrix(5)],[Y_VP_1,Y_coordinate_matrix(5)],'Color','blue','LineWidth',2,'LineStyle','-')
line([X_VP_1,X_coordinate_matrix(4)],[Y_VP_1,Y_coordinate_matrix(4)],'Color','blue','LineWidth',2,'LineStyle','-')
line([X_VP_1,X_coordinate_matrix(10)],[Y_VP_1,Y_coordinate_matrix(10)],'Color','blue','LineWidth',2,'LineStyle','-')
line([X_VP_1,X_coordinate_matrix(11)],[Y_VP_1,Y_coordinate_matrix(11)],'Color','blue','LineWidth',2,'LineStyle','-')
global all_line
all_line=findobj('LineStyle','-');
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
       global pop_up
       if pop_up == 0
msgbox('If you have built 3D model, please rebulid');
       end
%%


% --- Executes on button press in remove_all_marks.
function remove_all_marks_Callback(hObject, eventdata, handles)
% hObject    handle to remove_all_marks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global road image Realimage
cla reset;
if get(handles.slider7,'Value') == 0
image = imread(road);
image = im2double(image);  
Realimage=image;
axes(handles.axes1);
imshow(image);
else
image = imread(road);
image = im2double(image);    
rank_list=get(handles.slider7,'Value');
rank_list=rank_list*10;
rr=rank(image(:,:,1));%source_red
rg=rank(image(:,:,2));%source_green
rb=rank(image(:,:,3));%source_blue
[sr vr dr]=svd(image(:,:,1));
[sg vg dg]=svd(image(:,:,2));
[sb vb db]=svd(image(:,:,3));

%re=s*v*d'; Reconstruction
rer=sr(:,:)*vr(:,1:rank_list)*dr(:,1:rank_list)';
reg=sg(:,:)*vg(:,1:rank_list)*dg(:,1:rank_list)';
reb=sb(:,:)*vb(:,1:rank_list)*db(:,1:rank_list)';
re(:,:,1)=rer;
re(:,:,2)=reg;
re(:,:,3)=reb;
image=mat2gray(re);
Realimage=image;
axes(handles.axes1);
imshow(image);
end

     
 
     


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
line([transferedEstimatedVertex(1,2),transferedEstimatedVertex(1,3)],[transferedEstimatedVertex(2,2),transferedEstimatedVertex(2,3)],'color','b')
    hold on
    line([transferedEstimatedVertex(1,3),transferedEstimatedVertex(1,9)],[transferedEstimatedVertex(2,3),transferedEstimatedVertex(2,9)],'color','b')
    line([transferedEstimatedVertex(1,9),transferedEstimatedVertex(1,8)],[transferedEstimatedVertex(2,9),transferedEstimatedVertex(2,8)],'color','b')
    line([transferedEstimatedVertex(1,8),transferedEstimatedVertex(1,2)],[transferedEstimatedVertex(2,8),transferedEstimatedVertex(2,2)],'color','b')
    % floor
    line([transferedEstimatedVertex(1,2),transferedEstimatedVertex(1,4)],[transferedEstimatedVertex(2,2),transferedEstimatedVertex(2,4)],'color','b')
    line([transferedEstimatedVertex(1,4),transferedEstimatedVertex(1,5)],[transferedEstimatedVertex(2,4),transferedEstimatedVertex(2,5)],'color','b')
    line([transferedEstimatedVertex(1,5),transferedEstimatedVertex(1,3)],[transferedEstimatedVertex(2,5),transferedEstimatedVertex(2,3)],'color','b')
    % left wall
    line([transferedEstimatedVertex(1,10),transferedEstimatedVertex(1,12)],[transferedEstimatedVertex(2,10),transferedEstimatedVertex(2,12)],'color','b')
    line([transferedEstimatedVertex(1,6),transferedEstimatedVertex(1,12)],[transferedEstimatedVertex(2,6),transferedEstimatedVertex(2,12)],'color','b')
    line([transferedEstimatedVertex(1,6),transferedEstimatedVertex(1,2)],[transferedEstimatedVertex(2,6),transferedEstimatedVertex(2,2)],'color','b')
    % right wall
    line([transferedEstimatedVertex(1,13),transferedEstimatedVertex(1,11)],[transferedEstimatedVertex(2,13),transferedEstimatedVertex(2,11)],'color','b')
    line([transferedEstimatedVertex(1,13),transferedEstimatedVertex(1,7)],[transferedEstimatedVertex(2,13),transferedEstimatedVertex(2,7)],'color','b')
    line([transferedEstimatedVertex(1,7),transferedEstimatedVertex(1,3)],[transferedEstimatedVertex(2,7),transferedEstimatedVertex(2,3)],'color','b')
    % ceiling
    line([transferedEstimatedVertex(1,8),transferedEstimatedVertex(1,10)],[transferedEstimatedVertex(2,8),transferedEstimatedVertex(2,10)],'color','b')
    line([transferedEstimatedVertex(1,10),transferedEstimatedVertex(1,11)],[transferedEstimatedVertex(2,10),transferedEstimatedVertex(2,11)],'color','b')
    line([transferedEstimatedVertex(1,11),transferedEstimatedVertex(1,9)],[transferedEstimatedVertex(2,11),transferedEstimatedVertex(2,9)],'color','b')
    
    
    if get(handles.Foreground_1,'UserData') == 1
     line([transferedForeObj(1,4),transferedForeObj(1,3)],[transferedForeObj(2,4),transferedForeObj(2,3)],'color','r')
     line([transferedForeObj(1,3),transferedForeObj(1,2)],[transferedForeObj(2,3),transferedForeObj(2,2)],'color','r')
     line([transferedForeObj(1,2),transferedForeObj(1,1)],[transferedForeObj(2,2),transferedForeObj(2,1)],'color','r')
     line([transferedForeObj(1,1),transferedForeObj(1,4)],[transferedForeObj(2,1),transferedForeObj(2,4)],'color','r')
    end
     
    for i=1:12
        num = num2str(i);
        text(transferedEstimatedVertex(1,i + 1),transferedEstimatedVertex(2,i + 1),num,'color','red')
    end
    % Drawing lines for foreobject (to be implemented)
    xlabel('x')
    ylabel('y')

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
    global invisFl given_foreobj rough_coefficient

theta=get(handles.slider3,'Value');
theta=-theta;   
phi=get(handles.slider2,'Value');
phi=-phi;   
[eye,mat] = getPerspectiveTransferMatrix();
transferedEstimatedVertex = getTransferedEstimatedVerticesScreenCoordinates();
global image OrIm foreObj Realimage
OrIm=image;
% rough_coefficient=0.5;
       global pop_up
       if pop_up == 0
b=msgbox('Image is being rendered, please wait,Please do not click other buttons until the picture is completed','Hint');
waitfor(b);
       end
figure
[GeIm] = DrawGeneratedImage(estimatedVertex,foreObj,Realimage,OrIm, rough_coefficient, given_foreobj);
    


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

[eye,mat] = getPerspectiveTransferMatrix();
transferedEstimatedVertex = getTransferedEstimatedVerticesScreenCoordinates(); 
 figure
   line([transferedEstimatedVertex(1,2),transferedEstimatedVertex(1,3)],[transferedEstimatedVertex(2,2),transferedEstimatedVertex(2,3)],'color','b')
    hold on
    line([transferedEstimatedVertex(1,3),transferedEstimatedVertex(1,9)],[transferedEstimatedVertex(2,3),transferedEstimatedVertex(2,9)],'color','b')
    line([transferedEstimatedVertex(1,9),transferedEstimatedVertex(1,8)],[transferedEstimatedVertex(2,9),transferedEstimatedVertex(2,8)],'color','b')
    line([transferedEstimatedVertex(1,8),transferedEstimatedVertex(1,2)],[transferedEstimatedVertex(2,8),transferedEstimatedVertex(2,2)],'color','b')
    % floor
    line([transferedEstimatedVertex(1,2),transferedEstimatedVertex(1,4)],[transferedEstimatedVertex(2,2),transferedEstimatedVertex(2,4)],'color','b')
    line([transferedEstimatedVertex(1,4),transferedEstimatedVertex(1,5)],[transferedEstimatedVertex(2,4),transferedEstimatedVertex(2,5)],'color','b')
    line([transferedEstimatedVertex(1,5),transferedEstimatedVertex(1,3)],[transferedEstimatedVertex(2,5),transferedEstimatedVertex(2,3)],'color','b')
    % left wall
    line([transferedEstimatedVertex(1,10),transferedEstimatedVertex(1,12)],[transferedEstimatedVertex(2,10),transferedEstimatedVertex(2,12)],'color','b')
    line([transferedEstimatedVertex(1,6),transferedEstimatedVertex(1,12)],[transferedEstimatedVertex(2,6),transferedEstimatedVertex(2,12)],'color','b')
    line([transferedEstimatedVertex(1,6),transferedEstimatedVertex(1,2)],[transferedEstimatedVertex(2,6),transferedEstimatedVertex(2,2)],'color','b')
    % right wall
    line([transferedEstimatedVertex(1,13),transferedEstimatedVertex(1,11)],[transferedEstimatedVertex(2,13),transferedEstimatedVertex(2,11)],'color','b')
    line([transferedEstimatedVertex(1,13),transferedEstimatedVertex(1,7)],[transferedEstimatedVertex(2,13),transferedEstimatedVertex(2,7)],'color','b')
    line([transferedEstimatedVertex(1,7),transferedEstimatedVertex(1,3)],[transferedEstimatedVertex(2,7),transferedEstimatedVertex(2,3)],'color','b')
    % ceiling
    line([transferedEstimatedVertex(1,8),transferedEstimatedVertex(1,10)],[transferedEstimatedVertex(2,8),transferedEstimatedVertex(2,10)],'color','b')
    line([transferedEstimatedVertex(1,10),transferedEstimatedVertex(1,11)],[transferedEstimatedVertex(2,10),transferedEstimatedVertex(2,11)],'color','b')
    line([transferedEstimatedVertex(1,11),transferedEstimatedVertex(1,9)],[transferedEstimatedVertex(2,11),transferedEstimatedVertex(2,9)],'color','b')
    
    % scatter3(transferedEstimatedVertex(1,:),transferedEstimatedVertex(2,:),'color','g')
    if get(handles.Foreground_1,'UserData') == 1
     line([transferedForeObj(1,4),transferedForeObj(1,3)],[transferedForeObj(2,4),transferedForeObj(2,3)],'color','r')
     line([transferedForeObj(1,3),transferedForeObj(1,2)],[transferedForeObj(2,3),transferedForeObj(2,2)],'color','r')
     line([transferedForeObj(1,2),transferedForeObj(1,1)],[transferedForeObj(2,2),transferedForeObj(2,1)],'color','r')
     line([transferedForeObj(1,1),transferedForeObj(1,4)],[transferedForeObj(2,1),transferedForeObj(2,4)],'color','r')
    end
     
 for i=1:12
        num = num2str(i);
        text(transferedEstimatedVertex(1,i + 1),transferedEstimatedVertex(2,i + 1),num,'color','red')
    end
    % Drawing lines for foreobject (to be implemented)
    xlabel('x')
    ylabel('y')

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
rough_coefficient = 0.1;

% Hint: get(hObject,'Value') returns toggle state of radiobutton8



% --- Executes on button press in radiobutton9.
function radiobutton9_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton9
global rough_coefficient
rough_coefficient = 0.05;


% --- Executes on button press in radiobutton10.
function radiobutton10_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton10
global rough_coefficient
rough_coefficient = 0.01;


% --- Executes on button press in radiobutton11.
function radiobutton11_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton11
global rough_coefficient pop_up
if pop_up == 0
msgbox('This will take hours'); 
end
rough_coefficient = 0.005;


% --- Executes during object creation, after setting all properties.
function pushbutton18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image Realimage road
cla reset;
image = imread(road);
image = im2double(image);
rank_list=10;
rank_list=get(handles.slider7,'Value');
rank_list=rank_list*10;
rr=rank(image(:,:,1));%source_red
rg=rank(image(:,:,2));%source_green
rb=rank(image(:,:,3));%source_blue
[sr vr dr]=svd(image(:,:,1));
[sg vg dg]=svd(image(:,:,2));
[sb vb db]=svd(image(:,:,3));

%re=s*v*d'; Reconstruction
rer=sr(:,:)*vr(:,1:rank_list)*dr(:,1:rank_list)';
reg=sg(:,:)*vg(:,1:rank_list)*dg(:,1:rank_list)';
reb=sb(:,:)*vb(:,1:rank_list)*db(:,1:rank_list)';
re(:,:,1)=rer;
re(:,:,2)=reg;
re(:,:,3)=reb;
image=mat2gray(re);
Realimage=image;
axes(handles.axes1);
imshow(image);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in radiobutton12.
function radiobutton12_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hint: get(hObject,'Value') returns toggle state of radiobutton12


% --- Executes on button press in radiobutton13.
function radiobutton13_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pop_up
pop_up=1;

% Hint: get(hObject,'Value') returns toggle state of radiobutton13


% --- Executes during object creation, after setting all properties.
function pushbutton9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
