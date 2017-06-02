function class_names = read_data(data_path)
names = dir(data_path);

% fixing the random seed

% output = datasample(stream, data, k);
class_names = cell(20,1);
j = 1;
for i=1:length(names)
    if names(i).name(1) == '.' || length(names(4).name) < 4
        continue
    end
    class_names{j} = names(i).name;
    j = j+1;
end
stream = RandStream('mt19937ar', 'Seed', 100);
for i=1:length(class_names)
    name = class_names{i};
    dir_path = strcat(data_path, '/', name);
    image_names = dir(dir_path);
    
end
end

    