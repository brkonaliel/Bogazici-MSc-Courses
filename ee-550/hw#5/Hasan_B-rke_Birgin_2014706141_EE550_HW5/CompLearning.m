clc
clear
close all
hold on
meancount = 3;
eta = 0.1;
for i = 1:450
    if i >= 1 && i <171
        Azi = 30;
        Alt = 15;
    elseif i >=151 && i <281
        Azi = 150;
        Alt = 75;
    else
        Azi = 270;
        Alt = 155;
    end
    azi = Azi+randn*15;
    alt = Alt+randn*15;
    points(i,:) = generate(azi,alt,[0 0 1]);
end
centers(1,:) = generate(30,15,[0 0 1]);
centers(2,:) = generate(150,75,[0 0 1]);
centers(3,:) = generate(270,155,[0 0 1]);
points = points(randperm(end),:);
Weights = randn(meancount,size(points,2));
for i = 1:size(Weights,2)
    Weights(i,:) = (Weights(i,:)/norm(Weights(i,:)));
end
t = 1;
epoch = 1;
close all
while true
    sum = 0;
    points = points(randperm(end),:);
    for i = 1:size(points,1)
        competition = zeros(1,meancount);
        for j = 1:meancount
            competition(1,j) = points(i,:)*Weights(j,:)';
        end
        for j = 1:size(competition,2)
            if competition(1,j) == max(competition)
                break;
            end
        end
        winner = j;
        competition = zeros(1,meancount);
        e(:,t) = zeros(meancount,1);
        for p = 1:size(points,1)
        for l = 1:meancount
            competition(1,l) = points(p,:)*Weights(l,:)';
        end
        for l = 1:size(competition,2)
            if competition(1,l) == max(competition)
                break;
            end
        end
        e(l,t) = e(l,t) + norm(points(p,:)-Weights(l,:));
        end
        sum = sum + norm(points(i,:)-Weights(j,:));
        
        delW = eta*(points(i,:)-Weights(j,:));
        
        WHistory(:,:,t) = Weights(:,:);
        
        Weights(j,:) = Weights(j,:) + delW;
        
        Weights(j,:) = (Weights(j,:)/norm(Weights(j,:)));
            % GRAPHICS PART
    clf
    hold on
    theta = 0.5*t;
    rotation = [cosd(theta) -sind(theta) 0;sind(theta) cosd(theta) 0;0 0 1];
    [x y z] = sphere;
    h = surf(x,y,z);
    rotate(h,[0,0,1],-theta)
    set(h,'FaceColor',[0.9 0.9 0.9],'FaceAlpha', 0.6,'EdgeAlpha',0.1)
    pointsRot = points*rotation;
    WeightsRot = Weights*rotation;
    CentersRot = centers*rotation;
    q = plot3(pointsRot(:,1), pointsRot(:,2), pointsRot(:,3), 'b.');
    plot3(WeightsRot(:,1),WeightsRot(:,2),WeightsRot(:,3),'ro')
    w = plot3(WeightsRot(:,1),WeightsRot(:,2),WeightsRot(:,3),'r*');
    plot3(CentersRot(:,1),CentersRot(:,2),CentersRot(:,3),'go')
    s = plot3(CentersRot(:,1),CentersRot(:,2),CentersRot(:,3),'g*');
    legend([q w s],{'Data','Means','Centers'})
    view(45,15)
    drawnow
      t = t+1;
    %%
    end
    Error(epoch) = sum;
    epoch = epoch + 1;
    if epoch > 1
        break
    end
end
figure
plot(e(1,:));
title('Total error of Mean 1')
xlabel('Iterations')
ylabel('Sum of norms')
figure
plot(e(2,:));
title('Total error of Mean 2')
xlabel('Iterations')
ylabel('Sum of norms')
figure
plot(e(3,:));
title('Total error of Mean 3')
xlabel('Iterations')
ylabel('Sum of norms')