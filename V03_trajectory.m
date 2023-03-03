%==========================================================================
% Tutorial Visualization
% Topic#3: Vehicle trajectory
% Authors: M.Trifonov 
% Email: trifonov.m@yahoo.com
% Date(dd-mm-yyyy): 04-12-2021
%==========================================================================
clc;clear;close all;
% Case study, input data
load('V03_example_MAT.mat')
V=[-V(:,2) V(:,1) V(:,3)]; % order and plus/minus-sign can change
%coordinates [m]
Z=50+10*sin(0.1*(0:50*pi));
X=0:1:(length(Z)-1);
Y=zeros(1,158);
%Euler's angles [rad]
Pi = zeros(1,length(X));  %pitch [rad]
Ro = zeros(1,length(X));  %roll [rad]
Ya = zeros(1,length(X));  %yaw [rad]

% plotting
figure(1);hold on;
traj_func(X,Y,Z,Pi,Ro,Ya,0.25,25,V,F,C,[0 1 0],[0 0 1]) %see below
axis([-10 170 -10 10 30 70])

function traj_func(x,y,z,pitch,roll,yaw,scale,step,V,F,C,color,color2)
%   x,y,z               trajectory of center of mass  [m]
%   pitch,roll,yaw      Euler's angles                [rad]
%   scale               normalization factor          [-]
%   step                attitude sampling factor      [-]
%   V,F,C               vertex list and face list     [-]
%   color               color of vehicle              [-]
%   color               color of trajectory           [-]

if step<1
    step=1;
end

if nargin<13 || nargin>13
    disp('Error:');
    disp('Error: Invalid Number Inputs!');
    return;
end

V(:,1)=V(:,1)-round(sum(V(:,1))/size(V,1));
V(:,2)=V(:,2)-round(sum(V(:,2))/size(V,1));
V(:,3)=V(:,3)-round(sum(V(:,3))/size(V,1));
 
correction=max(abs(V(:,1)));

V=V./(scale*correction);
ii=length(x);
resto=mod(ii,step);

for i=1:step:(ii-resto)
theta=pitch(i);
phi=roll(i);
psi=yaw(i);
Tbe=[cos(psi)*cos(theta) sin(psi)*cos(theta) -sin(theta);((cos(psi)*sin(theta)*sin(phi))-(sin(psi)*cos(phi))) ((sin(psi)*sin(theta)*sin(phi))+(cos(psi)*cos(phi))) cos(theta)*sin(phi);((cos(psi)*sin(theta)*cos(phi))+(sin(psi)*sin(phi))) ((sin(psi)*sin(theta)*cos(phi))-(cos(psi)*sin(phi))) cos(theta)*cos(phi)];

Vnew=V*Tbe;
rif=[x(i) y(i) z(i)];

X0=repmat(rif,size(Vnew,1),1);
Vnew=Vnew+X0;

p=patch('faces', F, 'vertices' ,Vnew);
set(p, 'facec', color);          
set(p, 'FaceVertexCData', C);  
set(p, 'EdgeColor','none'); 
hold on;

end
hold on;
plot3(x,y,z,'Color',color2);light;grid on;
view(82.50,2);
daspect([1 1 1]);

xlabel('\itx \rm(\itm\rm)');
ylabel('\ity \rm(\itm\rm)');
zlabel('\itz \rm(\itm\rm)');

end
