clear all
close all

% Lectura de imágenes

folderC = uigetdir('C:\my\NIFTI');

cd(folderC)

d = dir;

load('variables.mat');

% se grafican las componentes principales en 2D

figure('Name','Componentes principales 2D','NumberTitle','off')
biplot(coef(:,1:2),'scores',score(:,1:2),'varlabels',{'v_1','v_2','v_3','v_4'});

% se grafican las componentes principales en 3D

figure('Name','Componentes principales 3D','NumberTitle','off')
biplot(coef(:,1:3),'scores',score(:,1:3),'varlabels',{'v_1','v_2','v_3','v_4'});

% se grafican la nube de puntos

figure('Name','Nube de puntos','NumberTitle','off')
scatter3(score(:,1),score(:,2),score(:,3))
axis equal