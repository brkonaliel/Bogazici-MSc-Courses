seamount = load('seamount.mat');
lat = seamount.y;
lon = seamount.x;
worldmap([-49 -47.5],[-150 -147.5])
scatterm(lat, lon, 5, seamount.z);
scaleruler
