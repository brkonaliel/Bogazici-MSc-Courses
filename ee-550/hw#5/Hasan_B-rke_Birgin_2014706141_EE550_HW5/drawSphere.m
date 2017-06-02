function  drawSphere

r = 1;
i = 1;
for a = 0:20:180;
 for b = 0:1:360;
x=r*sind(b)*cosd(a);
y=r*sind(b)*sind(a);
z=r*cosd(b);
points(i,:) = [x y z];
i = i+1;
 end
end
hold on
plot3(points(:,1),points(:,2),points(:,3),'color',[0.8 0.8 0.8])
end

