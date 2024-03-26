clear all
close all

% Lectura de imágenes

folderC = uigetdir('C:\my\NIFTI');

cd(folderC)

d = dir;

% ontenemos los datos de las modalidades

medVolT1ce = medicalVolume(d(6).name);

medVolSeg = medicalVolume(d(4).name);

% se muestra en 3D el area total y la segmentacion

viewerUnregistered = viewer3d(BackgroundColor="black",BackgroundGradient="off");
volshow(medVolT1ce, ...
    Parent=viewerUnregistered, ...
    RenderingStyle="Isosurface", ...
    IsosurfaceValue=0.05, ...
    Colormap=[1 0 1], ...
    Alphamap=1);

viewerUnregistered = viewer3d(BackgroundColor="black",BackgroundGradient="off");
volshow(medVolSeg, ...
    Parent=viewerUnregistered, ...
    RenderingStyle="Isosurface", ...
    IsosurfaceValue=0.05, ...
    Colormap=[1 0 1], ...
    Alphamap=1);