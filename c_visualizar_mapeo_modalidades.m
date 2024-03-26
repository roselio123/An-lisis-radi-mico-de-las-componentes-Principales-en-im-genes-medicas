clear all
close all

% Lectura de imágenes

folderC = uigetdir('C:\my\NIFTI');

cd(folderC)

d = dir;

% ontenemos los datos del caso y el segmento de interes

medVolSeg = medicalVolume(d(4).name);

medVolT1ce = medicalVolume(d(6).name);

% se muestra el mapeo de todos los cortes

figure('Name','Caso','NumberTitle','off')
montage(medVolT1ce)

figure('Name','Segmentado','NumberTitle','off')
montage(medVolSeg)