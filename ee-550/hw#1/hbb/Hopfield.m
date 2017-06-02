clearvars -except centers bit Samples
clc
close all
variance = 0;
bit = 8;
T = zeros(bit*bit,bit*bit);
for i = 1:bit*bit
    for j = 1:bit*bit
        sum = 0;
        count = 0;
        for z = 1:size(Samples,2)
            sum = sum + Samples(i,z)*Samples(j,z);
            count = count+1;
        end
        if i == j
            T(i,j) = 0;
        else
            T(i,j) = sum;
        end
    end
end
t = 1;
%%
for i = 1:bit*bit
    c = 0;
    if mod(i,bit) == 0
        c = 0.1;
    end
    %mu(i,1)=(-1)^(i+floor((i-mod(i,bit)-c)/(bit)));
    %mu(i,1)=-1*rand;
    %mu(i,1)=hardNonLinear((-1)^(ceil(rand*1000))*rand);
end
choose = [1 2 3 4 5];
chosen = 1+floor(mod(100*rand,5));
for i = 1:bit*bit
mu(i,1) = hardNonLinear(Samples(i,chosen) + sqrt(variance)*randn);
end
%%
figure(1)
hold on
sindex = reshape(Samples(:,chosen),[bit,bit]);
    for i = 1:bit
        for j = 1:bit
            drawRectangle(centers(i,j,1),centers(i,j,2),sindex(i,j));
        end
    end
%%
mindex = reshape(mu,[bit,bit]);
figure(2)
clf
hold on
axis([0 bit 0 bit])
% for i = 0:bit
%    plot([i i],[0 bit])
% end
% for j = 0:bit
%      plot([j j],[0 bit])
% end
for i = 1:bit
    for j = 1:bit
        drawRectangle(centers(i,j,1),centers(i,j,2),mindex(i,j));
    end
end
pause
while(1)
    mindex = zeros(bit,bit);
    for j = 1:bit*bit
        sum = 0;
        for i = 1:bit*bit
            sum = sum + T(i,j)*mu(i,t);
        end
        if hardNonLinear(sum) == 5
            mu(j,t+1)=mu(j,t);
        else
            mu(j,t+1)=hardNonLinear(sum);
        end
    end
    t = t+1;
    
    mindex = reshape(mu(:,t),[bit,bit]);
    figure(2)
    clf
    hold on
    axis([0 bit 0 bit])
    %     for i = 0:bit
    %      plot([i i],[0 bit])
    %     end
    %     for j = 0:bit
    %      plot([j j],[0 bit])
    %     end
    for i = 1:bit
        for j = 1:bit
            drawRectangle(centers(i,j,1),centers(i,j,2),mindex(i,j));
        end
    end
    pause
end