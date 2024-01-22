% Visualizzazione grafica dei dati raccolti dalla camera
clear all
close all
addpath('utilities\')
addpath('data\')

% Profilo filari 
load pointData.mat

start_p = 150;
end_p = 450;

[dataz, rows, row_mean]= points_profile (pcloud, 720/2 , 10, start_p, end_p);

%% Pointcloud
%show_pclouds



