t = 1;    
while true
    clf
    hold on
    theta = 1*t;
    rotation = [cosd(theta) -sind(theta) 0;sind(theta) cosd(theta) 0;0 0 1];
    [x y z] = sphere;
    h = surf(x,y,z);
    rotate(h,[0,0,1],-theta)
    set(h,'FaceColor',[0.9 0.9 0.9],'FaceAlpha', 0.6,'EdgeAlpha',0.1)
    pointsRot = points*rotation;
    WeightsRot = Weights*rotation;
    CentersRot = centers*rotation;
    for i = 1:size(WHistory,3)
    WHistoryRot(:,:,i) = WHistory(:,:,i)*rotation;
    end
    IniWeightsRot(:,:) = WHistoryRot(:,:,1);
    q = plot3(pointsRot(:,1), pointsRot(:,2), pointsRot(:,3), 'b.');
    plot3(WeightsRot(:,1),WeightsRot(:,2),WeightsRot(:,3),'ro')
    w = plot3(WeightsRot(:,1),WeightsRot(:,2),WeightsRot(:,3),'r*');
    plot3(CentersRot(:,1),CentersRot(:,2),CentersRot(:,3),'go')
    s = plot3(CentersRot(:,1),CentersRot(:,2),CentersRot(:,3),'g*');
    for i = 1:size(WHistory,3)-1
        for j = 1:size(WHistory,1)
        f = plot3([WHistoryRot(j,1,i) WHistoryRot(j,1,i+1)],[WHistoryRot(j,2,i) WHistoryRot(j,2,i+1)]...
            ,[WHistoryRot(j,3,i) WHistoryRot(j,3,i+1)],'r-');
        end
    end
    legend([q w s f],{'Data','Means','Centers','Mean Path'})
    view(45,15)
    drawnow
    t = t+1;
end
  