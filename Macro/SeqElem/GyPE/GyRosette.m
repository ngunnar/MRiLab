function [GAmp,GTime] = GyRosette(p)

[GAmp, Gx, Gy, GTime, GTimeX, GTimeY] = Get_Rosette_Shared(p);

GAmp = Gy;
GTime = GTimeY;
end