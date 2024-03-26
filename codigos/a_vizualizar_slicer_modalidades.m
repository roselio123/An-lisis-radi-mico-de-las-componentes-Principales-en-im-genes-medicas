clear all
close all

% Lectura de imágenes

folderC = uigetdir('C:\my\NIFTI');

cd(folderC)

d = dir;

% ontenemos los datos de las modalidades

dataFlair = double(niftiread(d(3).name));
infoFlair = niftiinfo(d(3).name);

dataSeg = double(niftiread(d(4).name));
infoSeg = niftiinfo(d(4).name);

dataT1 = double(niftiread(d(5).name));
infoT1 = niftiinfo(d(5).name);

dataT1ce = double(niftiread(d(6).name));
infoT1C = niftiinfo(d(6).name);

dataT2 = double(niftiread(d(7).name));
infoT2 = niftiinfo(d(7).name);

[~,~,Nc] = size(dataT1);

% Se muestran las diferentes modalidades de imágenes en los 3 cortes

figure('Name','Flair','NumberTitle','off')
imshow3Dfull(dataFlair)

figure('Name','T1','NumberTitle','off')
imshow3Dfull(dataT1)

figure('Name','T1 con contraste','NumberTitle','off')
imshow3Dfull(dataT2)

figure('Name','T2','NumberTitle','off')
imshow3Dfull(dataT1ce)

figure('Name','Segmentado','NumberTitle','off')
imshow3Dfull(dataSeg)
