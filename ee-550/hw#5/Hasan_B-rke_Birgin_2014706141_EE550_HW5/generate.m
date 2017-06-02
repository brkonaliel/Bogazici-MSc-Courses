function [Point] = generate(azimuth,altitude,vec)
r = 1;
x=r*sind(altitude)*cosd(azimuth);
y=r*sind(altitude)*sind(azimuth);
z=r*cosd(altitude);

plot3(x,y,z,'*','color',vec)
Point = [x y z];
end

