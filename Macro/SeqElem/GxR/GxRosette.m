function [GAmp,GTime] = GxRosette(p)

[GAmp, Gx, Gy, GTime, GTimeX, GTimeY] = Get_Rosette_Shared(p);

GAmp = Gx;
GTime = GTimeX;

end
