clc; close all; clear all;
% Parameters, input and function definitions
% Input, eta and threshold
M = csvread('iris_samples.txt');
M = M(randperm(size(M,1)),:);
% Getting the first 100 samples of the data
X = M(1:100,:);
dummy = size(X(:,1:end-1));
features = dummy(2);
eta = 1e-4;
threshold = 5e-1;

% Sigmoid definitons (it's 3*sigmoid due to nature of the input which can
% take values of 0, 1 and 2.
sigmoid = @(x) 3./(1+exp(-x));
dsigmoid =@(x) 3.*exp(-x)./((1+exp(-x)).^2);

% Layers and neurons 
neurons = [dummy(2)+1, 15, 1];
layers = length(neurons);

% Weight matrices connecting layers with random weights are created. 
% The initial layer is created by adding
% 1's to the input matrix.
for i=1:layers-1
    if i == layers-1
        W{i} = rand(neurons(i), neurons(i+1))/1e2;
        break
    end
    W{i} = rand(neurons(i), neurons(i+1)-1)/1e2;
end

% Feed forward of the input through layers
% Shuffling input data before Feed Forward Algorithm
X = X(randperm(size(X,1)),:);
for i=1:layers
    if i == 1
        S{i} = X(:,1:end-1);
        O{i} = [ones(dummy(1),1), S{i}];
        continue
    end
    if i == layers
        S{i} = O{i-1}*W{i-1};
        O{i} = sigmoid(S{i});
        break
    end
    S{i} = O{i-1}*W{i-1};
    O{i} = sigmoid(S{i});
    dummy2 = size(O{i});
    O{i} = [ones(dummy2(1),1), O{i}];
end

% Error calculation
E = 1/2*(X(:,end)-floor(O{end}))'*(X(:,end)-floor(O{end}));
% E = 1/2*(X(:,end)-floor(O{end}/3))'*(X(:,end)-floor(O{end}/3));
E_vector = E;

% MAIN LOOP
while true
    % Back Propagation Algorithm
    for i=layers:-1:2
        if i == layers
            d{i} = (X(:,end) - O{i}).*dsigmoid(S{i});
            W{i-1} = W{i-1} + eta*O{i-1}'*d{i};
            continue
        end
        % Weights multiplying bias unit does not involve in Back
        % Propagation Algorithm
        d{i} = d{i+1}*W{i}(2:end,:)'.*dsigmoid(S{i});
        W{i-1} = W{i-1} + eta*O{i-1}'*d{i};
    end
    % Feed forward of the input through layers
    % Shuffling input data before Feed Forward Algorithm
    X = X(randperm(size(X,1)),:);
    for k=1:layers
        if k == 1
            S{k} = X(:,1:end-1);
            O{k} = [ones(dummy(1),1), S{k}];
            continue
        end
        if k == layers
            S{k} = O{k-1}*W{k-1};
            O{k} = sigmoid(S{k});
            break;
        end
        S{k} = O{k-1}*W{k-1};
        O{k} = sigmoid(S{k});
        dummy2 = size(O{k});
        O{k} = [ones(dummy2(1),1), O{k}];
    end
    % Error calculation
    E = 1/2*(X(:,end)-floor(O{end}))'*(X(:,end)-floor(O{end}));
%     E = 1/2*(X(:,end)-floor(O{end}/3))'*(X(:,end)-floor(O{end}/3));
    E_vector = [E_vector, E];
    if E_vector(end) <= threshold
        break
    end
    if length(E_vector) > 1e5
        break
    end
end
% O{end} = floor(O{end});
% Plot Error wrt iterations
plot(E_vector);
title('Error')
% Get 50 new samples from the original data and compare their labels with
% trained ANN.
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

