function  drawRectangle(X,Y,c)
if c == 1
    color = [1,1,0];
else
    color = [0,0,143/255];
end
R = [0.5 -0.5;-0.5 0.5];
Point1 = [X-0.5 Y-0.5];
Point2 = [X+0.5 Y-0.5];
Point3 = [X+0.5 Y+0.5];
Point4 = [X-0.5 Y+0.5];
% plot([Point1(1,1) Point2(1,1)],[Point1(1,2) Point2(1,2)],'k')
% plot([Point2(1,1) Point3(1,1)],[Point2(1,2) Point3(1,2)],'k')
% plot([Point3(1,1) Point4(1,1)],[Point3(1,2) Point4(1,2)],'k')
% plot([Point4(1,1) Point1(1,1)],[Point4(1,2) Point1(1,2)],'k')
fill([Point1(1,1);Point2(1,1);Point3(1,1);Point4(1,1)],...
    [Point1(1,2);Point2(1,2);Point3(1,2);Point4(1,2)],color)

end

