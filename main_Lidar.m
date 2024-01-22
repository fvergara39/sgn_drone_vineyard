% Visualizzazione grafica dei dati raccolti dal LiDAR 
clear all
close all

addpath('utilities\')
addpath('data\')

% Profilo filari
load scanData.mat

start_s = 185;
end_s = 400;

[all_distance,yd,zd,angles,ranges] = scans_profile(scanStructs,3*pi/4, 5*pi/4,start_s,end_s);

%% Valutazione della posizione rispetto ai filari
geomMethod = 1;
drawPlot = 0;

geometric_positionCheck
cluster_positionCheck

% Plot
%Rappresentazione rispetto al frame del drone {D}
drone_pov
%Rappesentazione in Spatial {S}
spatial_pov






