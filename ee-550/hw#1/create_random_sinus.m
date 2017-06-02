function output = create_random_sinus(size)

output = ones(size,2);
for i=1:size
   x = 2*pi*rand(1,1);
   output(i,1) = x;
   output(i,2) = sin(x);
end
end