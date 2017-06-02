clc
clearvars -except Samples
close all
bit = 8;
for i = 1:bit
    for j = 1:bit
        centers(i,bit+1-j,1) = i-0.5;
        centers(i,bit+1-j,2) = j-0.5;
        index(i,j) = -1;
    end
end
quit = 0;
X = 1;
Y = 1;
while quit == 0
    clf
    hold on
    axis([0 bit 0 bit])
    for i = 0:bit
     plot([i i],[0 bit],'k')
    end
    for j = 0:bit
     plot([0 bit],[j j],'k')
    end
    for i = 1:bit
        for j = 1:bit
            if index(i,j) ~= -1
            drawRectangle(centers(i,j,1),centers(i,j,2),index(i,j));
            end
        end
    end
    [X,Y] = ginput(1);
    X = ceil(X);
    Y = ceil(Y);
    if Y < 1 || Y > bit || X > bit || X < 1 
        quit = 1;
    else
        if index(X,bit+1-Y) == 1;
            index(X,bit+1-Y) = -1;
        else
            index(X,bit+1-Y) = 1;
        end
        if Y < 1
            quit = 1;
        end
    end
end
%%
% k = bit*bit;
% index = index';
% for i = 1:bit
%     for j = 1:bit
%         sample(k,1) = index(i,j);k = k-1;
%     end
% end
%%
sample(:,1) = reshape(index,[bit*bit,1]);









