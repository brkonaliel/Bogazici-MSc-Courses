clc; close all; clear all;
% parameters, input and function definitions
threshold = 1e-3;
X = [0 0 0; 0 1 1; 1 0 1; 1 1 0];
dummy = size(X(:,1:end-1));
features = dummy(2);
sigmoid = @(x) 1./(1+exp(-x));
dsigmoid =@(x) exp(-x)./((1+exp(-x)).^2);
eta = 0.8;
neurons = [dummy(2), 2, 1];
layers = length(neurons);

% Weight matrices connecting layers. Input layer is just passing the input.
for i=1:layers-1
    W{i} = rand(neurons(i), neurons(i+1));
end
% Feed forward of the input through layers
for i=1:layers
    if i == 1
        S{i} = X(:,1:end-1);
        O{i} = S{i};
        continue
    end
    S{i} = O{i-1}*W{i-1};
    O{i} = sigmoid(S{i});

end

% Initial error value
E = 1/2*(X(:,end)-O{end})'*(X(:,end)-O{end});
E_vector = E;

% main loop
while true
    % backward propagation
    for i=layers:-1:2
        if i == layers
            d{i} = (X(:,end) - O{i}).*dsigmoid(S{i});
            W{i-1} = W{i-1} + eta*O{i-1}'*d{i};
            continue
        end
        d{i} = d{i+1}*W{i}'.*dsigmoid(S{i});
        W{i-1} = W{i-1} + eta*O{i-1}'*d{i};
    end
    % Feed forward of the input through layers
    for i=1:layers
        if i == 1
            S{i} = X(:,1:end-1);
            O{i} = S{i};
            continue
        end
        S{i} = O{i-1}*W{i-1};
        O{i} = sigmoid(S{i});
    end
    % calculation of the error at the output layer.
    E = 1/2*(X(:,end)-O{end})'*(X(:,end)-O{end});
    E_vector = [E_vector, E];
    % termination criteria of the main loop
    if E_vector(end) <= threshold
        break
    end   
end

plot(E_vector);
pause;

a = W{1}(1,1);
b = W{1}(1,2);
f = @(x) -a/b*x;
ezplot( f, 0, 5 );
hold on;
c = W{2}(1);
d = W{2}(2);
f = @(x) -c/d*x;
figure();
ezplot( f, 0, 5 );

