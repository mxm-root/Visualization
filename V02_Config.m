%==========================================================================
% Tutorial Visualization
% Topic#2: Vehicle configuration in rectangle form
% Authors: M.Trifonov 
% Email: trifonov.m@yahoo.com
% Date(dd-mm-yyyy): 14-05-2022
%==========================================================================
clc; clear all; close all

% input data for the BIG rectlangle
ax1 = [-1 1];     % [x_min x_max] 
ay1 = [-1 1];     % [y_min y_max]
az1 = [-0.5 0.5]; % [z_min z_max]

% input data for the SMALL rectlangle
ax2 = [-0.5 0.5]; % [x_min x_max]
ay2 = [-1 1];     % [y_min y_max]
az2 = [-0.5 0.5]; % [z_min z_max]

% input data for the TRIANGLE
ax3 = [-0.5 0.5 0]; %[x_vert1 x_vert2 x_vert3]
ay3 = [-1 1 0];     %[y_vert1 y_vert2 y_vert3]
az3 = [-0.5 0 0];   %[z_vert1 z_vert2 z_vert3]

COG = [0 0 0]; % center of gravity of the vehicle %[COG_x COG_y COG_z]
thr  = [...
        [0.5 1 0.5]'...     %[m] %point#1
        [0.5 -1 0.5]'...    %[m] %point#2
        [-0.5 1 0]'...      %[m] %point#3
        [-0.5 -1 0]'...     %[m] %point#4
        [-0.5 1 -0.5]'...   %[m] %point#5
        [-0.5 -1 -0.5]'...  %[m] %point#6
        [0.5 0 -0.5]'...    %[m] %point#7
];
thr(1,:)=thr(1,:)+COG(1);thr(2,:)=thr(2,:)+COG(2);thr(3,:)=thr(3,:)+COG(3);

% vertices of the big rectlangle
p1=[[ax1(1) ax1(2) ax1(2) ax1(1) ax1(1) ax1(2) ax1(2) ax1(1)]+COG(1);...  
[ay1(1) ay1(1) ay1(2) ay1(2) ay1(1) ay1(1) ay1(2) ay1(2)]+COG(2);
[az1(1) az1(1) az1(1) az1(1) az1(2) az1(2) az1(2) az1(2)]+COG(3)];

%Plotting
figure(1);hold on;grid on
axis([min(p1(1,:)) max(p1(1,:)) min(p1(2,:)) max(p1(2,:)) min(p1(3,:)) max(p1(3,:))]); %+-0.2

fill3(p1(1,1:4), p1(2,1:4), p1(3,1:4), [0 0 1]);
fill3(p1(1,5:8), p1(2,5:8), p1(3,5:8), [0 0 1]);
% top and bottom planes of the big rectlangle
fill3([p1(1,1:2) p1(1,6) p1(1,5)], [p1(2,1:2) p1(2,6) p1(2,6)], [p1(3,1:2) p1(3,6) p1(3,5)], [0 0 1]);
fill3([p1(1,3:4) p1(1,8) p1(1,7)], [p1(2,3:4) p1(2,8) p1(2,7)], [p1(3,3:4) p1(3,8) p1(3,7)], [0 0 1]);
% front and back planes of the big rectlangle
fill3([p1(1,1) p1(1,4) p1(1,8) p1(1,5)], [p1(2,1) p1(2,4) p1(2,8) p1(2,5)], [p1(3,1) p1(3,4) p1(3,8) p1(3,5)], [0 0 1]);
fill3([p1(1,2:3) p1(1,7) p1(1,6)], [p1(2,2:3) p1(2,7) p1(2,6)], [p1(3,2:3) p1(3,7) p1(3,6)], [0 0 1]);
%set(gcf,'Color', [0 0 1]);
alpha(.15)

