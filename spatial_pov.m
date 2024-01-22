%spatial_titpov

spatialCoord = Coord;

% feed = zeros(size(correction));
% for j=1:size(spatialCoord,1)
%     feed(j,:) = j*0.05;
% end

% Centrare i filari
for l=1:size(Coord,1)
    spatialCoord(l,2) = Coord(l,2) - correction(l,2);
    spatialCoord(l,4) = Coord(l,4) - correction(l,2);
end

for i =1:size(spatialCoord,1)
    figure(7)
    Yr = -spatialCoord(i,5):0.1:0;
    Yl = -spatialCoord(i,3):0.1:0;
    Xr = spatialCoord(i,4)*ones(1,size(Yr,2));
    Xl = spatialCoord(i,2)*ones(1,size(Yl,2));
    hold on
    view([-9,27])
%     xlim([-4 4])
%     ylim([-5.5 0])
    grid on
%     h_3dr = plot3(Xr,i*0.05*ones(1,size(Yr,2)),Yr ,'--x','Color',[0, 0.5, 0], 'LineWidth',1);
%     h_3dl = plot3(Xl, i*0.05*ones(1,size(Yl,2)),Yl ,'--x','Color',[0, 0.5, 0], 'LineWidth',1);
%     h = 2;
%     plot3(-cleanCorrection(:,2),feed, h*ones(size(spatialCoord,1),1),'-g','LineWidth', 3)

    h_3dr = plot3(Xr,distance(i,:)*ones(1,size(Yr,2)) , Yr,'--x','Color',[0, 0.5, 0], 'LineWidth',1);
    h_3dl = plot3(Xl, distance(i,:)*ones(1,size(Yl,2)),Yl ,'--x','Color',[0, 0.5, 0], 'LineWidth',1);
    h = -2.5;
    plot3(-correction(:,2),distance(:,:), h*ones(size(spatialCoord,1),1),'-g','LineWidth', 3)
    view([40.6209,59.0913])
    if geomMethod == 1
        title('Percorso stimato del drone lungo i filari - sistema di riferimento Spatial \{S\} - metodo geometrico')
    else 
        title('Percorso stimato del drone lungo i filari - sistema di riferimento Spatial \{S\} - metodo kmeans')
    end
    legend('Filare di sinistra','Filare di destra','Posizione stimata per il drone','Location','best')
    xlabel('Width')
    ylabel('Distance')
    zlabel('Height')
    xlabel('y - Width')
    ylabel('x - Distance')
    zlabel('z - Height')
    ax = gca;
    ax.ZDir = 'reverse';

end
hold off