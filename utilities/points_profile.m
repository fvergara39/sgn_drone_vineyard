
% Plot3D del profilo medio ottenuto coi punti della pointcloud.
% Deve essere specificata la riga CENTRE (valore tra 0 e 720) dell'
% immagine di profondità e l'ampiezza WINDOW della finestra su cui 
% mediare i valori dei 'pixel'.
%
% Es. centre = 50 ; window = 6. --> viene fatta la media sui pixel 
% tra la riga 47 e la riga 53, su ognuno delle 1280 colonne della matrice 
% dell'immagine.
% Procedimento fatto per ogni struttura da pcloud{start} a pcloud{terminal}

function [dataz, rows_roi, row_mean]= points_profile(pcloud, centre, window, start, terminal)

close all
space = 108.5455/876 * 0.5; % spazio percorso per ogni struttura

for j=start:terminal
    dataz = rosReadField(pcloud{j},'z',"PreserveStructureOnRead",true);
    w = centre-round(window/2)+1:centre+round(window/2);
    rows_roi = dataz(w,:);
    [~, width] = size(dataz);
    row_mean = zeros(1,width);
    for i=1:width
        col_i = rows_roi(:,i);
        row_mean(1,i)=mean(col_i(find(col_i~=0)));
    end
% 
    figure(1)
    grid
    Space = space*j*ones(1,1280); 
    plot3(1:1280, Space,row_mean,'o')
    ax = gca;
    ax.ZDir = 'reverse';
    view(0.9,13)
    xlabel('Width')
    zlabel('Dataz')
    ylabel('Distance')
    title('Profilo medio dei filari - PointCloud2 ')
    hold on
    %     figure(2)
    %     [X,Y] = meshgrid(1:1280,space);
    %     surf(X,Y,row_mean)
    %     hold on
    figure(2)
    %imagesc(dataz)
    image(dataz,'CDataMapping','scaled')
    h = colorbar;
    caxis([0,60])
    xlabel('Width')
    ylabel('Height')
    ylabel(h,'Depth - Colormap')
    title('Immagine di profondità per pcloud ', j)
end
%hold off