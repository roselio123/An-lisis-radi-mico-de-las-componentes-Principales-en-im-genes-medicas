clear all
close all

folderC = uigetdir('C:\my\NIFTI');

cd(folderC)

d = dir;
% creamos los archivos
filenamect = 'radiomicatotal_componentes_reducido.xlsx';

filenamemt = 'radiomicatotal_modalidades_reducido.xlsx';

filenamecc ='radiomicatotal_comparacion_reducido.xlsx';
%creamos las tablas
SC = table;
IC = table;
TC = table;
SM = table;
IM = table;
TM = table;

% Lectura de imágenes de los archivos en un loop
for i=1:7
folderC = uigetdir('C:\my\NIFTI');

cd(folderC)

d = dir;

% cargamos las caracteristicas de radiomica
load('radiomica_componentes.mat');

load('radiomica_modalidades.mat');

% concantenamos las de las componentes principales
SC1=removevars(SC1,"LabelID");
SC2=removevars(SC2,"LabelID");
SC3=removevars(SC3,"LabelID");
SC4=removevars(SC4,"LabelID");
SC = [SC; SC1; SC2; SC3; SC4];

IC1=removevars(IC1,"LabelID");
IC2=removevars(IC2,"LabelID");
IC3=removevars(IC3,"LabelID");
IC4=removevars(IC4,"LabelID");
IC = [IC; IC1; IC2; IC3; IC4];

TC1=removevars(TC1,"LabelID");
TC2=removevars(TC2,"LabelID");
TC3=removevars(TC3,"LabelID");
TC4=removevars(TC4,"LabelID");
TC = [TC; TC1; TC2; TC3; TC4];

% concatenamos las de las modalidades
SFlair=removevars(SFlair,"LabelID");
ST1=removevars(ST1,"LabelID");
ST1ce=removevars(ST1ce,"LabelID");
ST2=removevars(ST2,"LabelID");
SM = [SM; SFlair; ST1; ST1ce; ST2];

IFlair=removevars(IFlair,"LabelID");
IT1=removevars(IT1,"LabelID");
IT1ce=removevars(IT1ce,"LabelID");
IT2=removevars(IT2,"LabelID");
IM = [IM; IFlair; IT1; IT1ce; IT2];

TFlair=removevars(TFlair,"LabelID");
TT1=removevars(TT1,"LabelID");
TT1ce=removevars(TT1ce,"LabelID");
TT2=removevars(TT2,"LabelID");
TM = [TM; TFlair; TT1; TT1ce; TT2];
end

% convertimos la tabla en un tipo texto
SC = table2array(SC);
featureNamessc = SC1.Properties.VariableNames;
IC = table2array(IC);
featureNamesic = IC1.Properties.VariableNames;
TC = table2array(TC);
featureNamestc = TC1.Properties.VariableNames;
SM = table2array(SM);
featureNamessm = SFlair.Properties.VariableNames;
IM = table2array(IM);
featureNamesim = IFlair.Properties.VariableNames;
TM = table2array(TM);
featureNamestm = TFlair.Properties.VariableNames;

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

fsm = size(SM,2)
f=fsm;
featureCorrTrain = corrcoef(SM);
selectedFeaturessm = true(1,f);
for i = 1:f-1
    if isnan(featureCorrTrain(i,i))
        selectedFeaturessm(i) = false;
    end
    if selectedFeaturessm(i)
        for j = i+1:f
            if abs(featureCorrTrain(i,j)) >= 0.95
                selectedFeaturessm(j) = false;
            end
        end
    end
end
SM = SM(:,selectedFeaturessm);
featureNamessm = featureNamessm(selectedFeaturessm);
fsmr = size(SM,2)

fim = size(IM,2)
f=fim;
featureCorrTrain = corrcoef(IM);
selectedFeaturesim = true(1,f);
for i = 1:f-1
    if isnan(featureCorrTrain(i,i))
        selectedFeaturesim(i) = false;
    end
    if selectedFeaturesim(i)
        for j = i+1:f
            if abs(featureCorrTrain(i,j)) >= 0.95
                selectedFeaturesim(j) = false;
            end
        end
    end
