clear all
close all

% Lectura de imágenes

folderC = uigetdir('C:\my\NIFTI');

cd(folderC)

d = dir;

% cargamos las caracteristicas de radiomica
load('radiomica_componentes.mat');

load('radiomica_modalidades.mat');

% creamos los archivos
filenamec = 'radiomica_componentes_reducido.xlsx';

filename = 'radiomica_comparacion.xlsx';

% eliminamos eliminamos la variable de identificacion
SC1=removevars(SC1,"LabelID");
SC2=removevars(SC2,"LabelID");
SC3=removevars(SC3,"LabelID");
SC4=removevars(SC4,"LabelID");
SC = [SC1; SC2; SC3; SC4];

IC1=removevars(IC1,"LabelID");
IC2=removevars(IC2,"LabelID");
IC3=removevars(IC3,"LabelID");
IC4=removevars(IC4,"LabelID");
IC = [IC1; IC2; IC3; IC4];

TC1=removevars(TC1,"LabelID");
TC2=removevars(TC2,"LabelID");
TC3=removevars(TC3,"LabelID");
TC4=removevars(TC4,"LabelID");
TC = [TC1; TC2; TC3; TC4];

% convertimos la tabla en un tipo texto
SC = table2array(SC);
featureNamessc = SC1.Properties.VariableNames;
IC = table2array(IC);
featureNamesic = IC1.Properties.VariableNames;
TC = table2array(TC);
featureNamestc = TC1.Properties.VariableNames;

% computamos el numero de caracteristicas
% calculamos el coeficiente de correlacion
% eliminamos las caracteristicas redundantes si el coeficiente es 0.95 o
% mayor
fsc = size(SC,2)
f=fsc;
featureCorrTrain = corrcoef(SC);
selectedFeaturessc = true(1,f);
for i = 1:f-1
    if isnan(featureCorrTrain(i,i))
        selectedFeaturessc(i) = false;
    end
    if selectedFeaturessc(i)
        for j = i+1:f
            if abs(featureCorrTrain(i,j)) >= 0.95
                selectedFeaturessc(j) = false;
            end
        end
    end
end
SC = SC(:,selectedFeaturessc);
featureNamessc = featureNamessc(selectedFeaturessc);
fscr = size(SC,2)

fic = size(IC,2)
f=fic;
featureCorrTrain = corrcoef(IC);
selectedFeaturesic = true(1,f);
for i = 1:f-1
    if isnan(featureCorrTrain(i,i))
        selectedFeaturesic(i) = false;
    end
    if selectedFeaturesic(i)
        for j = i+1:f
            if abs(featureCorrTrain(i,j)) >= 0.95
                selectedFeaturesic(j) = false;
            end
        end
    end
end
IC = IC(:,selectedFeaturesic);
featureNamesic = featureNamesic(selectedFeaturesic);
ficr = size(IC,2)

ftc = size(TC,2)
f=ftc;
featureCorrTrain = corrcoef(TC);
selectedFeaturestc = true(1,f);
for i = 1:f-1
    if isnan(featureCorrTrain(i,i))
        selectedFeaturestc(i) = false;
    end
    if selectedFeaturestc(i)
        for j = i+1:f
            if abs(featureCorrTrain(i,j)) >= 0.95
                selectedFeaturestc(j) = false;
            end
        end
    end
end
TC = TC(:,selectedFeaturestc);
featureNamestc = featureNamestc(selectedFeaturestc);
ftcr = size(TC,2)


% guardamos las nuevas tablas
n = {'Componentes'};
xlswrite(filenamec,n,1,'A1');
xlswrite(filenamec,n,2,'A1');
xlswrite(filenamec,n,3,'A1');
writematrix(SC,filenamec,'Sheet',1,'Range','B1');
writematrix(IC,filenamec,'Sheet',2,'Range','B1');
writematrix(TC,filenamec,'Sheet',3,'Range','B1');

% guardamos el numero de caracteristicas en una tabla para comparar
n = {'Forma componente'};
xlswrite(filename,n,1,'A1');
writematrix(fsc,filename,'Sheet',1,'Range','A2');
n = {'reducidos'};
xlswrite(filename,n,1,'B1');
writematrix(fscr,filename,'Sheet',1,'Range','B2');

n = {'Intensidad componente'};
xlswrite(filename,n,1,'A4');
writematrix(fic,filename,'Sheet',1,'Range','A5');
n = {'reducidos'};
xlswrite(filename,n,1,'B4');
writematrix(ficr,filename,'Sheet',1,'Range','B5');

n = {'Textura componente'};
xlswrite(filename,n,1,'A7');
writematrix(ftc,filename,'Sheet',1,'Range','A8');
n = {'reducidos'};
xlswrite(filename,n,1,'B7');
writematrix(ftcr,filename,'Sheet',1,'Range','B8');

% guardar variables
save('radiomica_rc','SC','featureNamessc','IC','featureNamesic','TC','featureNamestc')