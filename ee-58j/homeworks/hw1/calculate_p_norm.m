function p_norm = calculate_p_norm(x, p)
p_norm = 0;
for i=1:length(x)
    p_norm = p_norm + abs(x(i)^p);
end

p_norm = nthroot(p_norm, p);

end