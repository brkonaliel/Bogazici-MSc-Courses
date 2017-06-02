Samples = zeros(Count,input+1);
for i = 1:Count
    sign = (-1)^(mod(ceil(100000*rand),2));
    for j = 1:input
        Samples(i,j) = 5*sign*rand+sqrt(var)*randn;     
    end
    for j = input + 1
        if sign == 1
            Samples(i,j) = 1;
        else
            Samples(i,j) = -1;
        end
    end   
end
