% drone_pov

distance = all_distance(start_s:end_s,:);

[n,m] = size(correction);
% feed = zeros(n,1);
% for j=1:size(Coord,1)
%     feed(j,:) = j*0.05;
% end


for i =1:size(Coord,1)
    figure(6)
%     Yr = 0:0.1:Coord(i,5);
%     Yl = 0:0.1:Coord(i,3);
    Yr = Coord(i,5):0.1:4;
    Yl = Coord(i,3):0.1:4;
    Xr = Coord(i,4)*ones(1,size(Yr,2));
    Xl = Coord(i,2)*ones(1,size(Yl,2));
    hold on
    view([-9,27])
%     xlim([-4 4])
%     ylim([-5.5 0])
    grid on
%     h_3dr = plot3(Xr,i*0.05*ones(1,size(Yr,2)),Yr ,'--x','Color',[0.18, 0.52, 0.49], 'LineWidth',1);
%     hold on
%     h_3dl = plot3(Xl, i*0.05*ones(1,size(Yl,2)),Yl ,'--x','Color',[0.18, 0.52, 0.49], 'LineWidth',1);
    h_3dr = plot3(Xr,distance(i,:)*ones(1,size(Yr,2)),Yr ,'--x','Color',[0, 0.5, 1], 'LineWidth',1);
    hold on
    h_3dl = plot3(Xl, distance(i,:)*ones(1,size(Yl,2)),Yl ,'--x','Color',[0, 0.5, 1], 'LineWidth',1);
    h = 0; % altezza di volo del drone
    Height = h*ones(n,1);
    Z = linspace(0,(end_s-start_s+1)*0.05, size(Height,1))';
    [a,b] = size(Z);
    Path_zero = zeros(a,b);
    %plot3(Path_zero ,feed, Height,'-g','LineWidth', 2)
    plot3(Path_zero, distance,Height,'Color',[0, 0, 1],'LineWidth',2)
    view([43.9651,54.4619])
    if geomMethod == 1
        title('Posizione dei filari  - sistema di riferimento Drone \{D\} - metodo geometrico')
    else
        title('Posizione dei filari  - sistema di riferimento Drone \{D\} - metodo kmeans')
    end
    legend('Filare di sinistra stimato','Filare di destra stimato','Posizione del drone','Location','best')
    xlabel('y - Width')
    ylabel('x - Distance')
    zlabel('z - Height')
    ax = gca;
    ax.ZDir = 'reverse';

end
hold off