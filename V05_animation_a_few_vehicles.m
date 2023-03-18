%==========================================================================
% Tutorial Visualization
% Topic#5: Animation of a few vehicles motion
% Authors: M.Trifonov 
% Email: trifonov.m@yahoo.com
% Date(dd-mm-yyyy): 15-01-2022
%==========================================================================
clc;clear;close all;
% Case study, input data
load('V03_example_MAT.mat')
% === first vehicle ===
% vertices
V=[-V(:,2) V(:,1) V(:,3)]; % order and plus/minus-sign can change
% position [m]
Z=155+5*sin(0.08*(0:45*pi));
X=0:1:(length(Z)-1);
Y=zeros(1,length(Z));
%Euler's angles [rad]
Pi = zeros(1,length(X));  %pitch [rad]
Ro = zeros(1,length(X));  %roll [rad]
Ya = zeros(1,length(X));  %yaw [rad]
% === second vehicle ===
% vertices
V2=V;F2=F;C2=C;
% position
Zc=140+7*sin(0.01*(0:45*pi));
Xc=5:1:(length(Zc)+4);
Yc=zeros(1,length(Zc));
% Euler's angles [rad]
Pic = zeros(1,length(X));  %pitch [rad]
Roc = zeros(1,length(X));  %roll [rad]
Yac = zeros(1,length(X));  %yaw [rad]

% plotting
videomaker(X',Y',Z',Xc',Yc',Zc',Pi',Ro',Ya',Pic',Roc',Yac',V,F,C,V2,F2,C2,25,25,0);

function videomaker(x,y,z,xc,yc,zc,P,R,Y,Pc,Rc,Yc,V1,F1,C1,V2,F2,C2,scale1,scale2,flagvideo)
%=========================================================================
%Author: Maksim Trifonov
%Email: trifonov.m@yahoo.com
%Last update (dd/mm/yyyy): 18/03/2023
%=========================================================================
%     x,y,z            trajectory of center of mass                       [m]
%     P,R,Y            pitch,roll,yaw (euler's angles)                    [rad]
%     V,F,C            vertex list and face list (see cad2mat-function)
%     scale1, scale2   normalization factor for vehicle#1, vehicle#2
%     flagvideo        1-yes, 0-no
%
% vehicle#1
V1(:,1)=V1(:,1)-round(sum(V1(:,1))/size(V1,1));
V1(:,2)=V1(:,2)-round(sum(V1(:,2))/size(V1,1));
V1(:,3)=V1(:,3)-round(sum(V1(:,3))/size(V1,1));
V1=V1./scale1;
% vehicle#2
V2(:,1)=V2(:,1)-round(sum(V2(:,1))/size(V2,1));
V2(:,2)=V2(:,2)-round(sum(V2(:,2))/size(V2,1));
V2(:,3)=V2(:,3)-round(sum(V2(:,3))/size(V2,1));
V2=V2./scale2;  

clf;
subplot(2,1,2);
set(gca,'Color',[.2 .4 .9]);
view(57.6,8.2);
axis([-10 180 -10 10 130 190]);grid on;
drawnow

p1 = patch('faces', F1, 'vertices' ,V1);
set(p1, 'facec', [1 0 0]);             % Set the face color (force it)%
set(p1, 'FaceVertexCData', C1);       % Set the color (from file)
set(p1, 'EdgeColor','none');         % Set the edge color
light                               % add a default light
daspect([1 1 1])                    % Setting the aspect ratio  
xlabel('\itx \rm(\itm\rm)'); ylabel('\ity \rm(\itm\rm)');zlabel('\itz \rm(\itm\rm)');

p2 = patch('faces', F2, 'vertices' ,V2);
%set(p2, 'facec', [0 1 0]);             % Set the face color 
set(p2, 'facec', 'flat');              % Set the face color flat
set(p2, 'FaceVertexCData', C2);        % Set the color (from file)
%set(p2, 'facealpha',.4)                % Use for transparency%
set(p2, 'EdgeColor','none');           % Set the edge color
light                                  % add a default light
daspect([1 1 1])                       % Setting the aspect ratio

jj=0;
for i = 1:3:length(P)

    jj = jj + 1;
    xx(jj) = x(i,1);
    zz(jj) = z(i,1);
    xxc(jj) = xc(i,1);
    zzc(jj) = zc(i,1);
    drawnow
    subplot(2,1,1);axis([-10 180 130 190])
    subplot(2,1,1);plot(xx,zz,':g','Linewidth',2),grid on,hold on;
    subplot(2,1,1);plot(xxc,zzc,':r','Linewidth',2),grid on,hold on;
    subplot(2,1,1);title('Visualization of two vehicles motion');grid on;
    subplot(2,1,1);xlabel('\itrange \rm(\itm\rm)');ylabel('\itz \rm(\itm\rm)');
    
    % vehicle#1
    theta=P(i,1);
    phi=R(i,1);
    psi=Y(i,1);
    Tbe=[cos(psi)*cos(theta) sin(psi)*cos(theta) -sin(theta);((cos(psi)*sin(theta)*sin(phi))-(sin(psi)*cos(phi))) ((sin(psi)*sin(theta)*sin(phi))+(cos(psi)*cos(phi))) cos(theta)*sin(phi);((cos(psi)*sin(theta)*cos(phi))+(sin(psi)*sin(phi))) ((sin(psi)*sin(theta)*cos(phi))-(cos(psi)*sin(phi))) cos(theta)*cos(phi)];
    Vnew=V1*Tbe;
    rif=[x(i,1) y(i,1) z(i,1)];
    X0=repmat(rif,size(Vnew,1),1);
    Vnew=Vnew+X0;

    % vehicle#2
    theta=Pc(i,1);
    phi=Rc(i,1);
    psi=Yc(i,1);
    Tbe=[cos(psi)*cos(theta) sin(psi)*cos(theta) -sin(theta);((cos(psi)*sin(theta)*sin(phi))-(sin(psi)*cos(phi))) ((sin(psi)*sin(theta)*sin(phi))+(cos(psi)*cos(phi))) cos(theta)*sin(phi);((cos(psi)*sin(theta)*cos(phi))+(sin(psi)*sin(phi))) ((sin(psi)*sin(theta)*cos(phi))-(cos(psi)*sin(phi))) cos(theta)*cos(phi)];
    Vnewc=V2*Tbe;
    rifc=[xc(i,1) yc(i,1) zc(i,1)];
    X0c=repmat(rifc,size(Vnewc,1),1);
    Vnewc=Vnewc+X0c;

    drawnow
    subplot(2,1,2);axis([-10 180 -10 10 130 190])
    subplot(2,1,2);view(57.6,8.2)
    subplot(2,1,2);set(gca,'Color',[.2 .4 .9]); 
    subplot(2,1,2);set(p1,'Vertices',Vnewc)
    M(1,i) = getframe(gcf);
    subplot(2,1,2);set(p2,'Vertices',Vnew)
    M(2,i) = getframe(gcf);
end

if flagvideo==1
    v = VideoWriter('Video_V05', 'MPEG-4');
    v.Quality = 100;
    v.FrameRate = 40;
    
    open(v);
    for j=4:3:length(M) 
        writeVideo(v,M(1:2,j))
    end
    close(v);
end

end