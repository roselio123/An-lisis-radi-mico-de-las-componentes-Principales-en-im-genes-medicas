clear all
close all

% Lectura de imágenes

folderC = uigetdir('C:\my\NIFTI');

cd(folderC)

d = dir;

% cargamos los datos de la radiomica
load('radiomica_cc.mat');

% visualizamos las caracteristicas de las modalidades
f = size(SM,2)
figure('Name','Forma modalidades','NumberTitle','off',Position=[0 0 1500 500])
tiledlayout(1,f + 1)
for i = 1:f
    nexttile
    imagesc(SM(:,i))
    xticklabels({})
    yticklabels({})
    ylabel(featureNamessm{i})
end

f = size(IM,2)
figure('Name','Intensidad modalidades','NumberTitle','off',Position=[0 0 1500 500])
tiledlayout(1,f + 1)
for i = 1:f
    nexttile
    imagesc(IM(:,i))
    xticklabels({})
    yticklabels({})
    ylabel(featureNamesim{i})
end

f = size(TM,2)
figure('Name','Textura modalidades','NumberTitle','off',Position=[0 0 1500 500])
tiledlayout(1,f + 1)
for i = 1:f
    nexttile
    imagesc(TM(:,i))
    xticklabels({})
    yticklabels({})
    ylabel(featureNamestm{i})
end

% visualizamos las caracteristicas de las componentes
f = size(SC,2)
figure('Name','Forma componentes','NumberTitle','off',Position=[0 0 1500 500])
tiledlayout(1,f + 1)
for i = 1:f
    nexttile
    imagesc(SC(:,i))
    xticklabels({})
    yticklabels({})
    ylabel(featureNamessc{i})
end

f = size(IC,2)
figure('Name','Intensidad componentes','NumberTitle','off',Position=[0 0 1500 500])
tiledlayout(1,f + 1)
for i = 1:f
    nexttile
    imagesc(IC(:,i))
    xticklabels({})
    yticklabels({})
    ylabel(featureNamesic{i})
end

f = size(TC,2)
figure('Name','Textura componentes','NumberTitle','off',Position=[0 0 1500 500])
tiledlayout(1,f + 1)
for i = 1:f
    nexttile
    imagesc(TC(:,i))
    xticklabels({})
    yticklabels({})
    ylabel(featureNamestc{i})
end
