function [output] = hardNonLinear(input)

if input > 0
    output = 1;
elseif input < 0
    output = -1;
elseif input == 0
    output = 5;
end

