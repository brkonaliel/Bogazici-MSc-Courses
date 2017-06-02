function label = perform_late_fusion(hog_prob, texton_prob, color_prob)
    label = ones(length(hog_prob), 1)*-1;
    prob = (hog_prob+texton_prob+color_prob)/3;
    [~, I] = max(prob, [], 2);
    indices = find(I==2);
    label(indices) = -1;
end