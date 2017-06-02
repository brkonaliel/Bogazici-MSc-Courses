function random_image_selector(data_path) 
% data_path = '/Users/burakonal/Desktop/edu_backup/ee-58j/PIRC2017_02';
names = dir(data_path);
for i=1:length(names)
    if ~(names(i).name(1)=='.')
        images = dir(strcat(data_path, '/', names(i).name));
        random_vector = randperm(length(images));
        save_path = strcat(data_path, '/', names(i).name, '/random_vector', '.mat');
        save(save_path, 'random_vector');
    end
end
end