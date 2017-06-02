clc
clear
close all
hold on
meancount = 3;
eta = 0.1;
for i = 1:450
    if i >= 1 && i <151
        Azi = 30;
        Alt = 15;
    elseif i >=151 && i <301
        Azi = 150;
        Alt = 60;
    else
        Azi = 270;
        Alt = 80;
    end
    azi = Azi+randn*10;
    alt = Alt+randn*10;
    points(i,:) = generate(azi,alt);
end
points = points(randperm(end),:);
Weights = rand(meancount,size(points,2));
for i = 1:size(Weights,2)
    Weights(:,i) = (Weights(:,i)/norm(Weights(:,i)));
end
t = 1;
% while true
    points = points(randperm(end),:);
    for i = 1:size(points,1)
        competition = zeros(1,meancount);
        for j = 1:meancount
            competition(1,j) = points(i,:)*Weights(:,j);
        end
        for j = 1:size(competition,2)
            if competition(1,j) == max(competition)
                break;
            end
        end
        winner = j;
        output = zeros(1,meancount);
        output(1,winner) = 1;
        for m = 1:size(Weights,1)
            for n = 1:size(Weights,2)
                
                delW(m,n) = eta*output(1,n)*(points(i,m)-Weights(m,n));
                
            end
        end
        Weights = Weights + delW;
        for i = 1:size(Weights,2)
            Weights(:,i) = (Weights(:,i)/norm(Weights(:,i)));
        end
    end
    if mod(t,1) == 0
        clf
        hold on
%         for i = 1:size(points,1)
%             plot3(points(i,1),points(i,2),points(i,3),'b.')
%         end
        plot3(points(:,1), points(:,2), points(:,3), 'b.')
        for i = 1:meancount
            plot3(Weights(1,i),Weights(2,i),Weights(3,i),'r*')
        end
        view(45,60)
        drawnow
        end
    t = t+1;
    
    competition = zeros(1,meancount);
    e(:,t) = zeros(3,1);
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
    
% end
figure
plot(e)






