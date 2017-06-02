function test_data = deneme(data_path)

% getting class names into a cell array
class_names = cell(180,1);
names = dir(data_path);
for i=4:length(names)
    class_names{i-3} = names(i).name;
end

for i=1:length(class_names)
    name = class_names{i}
    dir_path = strcat(data_path, '/', name, '/', 'train');
    files = dir(dir_path);
    for j=4:length(files)
        files(i).name 
    end
    break
end
% test_data(1).name = class_names{1};
% test_data(1).hog = dummy1;

end