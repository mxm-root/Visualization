%==========================================================================
% Tutorial Visualization
% Topic#4: Animation of a vehicle motion
% Authors: M.Trifonov 
% Email: trifonov.m@yahoo.com
% Date(dd-mm-yyyy): 08-01-2022
%==========================================================================
clc;clear;close all;
% Case study, input data
load('V03_example_MAT.mat')
% vertices
V=[-V(:,2) V(:,1) V(:,3)]; % order and plus/minus-sign can change
% position [m]
Z=155+5*sin(0.08*(0:50*pi));
X=0:1:(length(Z)-1);
Y=zeros(1,length(Z));
%Euler's angles [rad]
Pi = zeros(1,length(X));  %pitch [rad]
Ro = zeros(1,length(X));  %roll [rad]
Ya = zeros(1,length(X));  %yaw [rad]

% plotting
videomaker(X',Y',Z',Pi',Ro',Ya',V,F,C,25,0);

% ===== videomaker ======
function videomaker(x,y,z,P,R,Y,V1,F1,C1,scale1,flagvideo)
%=========================================================================
%Author: Maksim Trifonov
%Email: trifonov.m@yahoo.com
%Last update (dd/mm/yyyy): 08/03/2023
%=========================================================================
%     x,y,z            trajectory of center of mass                       [m]
%     P,R,Y            pitch,roll,yaw (euler's angles)                    [rad]
%     V,F,C            vertex list and face list (see cad2mat-function)
%     scale1           normalization factor 
%     flagvideo        1-yes, 0-no
%
% shuttle
V1(:,1)=V1(:,1)-round(sum(V1(:,1))/size(V1,1));
V1(:,2)=V1(:,2)-round(sum(V1(:,2))/size(V1,1));
V1(:,3)=V1(:,3)-round(sum(V1(:,3))/size(V1,1));
V1=V1./scale1;  

clf;
set(gca,'Color',[.2 .4 .9]);
view(57.6,8.2);
axis([-10 180 -10 10 130 190]);grid on;
drawnow

p = patch('faces', F1, 'vertices' ,V1);

set(p, 'facec', 'flat');            % Set the face color flat
set(p, 'FaceVertexCData', C1);       % Set the color (from file)
%set(p, 'facealpha',.4)             % Use for transparency%
set(p, 'EdgeColor','none');         % Set the edge color
light                               % add a default light
daspect([1 1 1])                    % Setting the aspect ratio
xlabel('\itx \rm(\itm\rm)'); ylabel('\ity \rm(\itm\rm)');zlabel('\itz \rm(\itm\rm)');

jj=57.6;
for i = 1:1:(length(P)+90)
    if i<length(P)
    theta=P(i,1);
    phi=R(i,1);
    psi=Y(i,1);
    Tbe=[cos(psi)*cos(theta) sin(psi)*cos(theta) -sin(theta);((cos(psi)*sin(theta)*sin(phi))-(sin(psi)*cos(phi))) ((sin(psi)*sin(theta)*sin(phi))+(cos(psi)*cos(phi))) cos(theta)*sin(phi);((cos(psi)*sin(theta)*cos(phi))+(sin(psi)*sin(phi))) ((sin(psi)*sin(theta)*cos(phi))-(cos(psi)*sin(phi))) cos(theta)*cos(phi)];
    Vnew=V1*Tbe;
    rif=[x(i,1) y(i,1) z(i,1)+10];
    X0=repmat(rif,size(Vnew,1),1);
    Vnew=Vnew+X0;

    drawnow
    axis([-10 180 -10 10 130 190])
    view(jj,1);
    set(gca,'Color',[.2 .4 .9]); 
    set(p,'Vertices',Vnew)
    M(1,i) = getframe(gcf);
    else
        jj=jj+1;
        drawnow
        axis([140 180 -10 10 130 190])
        view(jj,5);
        set(gca,'Color',[.2 .4 .9]); 
        set(gca,'XTick',[],'YTick',[],'ZTick',[])
        set(p,'Vertices',Vnew)
        M(1,i) = getframe(gcf);
    end
end

if flagvideo==1
    v = VideoWriter('Video_V04', 'MPEG-4');
    v.Quality = 100;
    v.FrameRate = 40;
    
    open(v);
    for j=4:1:length(M) 
        writeVideo(v,M(1,j))
    end
    close(v);
end

end