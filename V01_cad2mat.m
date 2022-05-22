%==========================================================================
% Tutorial Visualization
% Topic: Convert from CAD STL ASCII format to MAT format
% Authors: M.Trifonov 
% Email: trifonov.m@yahoo.com
% Date(dd-mm-yyyy): 05-12-2022
%==========================================================================
clc; clear all; close all

filename = 'V01_example_STL.stl'; %example STL-file
flagshow = 1; % 0 or 1
flagsave = 0; % 0 or 1

%Open the CAD STL ASCII file.
fileID=fopen(filename, 'r'); 
if fileID == -1 
    error('File could not be opened')
end

% Initial data
v_num_count=0;       
report_num=0; 
V_color = 0;

while feof(fileID) == 0                   
    tline = fgetl(fileID);               
    fdata = sscanf(tline, '%s ');
    
    if strncmpi(fdata, 'c',1) == 1
       V_color = sscanf(tline, '%*s %f %f %f'); 
    end
    
    if strncmpi(fdata, 'v',1) == 1
       v_num_count = v_num_count + 1;
       report_num = report_num + 1;
       
       v(:,v_num_count) = sscanf(tline, '%*s %f %f %f'); 
       c(:,v_num_count) = V_color;              
    end                         
end
% face list
form_num = v_num_count/3;      
face_list = 1:v_num_count; 
f = reshape(face_list, 3,form_num); 
% vertex list and face list for Matlab patch command
F = f'; V = v';  C = c';

if flagsave == 1
    save ('V01_example_MAT.mat', 'F', 'V', 'C')
end

if flagshow == 1
    %plotting - patch
    figure(1);grid on
    p = patch('faces', F, 'vertices' ,V);
    set(p, 'facec', [1 0 0]);        % color     
    set(p, 'FaceVertexCData', C);  
    %set(p, 'EdgeColor','none'); 
    view(60,30);
    axis([-5 25 -25 5 -5 25]);
end
