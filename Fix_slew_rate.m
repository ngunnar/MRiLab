function [GAmp, GTime] = Fix_slew_rate(GAmp, GTime)
    global VCtl    
    
    % Step 1: Create an ramp to the first value in the gradient if needed.
    % We let this ramp we before the ADC-readout.
    tRamp =max(VCtl.MinUpdRate,abs(GAmp(1))/VCtl.MaxSlewRate);   % ramp time
    [Grad_up,time_up]=StdRamp(GTime(1)-tRamp,GTime(1),0, GAmp(1),2);% up ramp
    
    % Step 2: If a ramp was created, compenseate for the movement in
    % k-space by move in the opposite direction. We place the movement
    % before the 180 rf-pulse (where we have space)
    if any(Grad_up~=0)
        tStart = VCtl.TE/4;
        [g1,t1]=StdRamp(tStart-tRamp,tStart,0, -GAmp(1)/2,2);% up ramp
        [g2,t2]=StdRamp(t1(end),t1(end)+tRamp,-GAmp(1)/2, 0,2);% up ramp
        GAmp = [-g1 -g2 Grad_up GAmp];
        GTime = [t1 t2 time_up GTime];       
    end   
    
    % Step 3: Create a ramp from the last timestamp in the gradient to
    % zero. This ramp is placed after the ADC-readout.
    tRamp =max(VCtl.MinUpdRate,abs(GAmp(end))/VCtl.MaxSlewRate);   % ramp time
    [Grad_down,time_down]=StdRamp(GTime(end),GTime(end)+tRamp,GAmp(end),0,2); %down ramp
    GAmp = [GAmp Grad_down];
    GTime = [GTime time_down];
    
    [GTime,m,n]=unique(GTime);
    GAmp=GAmp(m);
end

