function [B, b] = create_random_input(size, sigma)
% Creates a random input matrix and a vector given size and sigma. Sigma is
% the standart deviation of the normal distribution.
B = sign(sigma*randn(size));
b = reshape(B, [size*size,1]);