% vertices of the small rectlangle
p2=[[ax2(1) ax2(2) ax2(2) ax2(1) ax2(1) ax2(2) ax2(2) ax2(1)]+COG(1);...  
[ay2(1) ay2(1) ay2(2) ay2(2) ay2(1) ay2(1) ay2(2) ay2(2)]+COG(2);
[az2(1) az2(1) az2(1) az2(1) az2(2) az2(2) az2(2) az2(2)]+COG(3)];
% top and bottom planes of the small rectlangle
fill3(p2(1,1:4), p2(2,1:4), p2(3,1:4), [0 0 1]);
fill3(p2(1,5:8), p2(2,5:8), p2(3,5:8), [0 0 1]);
% front and back planes of the small rectlangle
fill3([p2(1,1) p2(1,4) p2(1,8) p2(1,5)], [p2(2,1) p2(2,4) p2(2,8) p2(2,5)], [p2(3,1) p2(3,4) p2(3,8) p2(3,5)], [0 0 1]);
fill3([p2(1,2:3) p2(1,7) p2(1,6)], [p2(2,2:3) p2(2,7) p2(2,6)], [p2(3,2:3) p2(3,7) p2(3,6)], [0 0 1]);
% left side and right side planes of the small rectlangle
fill3([p2(1,1:2) p2(1,6) p2(1,5)], [p2(2,1:2) p2(2,6) p2(2,6)], [p2(3,1:2) p2(3,6) p2(3,5)], [0 0 1]);
fill3([p2(1,3:4) p2(1,8) p2(1,7)], [p2(2,3:4) p2(2,8) p2(2,7)], [p2(3,3:4) p2(3,8) p2(3,7)], [0 0 1]);
fill3(p2(1,1:4), p2(2,1:4), [0 0 0 0], [0 0 1]);
xlabel('x');ylabel('y');zlabel('z');
% triangle
fill3([ax3(1) ax3(1) ax3(2)], [ay3(1) ay3(2) ay3(3)],[az3(1) az3(1) az3(1)], [1 0 0]);
alpha(.15)

% arrow3-function, see: https://de.mathworks.com/matlabcentral/fileexchange/14056-arrow3
% author: Tom Davis
Lp=0.4; % allow length
Alpha=zeros(1,7); Beta=zeros(1,7);
arrow3([thr(1,1) thr(2,1) thr(3,1)],[thr(1,1)-Lp thr(2,1)-Lp*tan(Alpha(1,1)) thr(3,1)],'v*/',1.5,3)
arrow3([thr(1,2) thr(2,2) thr(3,2)],[thr(1,2)-Lp thr(2,2)-Lp*tan(Alpha(1,2)) thr(3,2)],'v*/',1.5,3)
arrow3([thr(1,3) thr(2,3) thr(3,3)],[thr(1,3)-Lp thr(2,3)-Lp*tan(Alpha(1,3)) thr(3,3)],'v*/',1.5,3)
arrow3([thr(1,4) thr(2,4) thr(3,4)],[thr(1,4)-Lp thr(2,4)-Lp*tan(Alpha(1,4)) thr(3,4)],'v*/',1.5,3)
arrow3([thr(1,5) thr(2,5) thr(3,5)],[thr(1,5)-Lp thr(2,5)-Lp*tan(Alpha(1,5)) thr(3,5)],'v*/',1.5,3)
arrow3([thr(1,6) thr(2,6) thr(3,6)],[thr(1,6)-Lp thr(2,6)-Lp*tan(Alpha(1,6)) thr(3,6)],'v*/',1.5,3)
arrow3([thr(1,7) thr(2,7) thr(3,7)],[thr(1,7)-Lp thr(2,7)-Lp*tan(Alpha(1,7)) thr(3,7)],'v*/',1.5,3)

% text labels
plot3(thr(1,:),thr(2,:),thr(3,:),'or','LineWidth',3)
text(thr(1,1),thr(2,1),thr(3,1)+0.05,'1 - first'); 
text(thr(1,2),thr(2,2),thr(3,2)+0.05,'2 - second'); 
text(thr(1,3),thr(2,3),thr(3,3)+0.05,'3 - third'); 
text(thr(1,4),thr(2,4),thr(3,4)+0.05,'4 - fourth'); 
text(thr(1,5),thr(2,5),thr(3,5)+0.05,'5 - fifth'); 
text(thr(1,6),thr(2,6),thr(3,6)+0.05,'6 - sixth'); 
text(thr(1,7),thr(2,7),thr(3,6)+0.05,'7 - seventh'); 
% set(gca, 'Ydir', 'reverse')
% set(gca, 'Zdir', 'reverse')

view(12.72,22.0504); %[caz,cel]=view()
% axes of the coordinate system
arrow3([0 0 0],[max(p1(1,:)) 0 0],'k*/',1.5,3)
arrow3([0 0 0],[0 max(p1(2,:)) 0],'k*/',1.5,3)
arrow3([0 0 0],[0 0 max(p1(3,:))],'k*/',1.5,3)
