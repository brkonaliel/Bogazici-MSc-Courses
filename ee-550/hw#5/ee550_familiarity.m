%since the performance depends on the initial weights, it may not converge
%properly, but this is a rare case. The user is suggested to rerun the
%algorithm.
clear;
mu= 0.1
s = 5;
%generate random data set on the unit sphere with 3 clusters 
n1 = normr(bsxfun(@plus,[-50 0 0],s.*randn(150,3)));
n2 = normr(bsxfun(@plus,[50 50 0],s.*randn(150,3)));
n3 = normr(bsxfun(@plus,[50 -50 0],s.*randn(150,3)));
data = [n1; n2; n3];
row = size(data,1);
data = data(randperm(row),:); %shuffle the data
%data = [n1;n2; n3];
%plot the clusters
scatter3(data(:,1),data(:,2),data(:,3),'.k')
%initialize weights randomly
W = 0.2.*rand(3,3)-0.1;
W = normr(W)
traj1 = zeros(1,3);
traj2 = zeros(1,3);
traj3 = zeros(1,3);
normdiff1 = zeros(1,3); 
%converge each output unit to be close to each cluster
k= 1;
for i=1:row
curr = data(i,:); % current data
out = curr*W;
[val ind] = max(out); % winner weight vector
out(ind) = 1;
out(out~=1) = 0; %make winner 1, others 0
I = repmat(curr,3,1);
out = repmat(out',1,3);
delta = mu*(I - W).*out; %learning rule
W = W+delta; %update the winner weight vector
W = normr(W); %normalize weights
traj1 = [traj1; W(1,:)];
traj2 = [traj2; W(2,:)];
traj3 = [traj3; W(3,:)];
%error for the first cluster
if ind == 1 
    err1(k) = norm(curr-W(1,:))
    k = k+1
end

end

hold on
plot3(W(1,1),W(1,2),W(1,3),'xb','MarkerSize',20,'LineWidth',2)
plot3(W(2,1),W(2,2),W(2,3),'xr','MarkerSize',20,'LineWidth',2)
plot3(W(3,1),W(3,2),W(3,3),'xm','MarkerSize',20,'LineWidth',2)

normdiff1 = [normdiff1 (norm(data(1,:)-W(1,:))).^2];
plot3(traj1(2:end,1),traj1(2:end,2),traj1(2:end,3),'.b')
plot3(traj2(2:end,1),traj2(2:end,2),traj2(2:end,3),'.r')
plot3(traj3(2:end,1),traj3(2:end,2),traj3(2:end,3),'.m')
hold off
figure;

plot(err1)

