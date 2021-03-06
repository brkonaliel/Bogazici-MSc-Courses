close all; clc; clear;
% parameters
size = 50;
features = 3;
eta = 0.7;
threshold = 1e-5;

% creation of random input matrix X. Note that first three columns are
% feautres and 4th column is the label (for x1, x2 and x3 being +1,
% label is positive and for x1, x2 and x3 being negative, the label is 0. 
X = create_random_input(size, features);

figure();
hold on;
for i = 1:length(X)
    if X(i,features+1) == 1
        plot3(X(i,1),X(i,2),X(i,3),'*b')
    else
        plot3(X(i,1),X(i,2),X(i,3),'or')
    end
end
title('Input samples');

sigmoid = @(x) 1./(1+exp(-x));

% initialise W randomly. W is a 3x1 weight matrix
W = rand(3,1);
W2 = W;

% initial calculation of Y, E and cost function J.
Y = sigmoid(X(:,1:3)*W);
E = X(:,4) - Y;
J = 1/2*E'*E;

% as long as J is greater than threshold, continue iteration.
% initialisation of J and and W and creation of J vector.
J_old = J;
W_old = W;
J_vector = J;
while true
    W = W_old+eta*(X(:,1:3)'*E);
    Y = sigmoid(X(:,1:3)*W);
    E = X(:,4) - Y;
    J = 1/2*E'*E;
    J_vector = [J_vector, J];
    if J <= threshold;
        break
    end
    J_old = J;
    W_old = W;
end
funcplane = @(x,y) -(W(1)/W(3))*x -(W(2)/W(3))*y;
ezsurf(funcplane,[-5 5],[-5 5],2);
xlim([-10 10]);
ylim([-10 10]);
zlim([-10 10]);
view([45,30])
figure()
plot(J_vector)
title('Cost Function with respect Iteration number');