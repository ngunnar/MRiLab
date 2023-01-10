function [GAmp,GTime] = GyRosette(p)
[GAmp, GTime] = Get_Rosette_Shared(p);
[GAmp, GTime] = Fix_slew_rate(imag(GAmp), GTime);
end