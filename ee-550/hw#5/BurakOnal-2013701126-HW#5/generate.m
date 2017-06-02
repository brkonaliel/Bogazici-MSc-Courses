function [point] = generate(azimuth,polar_angle)
r = 1;
x=r*sind(polar_angle)*cosd(azimuth);
y=r*sind(polar_angle)*sind(azimuth);
z=r*cosd(polar_angle);

point = [x y z];
end

