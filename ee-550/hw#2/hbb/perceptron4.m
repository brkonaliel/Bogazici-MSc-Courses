clc
clear
Count = 500;
input = 3;
var = 15;
generate

sigmoid = @(x) 1./(1+exp(-x));
dsigmoid = @(x) exp(-x)/((1+exp(-x)).^2);
eta = 0.6;
err = 0;
done = 0;
e = 1;
Data = ones(Count,1);
Data = [Data Samples];
for i = 1:size(Data,2)-1
    W(i,1) = -1^(mod(ceil(10000*rand),2))*2*rand;
end
figure(1)
subplot(1,2,1)
hold on
for i = 1:size(Samples,1)
    if Samples(i,input+1) == 1
        plot3(Samples(i,1),Samples(i,2),Samples(i,3),'*b')
    else
        plot3(Samples(i,1),Samples(i,2),Samples(i,3),'or')
    end
end
xlim([-10 10]);
ylim([-10 10]);
zlim([-10 10]);
view([60 25])
a1 = subplot(1,2,2);
while e<500
    Data = Data(randperm(end),:);
    for j = 1:size(Samples,1)
        Inputs(j,1) = Data(j,1);
        Inputs(j,2) = Data(j,2);
        Inputs(j,3) = Data(j,3);
        Inputs(j,4) = Data(j,4);
    end
    for j = 1:size(Samples,1)
        for i = 1:size(Inputs,2)
            delW = eta*(Data(j,5)-sigmoid(Inputs(j,:)*W))*dsigmoid(Inputs(j,:)*W)*Inputs(j,i);
            W(i,1) = W(i,1) + delW;
        end
    end
    sum = 0;
    for j = 1:size(Samples,1)
        if sigmoid(Inputs(j,:)*W) >= 0.5
            y(j) = 1;
        else
            y(j) = -1;
        end
        diff = Data(j,5)-y(j);
        if diff == 0
            diff = 0;
        else
            diff = 1;
        end
        sum = sum + diff;
    end
    err(e) = sum;
    e = e+1;
    eta=eta*0.99;
    delete(a1)
    a1 = subplot(1,2,2);
    hold on
    func1 = @(x,y) -(W(2,1)/W(4,1))*x + -(W(3,1)/W(4,1))*y -(W(1,1)/W(4,1));
    ezsurf(func1,[-5,5,-5,5],2)
    for q = 1:size(y,2)
        if y(1,q) == 1
            plot3(Data(q,2),Data(q,3),Data(q,4),'*b')
        else
            plot3(Data(q,2),Data(q,3),Data(q,4),'or')
        end
    end
    xlim([-10 10]);
    ylim([-10 10]);
    zlim([-10 10]);
    view([45+20*sind(2*e) 25+15*sind(2*e)])
    drawnow
    if err(e-1) < 1
        done = 1;
        break;
    end
end
%%
% func1 = @(x,y) -(W(2,1)/W(4,1))*x + -(W(3,1)/W(4,1))*y -(W(1,1)/W(4,1));
% ezsurf(func1,[-5,5,-5,5],2)
% xlim([-5 5]);
% ylim([-5 5]);
% zlim([-5 5]);
% figure
% plot(err)


