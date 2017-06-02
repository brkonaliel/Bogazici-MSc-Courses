close all; clc; clear;

% parameters
size = 8;
input_patterns = [1,2,4,7,8];
len = length(input_patterns);

% Creation of input patterns
% Input pattern vectors are stored in a list called input_vector
% Input pattern matrices are stored in a list called input_matrix
for i=1:len
   [temp_matrix, temp_vector] = create_number(input_patterns(i), size);
   input_vector_list{i} = temp_vector;
   input_matrix_list{i} = temp_matrix;
end

% Noise with 3 different variance level
% Noise signal is stored in a list called noise_list
for sigma=1:3
   noise = sqrt(sigma)*randn(8);
   for i=1:len
      noise_matrix_list{(sigma-1)*5+i} = sign(input_matrix_list{i}+noise); 
   end
end

% Creation of T matrix based on the list described above.
T = create_T_matrix(input_matrix_list, size);

% recovery of noise signal is saved into a list called recovery_matrix_list
for sigma=1:3
   for i=1:len
      old = reshape(noise_matrix_list{(sigma-1)*5+i},[size*size,1]);
      iteration = 0;
      while true
        iteration = iteration + 1;
        current = sign(T*old);
        if current == old
            break
        end
        old = current; 
      end
      recovery_matrix_list{(sigma-1)*5+i} = reshape(current, [size, size]);
   end
end

for i=1:len
   figure()
   subimage(input_matrix_list{i})
   title('Input', 'FontSize',14)
   figure()
   subplot(2,3,1), subimage(noise_matrix_list{i})
   title('Input with var=1', 'FontSize',14)
   subplot(2,3,2), subimage(noise_matrix_list{i+len})
   title('Input with var=2', 'FontSize',14)
   subplot(2,3,3), subimage(noise_matrix_list{i+2*len})
   title('Input with var=3', 'FontSize',14)
   subplot(2,3,4), subimage(recovery_matrix_list{i})
   title('Recovery from var=1', 'FontSize',14)
   subplot(2,3,5), subimage(recovery_matrix_list{i+len})
   title('Recovery from var=2', 'FontSize',14)
   subplot(2,3,6), subimage(recovery_matrix_list{i+2*len})
   title('Recovery from var=3', 'FontSize',14)
end
