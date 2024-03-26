clear all
close all

% Lectura de imágenes caso A

folderC = uigetdir('C:\my\NIFTI');

cd(folderC)

d = dir;

% se detecta la informacion del caso A

fixedMRIVolume = medicalVolume(d(3).name)

% Lectura de imágenes caso B

folderC = uigetdir('C:\my\NIFTI');

cd(folderC)

d = dir;

% se detecta la informacion del caso B

movingCTVolume = medicalVolume(d(3).name)

% sew obtienen los niveles de intensidad, voxels
fixedMRIVoxels = fixedMRIVolume.Voxels;

movingCTVoxels = movingCTVolume.Voxels;

% se obtiene la referencia espacial de los conjuntos
fixedVolumeSize = fixedMRIVolume.VolumeGeometry.VolumeSize;

movingVolumeSize = movingCTVolume.VolumeGeometry.VolumeSize;

centerFixed = fixedVolumeSize/2;

centerMoving = movingVolumeSize/2;

% definimos un espacio de referencia
fixedVoxelSpacing = fixedMRIVolume.VoxelSpacing;

movingVoxelSpacing = movingCTVolume.VoxelSpacing;

Rfixed2D = imref2d(fixedVolumeSize(1:2),fixedVoxelSpacing(2),fixedVoxelSpacing(1));

Rmoving2D = imref2d(movingVolumeSize(1:2),movingVoxelSpacing(2),movingVoxelSpacing(1)); 

% observamos en slicer
figure('Name','corregistro','NumberTitle','off')
imshowpair(movingCTVoxels(:,:,centerMoving(1)), ...
   Rmoving2D, ...
   fixedMRIVoxels(:,:,centerFixed(1)), ...
   Rfixed2D)

% observamos en 3D
viewerUnregistered = viewer3d(BackgroundColor="black",BackgroundGradient="off");

volshow(fixedMRIVolume, ...
    Parent=viewerUnregistered, ...
    RenderingStyle="Isosurface", ...
    IsosurfaceValue=0.05, ...
    Colormap=[1 0 1], ...
    Alphamap=1);

volshow(movingCTVolume, ...
    Parent=viewerUnregistered, ...
    RenderingStyle="Isosurface", ...
    IsosurfaceValue=0.05, ...
    Colormap=[0 1 0], ...
    Alphamap=1);