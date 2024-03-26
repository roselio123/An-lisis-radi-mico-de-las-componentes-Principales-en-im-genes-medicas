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

filenamem = 'radiomica_modalidades_reducido.xlsx';

filename = 'radiomica_comparacion.xlsx';

% eliminamos eliminamos la variable de identificacion
SFlair=removevars(SFlair,"LabelID");
ST1=removevars(ST1,"LabelID");
ST1ce=removevars(ST1ce,"LabelID");
ST2=removevars(ST2,"LabelID");
SM = [SFlair; ST1; ST1ce; ST2];

IFlair=removevars(IFlair,"LabelID");
IT1=removevars(IT1,"LabelID");
IT1ce=removevars(IT1ce,"LabelID");
IT2=removevars(IT2,"LabelID");
IM = [IFlair; IT1; IT1ce; IT2];

TFlair=removevars(TFlair,"LabelID");
TT1=removevars(TT1,"LabelID");
TT1ce=removevars(TT1ce,"LabelID");
TT2=removevars(TT2,"LabelID");
TM = [TFlair; TT1; TT1ce; TT2];

% convertimos la tabla en un tipo texto
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
n = {'Modalidades'};
xlswrite(filenamem,n,1,'A1');
xlswrite(filenamem,n,2,'A1');
xlswrite(filenamem,n,3,'A1');
writematrix(SM,filenamem,'Sheet',1,'Range','B1');
writematrix(IM,filenamem,'Sheet',2,'Range','B1');
writematrix(TM,filenamem,'Sheet',3,'Range','B1');

% guardamos el numero de caracteristicas en una tabla para comparar
n = {'Forma modalidad'};
xlswrite(filename,n,1,'D1');
writematrix(fsm,filename,'Sheet',1,'Range','D2');
n = {'reducidos'};
xlswrite(filename,n,1,'E1');
writematrix(fsmr,filename,'Sheet',1,'Range','E2');

n = {'Intensidad modalidad'};
xlswrite(filename,n,1,'D4');
writematrix(fim,filename,'Sheet',1,'Range','D5');
n = {'reducidos'};
xlswrite(filename,n,1,'E4');
writematrix(fimr,filename,'Sheet',1,'Range','E5');

n = {'Textura modalidad'};
xlswrite(filename,n,1,'D7');
writematrix(ftm,filename,'Sheet',1,'Range','D8');
n = {'reducidos'};
xlswrite(filename,n,1,'E7');
writematrix(ftmr,filename,'Sheet',1,'Range','E8');

% guardar variables
save('radiomica_rm','SM','featureNamessm','IM','featureNamesim','TM','featureNamestm')