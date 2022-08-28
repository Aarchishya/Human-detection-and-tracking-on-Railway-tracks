clc;
load('detector1.mat');

I1=imread('C:\Users\Aarchishya Kapoor\Desktop\capstone\frame\frame247.jpg');

I=rgb2gray(I1);
J=edge(I,'Canny',[0.15 0.3]);
s=size(J);
u=s(1,1);
v=s(1,2);
y=[2*u/5 u u 2*u/5];%h
x=[v/2 v/4 3*v/4 v/2];%w
mask=poly2mask(x,y,u,v);
f=J.*mask;
y1=[0 u u 0];%h
x1=[0 0 v/2 v/2];%w
mask1=poly2mask(x1,y1,u,v);
f1=f.*mask1;
[H,T,R]=hough(f1);
y2=[0 u u 0];%h
x2=[v/2 v/2 v v];%w
mask2=poly2mask(x2,y2,u,v);
f2=f.*mask2;
[H,T,R]=hough(f1,'RhoResolution',2,'ThetaResolution',5);
P=houghpeaks(H,5,'threshold',ceil(0.5*max(H(:))));
lines1=houghlines(f1,T,R,P,'FillGap',15,'MinLength',7);

[H2,T2,R2]=hough(f2,'RhoResolution',2,'ThetaResolution',5);
P2=houghpeaks(H2,5,'threshold',ceil(0.5*max(H2(:))));
lines2=houghlines(f2,T2,R2,P2,'FillGap',15,'MinLength',7);

figure(6)
imshow(I);
title('0.6');

max_len1=0;
max_len2=0;
%AA1=zeros(1,length(lines1));
%AA2=zeros(1,length(lines2));
for k=1:length(lines1)
len1=norm(lines1(k).point1-lines1(k).point2);
xy1=[lines1(k).point1;lines1(k).point2];
if(len1>max_len1)
    max_len1=len1;
    xy_long=xy1;
end
end

for k=1:length(lines2)
len2=norm(lines2(k).point1-lines2(k).point2);
xy2=[lines2(k).point1;lines2(k).point2];
if(len2>max_len2)
    max_len2=len2;
    xy_2=xy2;
end
end

%for k=1:length(lines1)
 %   disp(k);
  %  xy=[lines1(k).point1;lines1(k).point2];
   % len=norm(lines(k).point1-lines(k).point2);
    %disp(xy(1,2));
    %if(xy(1,2)<=(v/2))
     %       AA1(1,k)=len;
    %else
     %   AA2(1,k)=len;
    %end
%end
%[max_len1,idx]=max(AA1);
%for k=1:length(lines)
%if(AA1(1,k)==max_len1)
 %       xy_long=[lines(k).point1;lines(k).point2];
  %      end
%end
%[max_len2,idx]=max(AA2);
%for k=1:length(lines)
%if(AA2(1,k)==max_len2)
 %       xy2=[lines(k).point1;lines(k).point2];
  %      end
%end

    %[ee,ff]=max(AA);
    %xy2=[lines(ff).point1;lines(ff).point2];
     %plot(xy_long(:,1),xy_long(:,2)+[20; 150],'LineWidth',2,'Color','green');%
     %plot(xy_2(:,1),xy_2(:,2)+[-10; -20],'LineWidth',2,'Color','green');
     
     
     
     
h1=imread('C:\Users\Aarchishya Kapoor\Desktop\capstone\frame\frame739.jpg');
I1=imread('C:\Users\Aarchishya Kapoor\Desktop\capstone\frame\frame194.jpg');
I=rgb2hsv(I1);
h=rgb2hsv(h1);
%figure(1)
%imshow(I1);
II=I(:,:,3);
HH=h(:,:,3);
for i=1:360
    for j=1:450
        if((II(i,j)<=1) && (II(i,j)>0.85))
            II(i,j)=II(i,j);
        else
           II(i,j)=0;
        end
    end
end

for i=1:360
    for j=1:450
        if((HH(i,j)<=1) && (HH(i,j)>0.12))
            HH(i,j)=HH(i,j);
        else
           HH(i,j)=0;
        end
    end
end
%figure(2)
%imshow(II);

s=size(II);
u=s(1,1);
v=s(1,2);
y=[2*u/5 u u 1*u/3 2*u/5];%h
x=[v/2 v/3 v v v/2];%w
mask=poly2mask(x,y,u,v);
f=II.*mask;
%figure(2);
%imshow(mask);
hh=HH.*mask;
hh=1-hh;

for i=1:360
  for  j=1:450
if(hh(i,j)<1)
    hh(i,j)=0;
end
end
end
f=f.*hh;

[bbox, score, label] = detect(detector1,f)
%Display detection results.
%detectedImg = insertObjectAnnotation(I1,'Rectangle',bbox);
%detectedImg = insertShape(I1,'Rectangle',bbox);
%figure(3)
%imshow(detectedImg)

% Display detection results
label_str = cell(1,1);
%conf_val = [score];
conf_lab = [label];
%for ii=1:3
    label_str =[sprintf('%s',conf_lab)];
%end
position = [bbox];
outputImage = insertObjectAnnotation(I1,'rectangle',position,label_str,...
    'TextBoxOpacity',0.9,'FontSize',10);
figure(4)
imshow(outputImage)
hold on
plot(xy_long(:,1),xy_long(:,2)+[20; 150],'LineWidth',2,'Color','green');%
     plot(xy_2(:,1),xy_2(:,2)+[-10; -20],'LineWidth',2,'Color','green');
