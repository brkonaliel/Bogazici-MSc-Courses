% Get 10 new samples from the original data and compare their labels with
% trained ANN.
close all;clc;
X_samples = M(100:end,:);
dummy = size(X_samples(:,1:end-1));
% Feed Forward Algorithm
for i=1:layers
    if i == 1
        S_samples{i} = X_samples(:,1:end-1);
        O_samples{i} = [ones(dummy(1),1), S_samples{i}];
        continue
    end
    if i == layers
        S_samples{i} = O_samples{i-1}*W{i-1};
        O_samples{i} = floor(sigmoid(S_samples{i}));
        break
    end
    S_samples{i} = O_samples{i-1}*W{i-1};
    O_samples{i} = sigmoid(S_samples{i});
    dummy2 = size(O_samples{i});
    O_samples{i} = [ones(dummy2(1),1), O_samples{i}];
end
figure()
scatter(X_samples(:,1), X_samples(:,end), 'bo')
hold on
scatter(X_samples(:,1), O_samples{end}(:,1), 'rx')
title('Output of trained ANN')
legend('Actual IRIS value', 'ANN value')