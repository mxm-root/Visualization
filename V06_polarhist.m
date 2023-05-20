%==========================================================================
% Tutorial Visualization
% Topic#6: Polar histogram - Wind rose
% Authors: M.Trifonov 
% Email: trifonov.m@yahoo.com
% Date(dd-mm-yyyy): 21-05-2023
%==========================================================================
clc;clear;close all;
%Load data
load('V06_example_MAT.mat')
% calculate center of each direction: N,NE,E,SE,S,SW,W,NW
diredges=-22.5:45:337.5;
% typical histogram of directions
figure(1)
h1=histogram(direction,diredges,'Normalization','probability'); 
xticks(0:45:315); xticklabels({'N','NE','E','SE','S','SW','W','NW'});
xlabel('Direction'); ylabel('Probability');
title('Wind  Direction Probability');
% polar histogram of directions with probability
figure(2)
h2=polarhistogram(direction*pi/180,'BinLimits',[-22.5*pi/180 337.5*pi/180],'BinWidth',pi/4,'Normalization','probability','DisplayStyle','stairs','Linewidth',2);
thetaticks(0:45:315); thetaticklabels({'N','NE','E','SE','S','SW','W','NW'});
title('Wind Direction Probability');