end
IM = IM(:,selectedFeaturesim);
featureNamesim = featureNamesim(selectedFeaturesim);
fimr = size(IM,2)

ftm = size(TM,2)
f=ftm;
featureCorrTrain = corrcoef(TM);
selectedFeaturestm = true(1,f);
for i = 1:f-1
    if isnan(featureCorrTrain(i,i))
        selectedFeaturestm(i) = false;
    end
    if selectedFeaturestm(i)
        for j = i+1:f
            if abs(featureCorrTrain(i,j)) >= 0.95
                selectedFeaturestm(j) = false;
            end
        end
    end
end
TM = TM(:,selectedFeaturestm);
featureNamestm = featureNamestm(selectedFeaturestm);
ftmr = size(TM,2)

% guardamos las nuevas tablas
n = {'Componentes principales'};
xlswrite(filenamect,n,1,'A1');
xlswrite(filenamect,n,2,'A1');
xlswrite(filenamect,n,3,'A1');
writematrix(SC,filenamect,'Sheet',1,'Range','B1');
writematrix(IC,filenamect,'Sheet',2,'Range','B1');
writematrix(TC,filenamect,'Sheet',3,'Range','B1');

n = {'Modalidades'};
xlswrite(filenamemt,n,1,'A1');
xlswrite(filenamemt,n,2,'A1');
xlswrite(filenamemt,n,3,'A1');
writematrix(SM,filenamemt,'Sheet',1,'Range','B1');
writematrix(IM,filenamemt,'Sheet',2,'Range','B1');
writematrix(TM,filenamemt,'Sheet',3,'Range','B1');

% guardamos el numero de caracteristicas en una tabla para comparar
n = {'Forma componente'};
xlswrite(filenamecc,n,1,'A1');
writematrix(fsc,filenamecc,'Sheet',1,'Range','A2');
n = {'reducidos'};
xlswrite(filenamecc,n,1,'B1');
writematrix(fscr,filenamecc,'Sheet',1,'Range','B2');

n = {'Intensidad componente'};
xlswrite(filenamecc,n,1,'A4');
writematrix(fic,filenamecc,'Sheet',1,'Range','A5');
n = {'reducidos'};
xlswrite(filenamecc,n,1,'B4');
writematrix(ficr,filenamecc,'Sheet',1,'Range','B5');

n = {'Textura componente'};
xlswrite(filenamecc,n,1,'A7');
writematrix(ftc,filenamecc,'Sheet',1,'Range','A8');
n = {'reducidos'};
xlswrite(filenamecc,n,1,'B7');
writematrix(ftcr,filenamecc,'Sheet',1,'Range','B8');

% guardamos el numero de caracteristicas en una tabla para comparar
n = {'Forma modalidad'};
xlswrite(filenamecc,n,1,'D1');
writematrix(fsm,filenamecc,'Sheet',1,'Range','D2');
n = {'reducidos'};
xlswrite(filenamecc,n,1,'E1');
writematrix(fsmr,filenamecc,'Sheet',1,'Range','E2');

n = {'Intensidad modalidad'};
xlswrite(filenamecc,n,1,'D4');
writematrix(fim,filenamecc,'Sheet',1,'Range','D5');
n = {'reducidos'};
xlswrite(filenamecc,n,1,'E4');
writematrix(fimr,filenamecc,'Sheet',1,'Range','E5');

n = {'Textura modalidad'};
xlswrite(filenamecc,n,1,'D7');
writematrix(ftm,filenamecc,'Sheet',1,'Range','D8');
n = {'reducidos'};
xlswrite(filenamecc,n,1,'E7');
writematrix(ftmr,filenamecc,'Sheet',1,'Range','E8');

% guardar variables
save('radiomica_cc','SM','featureNamessm','IM','featureNamesim','TM','featureNamestm','SC','featureNamessc','IC','featureNamesic','TC','featureNamestc')

