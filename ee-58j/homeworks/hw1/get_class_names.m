function class_names = get_class_names(data_path)
class_names = cell(180,1);
names = dir(data_path);
for i=4:length(names)
    class_names{i-3} = names(i).name;
end
end