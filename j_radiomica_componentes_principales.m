clear all
close all

% Lectura de imágenes

folderC = uigetdir('C:\my\NIFTI');

cd(folderC)

d = dir;

% creamos el archivo excel
filename = 'radiomica_componentes.xlsx';

% se define la ROI
roi = medicalVolume(d(4).name);

%% se le aplica radiomica a la componente 1
dataC1 = medicalVolume(d(8).name);

% obetnemos las propiedades radiomicas
RC1 = radiomics(dataC1,roi);

% obtenemos las propiedades de forma
SC1 = shapeFeatures(RC1);

% obtenemos las propiedades de intensidad
IC1 = intensityFeatures(RC1);

% obtenemos las propiedades de textura
TC1 = textureFeatures(RC1);

% guardamos la informacion en excel
n = {'C1'};
xlswrite(filename,n,1,'A1');
xlswrite(filename,n,2,'A1');
xlswrite(filename,n,3,'A1');
writetable(SC1,filename,'Sheet',1,'Range','B1');
writetable(IC1,filename,'Sheet',2,'Range','B1');
writetable(TC1,filename,'Sheet',3,'Range','B1');


%% se le aplica radiomica a la componente 2
dataC2 = medicalVolume(d(9).name);

% obetnemos las propiedades radiomicas
RC2 = radiomics(dataC2,roi);

% obtenemos las propiedades de forma
SC2 = shapeFeatures(RC2);

% obtenemos las propiedades de intensidad
IC2 = intensityFeatures(RC2);

% obtenemos las propiedades de textura
TC2 = textureFeatures(RC2);

% guardamos la informacion en excel
n = {'C2'};
xlswrite(filename,n,1,'A6');
xlswrite(filename,n,2,'A6');
xlswrite(filename,n,3,'A6');
writetable(SC2,filename,'Sheet',1,'Range','B6');
writetable(IC2,filename,'Sheet',2,'Range','B6');
writetable(TC2,filename,'Sheet',3,'Range','B6');


%% se le aplica radiomica a la componente 3
dataC3 = medicalVolume(d(10).name);

% obetnemos las propiedades radiomicas
RC3 = radiomics(dataC3,roi);

% obtenemos las propiedades de forma
SC3 = shapeFeatures(RC3);

% obtenemos las propiedades de intensidad
IC3 = intensityFeatures(RC3);

% obtenemos las propiedades de textura
TC3 = textureFeatures(RC3);

% guardamos la informacion en excel
n = {'C3'};
xlswrite(filename,n,1,'A11');
xlswrite(filename,n,2,'A11');
xlswrite(filename,n,3,'A11');
writetable(SC3,filename,'Sheet',1,'Range','B11');
writetable(IC3,filename,'Sheet',2,'Range','B11');
writetable(TC3,filename,'Sheet',3,'Range','B11');


%% e le aplica radiomica a la componente 4
dataC4 = medicalVolume(d(11).name);

% obetnemos las propiedades radiomicas
RC4 = radiomics(dataC4,roi);

% obtenemos las propiedades de forma
SC4 = shapeFeatures(RC4);

% obtenemos las propiedades de intensidad
IC4 = intensityFeatures(RC4);

% obtenemos las propiedades de textura
TC4 = textureFeatures(RC4);

% guardamos la informacion en excel
n = {'C4'};
xlswrite(filename,n,1,'A16');
xlswrite(filename,n,2,'A16');
xlswrite(filename,n,3,'A16');
writetable(SC4,filename,'Sheet',1,'Range','B16');
writetable(IC4,filename,'Sheet',2,'Range','B16');
writetable(TC4,filename,'Sheet',3,'Range','B16');

%% guardamos los valores de la radiomica
save('radiomica_componentes','SC1','IC1','TC1','SC2','IC2','TC2','SC3','IC3','TC3','SC4','IC4','TC4');