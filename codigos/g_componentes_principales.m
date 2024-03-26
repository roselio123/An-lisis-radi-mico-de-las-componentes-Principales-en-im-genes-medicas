clear all
close all

% Lectura de imágenes

folderC = uigetdir('C:\my\NIFTI');

cd(folderC)

d = dir;

dataFlair = double(niftiread(d(3).name));
infoFlair = niftiinfo(d(3).name);

dataT1 = double(niftiread(d(5).name));
infoT1 = niftiinfo(d(5).name);

dataT1ce = double(niftiread(d(6).name));
infoT1ce = niftiinfo(d(6).name);

dataT2 = double(niftiread(d(7).name));
infoT2 = niftiinfo(d(7).name);

[~,~,Nc] = size(dataT1);


% Se determinan listas de los niveles digitales para cada modalidad

[M,N,P] = size(dataT1);

cont = 0;
for i=1:M
    for j=1:N
        for k=1:P
            cont = cont + 1;
            T1(cont) = dataT1(i,j,k);
            T1C(cont) = dataT1ce(i,j,k);
            T2(cont) = dataT2(i,j,k);
            FL(cont) = dataFlair(i,j,k);
        end
    end
end

% Se establecen los valores medios de niveles digitales para cada modalidad

mT1 = mean(T1);
mT1C = mean(T1C);
mT2 = mean(T2);
mFL = mean(FL);

% Análisis de Componentes Principales

M1 = [T1',T1C',T2',FL'];

[coef,score,var] = pca(M1);

cont = 0;
for i=1:M
    for j=1:N
        for k=1:P
            cont = cont + 1;
            PC1(i,j,k) = coef(1,1)*(T1(cont) - mT1) + coef(2,1)*(T1C(cont) - mT1C) + coef(3,1)*(T2(cont) - mT2) + coef(4,1)*(FL(cont) - mFL);
            PC2(i,j,k) = coef(1,2)*(T1(cont) - mT1) + coef(2,2)*(T1C(cont) - mT1C) + coef(3,2)*(T2(cont) - mT2) + coef(4,2)*(FL(cont) - mFL);
            PC3(i,j,k) = coef(1,3)*(T1(cont) - mT1) + coef(2,3)*(T1C(cont) - mT1C) + coef(3,3)*(T2(cont) - mT2) + coef(4,3)*(FL(cont) - mFL);
            PC4(i,j,k) = coef(1,4)*(T1(cont) - mT1) + coef(2,4)*(T1C(cont) - mT1C) + coef(3,4)*(T2(cont) - mT2) + coef(4,4)*(FL(cont) - mFL);
        end
    end
end

% guardamos las variables coeff, score y var
save('variables','coef','score','var');

% guardamos las componentes principales como ficheros nifti
niftiwrite(PC1,'Componente_1.nii');

niftiwrite(PC2,'Componente_2.nii');

niftiwrite(PC3,'Componente_3.nii');

niftiwrite(PC4,'Componente_4.nii');