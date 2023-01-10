function [GAmp, GTime] = Get_Rosette_Shared(p)
global VCtl;
global VObj;
global VVar;

dt = p.dt;

% 2D spiral encoding
FOV = VCtl.FOVFreq; % 20cm
Res = VCtl.ResFreq; % 184 samples

KMax  = Res / (2*FOV); % 4.60cm^-1 = 460m^-1 -> Resolution 1.09mm
gamma = VObj.Gyro; % 42.58e6*2*pi;

peak_MAX = VCtl.MaxGrad;% 10 mT/m = 10e-3 T/m
slew_MAX = VCtl.MaxSlewRate;% 13mT/m/ms = 13 T/m/s

cycles = VCtl.CyclePerTR;% 2.5;

w1 = peak_MAX*gamma/(2*pi*KMax);% 147*2*pi; % n1 = 150?
w2 = sqrt(slew_MAX*gamma/(2*pi*KMax) - w1^2); % n2 = 17?

T_period = linspace(0, cycles*2*pi/w1, cycles*2*pi/w1/dt);
TE = VCtl.TE;
t_readout = T_period(end);

% Gtime is the readout time
GTime = TE-t_readout/2 + T_period;

% Ts is actual time for rosette function, i.e continue where it stops from last
% excitation
T_g = T_period + (VVar.TRCount-1)*t_readout;
k = KMax*sin(w1*T_g).*exp(1i*w2*T_g);
%disp([k(1) k(end)])
GAmp =  pi/gamma*KMax*((w1+w2)*exp(1i*(w1+w2)*T_g) + (w1-w2)*exp(-1i*(w1-w2)*T_g));

if GTime(1) < VCtl.TE/2
    GTime = (VCtl.TE/2-GTime(1)+2*0.4e-3) + GTime;
end
end

