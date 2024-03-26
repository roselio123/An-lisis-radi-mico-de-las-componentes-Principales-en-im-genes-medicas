clear all
close all

% Lectura de imágenes

folderC = uigetdir('C:\my\NIFTI');

cd(folderC)

d = dir;

% creamos el archivo excel
filename = 'radiomica_modalidades.xlsx';

% se define la ROI
roi = medicalVolume(d(4).name);

%% se le aplica radiomica a la modalidad 1
dataFlair = medicalVolume(d(3).name);

% obetnemos las propiedades radiomicas
RFlair = radiomics(dataFlair,roi);

% obtenemos las propiedades de forma
SFlair = shapeFeatures(RFlair);

% obtenemos las propiedades de intensidad
IFlair = intensityFeatures(RFlair);

% obtenemos las propiedades de textura
TFlair = textureFeatures(RFlair);

% guardamos la informacion en excel
n = {'Flair'};
xlswrite(filename,n,1,'A1');
xlswrite(filename,n,2,'A1');
xlswrite(filename,n,3,'A1');
writetable(SFlair,filename,'Sheet',1,'Range','B1');
writetable(IFlair,filename,'Sheet',2,'Range','B1');
writetable(TFlair,filename,'Sheet',3,'Range','B1');


%% se le aplica radiomica a la modalidad 2
dataT1 = medicalVolume(d(5).name);

% obetnemos las propiedades radiomicas
RT1 = radiomics(dataT1,roi);

% obtenemos las propiedades de forma
ST1 = shapeFeatures(RT1);

% obtenemos las propiedades de intensidad
IT1 = intensityFeatures(RT1);

% obtenemos las propiedades de textura
TT1 = textureFeatures(RT1);

% guardamos la informacion en excel
n = {'T1'};
xlswrite(filename,n,1,'A6');
xlswrite(filename,n,2,'A6');
xlswrite(filename,n,3,'A6');
writetable(ST1,filename,'Sheet',1,'Range','B6');
writetable(IT1,filename,'Sheet',2,'Range','B6');
writetable(TT1,filename,'Sheet',3,'Range','B6');


%% se le aplica radiomica a la modalidad 3
dataT1ce = medicalVolume(d(6).name);

% obetnemos las propiedades radiomicas
RT1ce = radiomics(dataT1ce,roi);

% obtenemos las propiedades de forma
ST1ce = shapeFeatures(RT1ce);

% obtenemos las propiedades de intensidad
IT1ce = intensityFeatures(RT1ce);

% obtenemos las propiedades de textura
TT1ce = textureFeatures(RT1ce);

% guardamos la informacion en excel
n = {'T1 contraste'};
xlswrite(filename,n,1,'A11');
xlswrite(filename,n,2,'A11');
xlswrite(filename,n,3,'A11');
writetable(ST1ce,filename,'Sheet',1,'Range','B11');
writetable(IT1ce,filename,'Sheet',2,'Range','B11');
writetable(TT1ce,filename,'Sheet',3,'Range','B11');


%% se le aplica radiomica a la modalidad 4
dataT2 = medicalVolume(d(7).name);

% obetnemos las propiedades radiomicas
RT2 = radiomics(dataT2,roi);

% obtenemos las propiedades de forma
ST2 = shapeFeatures(RT2);

% obtenemos las propiedades de intensidad
IT2 = intensityFeatures(RT2);

% obtenemos las propiedades de textura
TT2 = textureFeatures(RT2);

% guardamos la informacion en excel
n = {'T2'};
xlswrite(filename,n,1,'A16');
xlswrite(filename,n,2,'A16');
xlswrite(filename,n,3,'A16');
writetable(ST2,filename,'Sheet',1,'Range','B16');
writetable(IT2,filename,'Sheet',2,'Range','B16');
writetable(TT2,filename,'Sheet',3,'Range','B16');

%% guardamos los valores de la radiomica
save('radiomica_modalidades','SFlair','IFlair','TFlair','ST1','IT1','TT1','ST1ce','IT1ce','TT1ce','ST2','IT2','TT2');