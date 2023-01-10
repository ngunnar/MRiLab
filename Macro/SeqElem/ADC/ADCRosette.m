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

debug = false;
if debug
    k = KMax*sin(w1*T_excitation).*exp(w2*T_excitation*1j);
    k_start = k(1);
    k_end = k(end);
    disp([k_start, k_end]);
    figure
    plot(k)
    hold on
    plot(complex(k(1)), '*')
    plot(complex(k(end)), 'o')
    hold off
end
end

