clear;
clc;

// ===================== STAR (1–6) =====================
sStart = [1 1 1 1 1];
sEnd   = [2 3 4 5 6];

xStar = [100 200 200 200 200 200];
yStar = [500 400 600 350 650 275];

// ===================== RING (7–14) =====================
rStart = [7 8 9 10 11 12 13 14];
rEnd   = [8 9 10 11 12 13 14 7];

angle = 0:%pi/4:(7*%pi/4);
xRing = 300 + 80*cos(angle);
yRing = 300 + 80*sin(angle);

// ===================== TREE (15–25) =====================
tStart = [15 15 15 15 16 16 17 17 18 19];
tEnd   = [16 17 18 19 20 21 22 23 24 25];

xTree = [500 520 480 540 500 520 460 600 400 580 460];
yTree = [500 450 450 450 350 350 300 300 350 300 300];

// ===================== MERGE =====================
nodesTotal = 25;

startAll = [sStart rStart tStart];
endAll   = [sEnd   rEnd   tEnd];

xAll = [xStar xRing xTree];
yAll = [yStar yRing yTree];

// ===================== BRIDGES =====================
bridgeStart = [1 10];
bridgeEnd   = [7 15];

startAll = [startAll bridgeStart];
endAll   = [endAll bridgeEnd];

edgesTotal = length(startAll);

// ===================== DISPLAY =====================
scf(1);
clf();
plot(xAll, yAll, 'ro');
h = gce();
h.children.mark_size = 8;

// Draw edges
for i = 1:edgesTotal
    xpoly([xAll(startAll(i)) xAll(endAll(i))], ...
          [yAll(startAll(i)) yAll(endAll(i))], "lines");
end

// ===================== NUMBER NODES =====================
for i = 1:nodesTotal
    xstring(xAll(i)+10, yAll(i)+10, "N"+string(i));
end

// ===================== NUMBER EDGES =====================
for i = 1:edgesTotal
    xm = (xAll(startAll(i)) + xAll(endAll(i)))/2;
    ym = (yAll(startAll(i)) + yAll(endAll(i)))/2;
    xstring(xm, ym, "E"+string(i));
end

xtitle("Hybrid Topology: Star + Ring + Tree");

// ===================== DEGREE CALCULATION =====================
degree = zeros(1, nodesTotal);

for i = 1:edgesTotal
    degree(startAll(i)) = degree(startAll(i)) + 1;
    degree(endAll(i))   = degree(endAll(i)) + 1;
end

disp("Node-wise number of edges:");
for i = 1:nodesTotal
    disp("Node " + string(i) + " : " + string(degree(i)));
end

[maxDeg, maxNode] = max(degree);
disp("Node with maximum edges: Node " + string(maxNode));
disp("Maximum number of edges: " + string(maxDeg));

// ===================== TOTAL COUNTS =====================
disp("Total number of nodes: " + string(nodesTotal));
disp("Total number of edges: " + string(edgesTotal));
