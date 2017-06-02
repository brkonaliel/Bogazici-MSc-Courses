function result = max_windowing(temp, window_size)
%     window_size = [8, 8];
    sz = size(temp);
    m_w = window_size(1);
    n_w = window_size(2);
    assert(m_w==floor(m_w)&&n_w==floor(n_w), 'Matrix size and window size must match');
    m = sz(1);
    n = sz(2);
    m_r = m/m_w;
    n_r = n/n_w;
    result = ones(m_r, n_r);
    for k=1:m_w:m
        for j=1:n_w:n
            result(floor(k/m_w)+1, floor(j/n_w)+1) = max(max(temp(k:k+m_w-1,j:j+n_w-1)));
        end
    end
end
