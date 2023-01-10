function [GAmp,GTime] = ADCRosette(p)
global VCtl;

[GAmp, GTime] = Get_Rosette_Shared(p);

tStart = GTime(1);
tEnd = GTime(end);
    
[GAmp,GTime]=StdTrap(tStart-VCtl.MinUpdRate, ...
                     tEnd+VCtl.MinUpdRate, ...
                     tStart,               ...
                     tEnd,               ...
                     1,2,floor(tEnd*VCtl.BandWidth),2);

[GTime,m,n]=unique(GTime);
GAmp=GAmp(m);
end

