clear all
close all

% Lectura de imágenes

folderC = uigetdir('C:\my\NIFTI');

cd(folderC)

d = dir;

dataC1 = double(niftiread(d(8).name));
infoC1 = niftiinfo(d(8).name);

dataC2 = double(niftiread(d(9).name));
infoC2 = niftiinfo(d(9).name);

dataC3 = double(niftiread(d(10).name));
infoC3 = niftiinfo(d(10).name);

dataC4 = double(niftiread(d(11).name));
infoC4 = niftiinfo(d(11).name);

% visualizamos las 4 componentes principales

figure('Name','PC1','NumberTitle','off')
imshow3Dfull(dataC1)

figure('Name','PC2','NumberTitle','off')
imshow3Dfull(dataC2)

figure('Name','PC3','NumberTitle','off') 
imshow3Dfull(dataC3)

figure('Name','PC4','NumberTitle','off') 
imshow3Dfull(dataC4)