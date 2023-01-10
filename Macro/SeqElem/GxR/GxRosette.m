function [GAmp,GTime] = GxRosette(p)
[GAmp, GTime] = Get_Rosette_Shared(p);
[GAmp, GTime] = Fix_slew_rate(real(GAmp), GTime);
end
