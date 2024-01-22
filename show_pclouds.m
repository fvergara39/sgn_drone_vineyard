% Image 3d pointcloud
np = size(pcloud,1);

% all_pc=[];
% for i=1:np
%     ptCloud = pointCloud(rosReadXYZ(pcloud{i}),'Color', double(rosReadRGB(pcloud{i})));
%     all_pc =[all_pc;ptCloud];
%     
% end
%% Show
for j=1:np
    ptCloud = pointCloud(rosReadXYZ(pcloud{j}),'Color', double(rosReadRGB(pcloud{j})));
    xp = ptCloud.Location(:,1);
    yp = ptCloud.Location(:,2);
    zp = ptCloud.Location(:,3);
    cp = double(ptCloud.Color)/255;
  
    figure(3)
    scatter3(xp, yp, zp, [], cp ,'filled','MarkerEdgeColor','flat', 'Marker','.','LineWidth',0.2)
    view(-170.5,78)
    
    % Da lontano
    %     xlim([-60,60])
    %     ylim([-30,0])
    %     zlim([0,80])

    % Vigne
    xlim([-10,10])
    ylim([-18,0])
    zlim([0,50])
    ax=gca;
    ax.ZDir ='reverse';
    title('PointCloud - n°' ,num2str(j))
    xlabel('Width')
    zlabel('Height')
    ylabel('Distance')
    
end
