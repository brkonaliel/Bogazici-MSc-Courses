function score = histogram_intersection(a,b)
    score = 0;
    for i=1:length(a)
       score = score + min(a(i),b(i)); 
    end
end