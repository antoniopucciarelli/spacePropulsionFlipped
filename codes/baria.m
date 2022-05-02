function [time, pVec, x, y, RbVec] = baria(a, n, cStar, rhop, deltaT, dimensions, graph, titleName)
% This program computes the development of burning in a solid rocket motor -- BARIA type 
% dimensions: [outDiam, innerDiam, throatDiam, lenght]

% dimensions allocation
outDiam    = dimensions(1);
innerDiam  = dimensions(2);
throatDiam = dimensions(3);
len        = dimensions(4);

% throat area computation
At = pi * (throatDiam/2)^2;

% pressure law --> continuity conservation related
% from: Rb * Ab * rhop = At * P0 / c* 
% !!! P0 in the RHS is in Pa -> converting it into bar as so:
% Rb * Ab * rhop = At * P0[bar] * 1e+5 * c*
% Rb is modeled with Vielle's law: Rb = a * P0^n; where P0 is in bar
% a * P0^n * Ab * rhop = At * P0 / c* -> computing P0 as P0 = (a * rhop * Ab/At * c* / 1e+5)^(1/(1-n))
p = @(Ab) (a * rhop * Ab/At * cStar / 1e+5)^(1/(1-n));

% initial point allocation
x0 = len/2;
y0 = (outDiam - innerDiam)/2;

% x, y vector -> in order to track surface behaviour
x     = [x0];
y     = [y0]; 
pVec  = [];
RbVec = [];
time  = [0];

while x(end) > 0 && y(end) > 0  
    % tracking upper right corner in order to understand if the combustion is over 
    % cylinder area computation
    Sb = (outDiam/2 - y(end)) * 2 * pi * 2 * x(end);
    % lateral area computation 
    Sa = 2 * ((outDiam/2)^2 * pi - (outDiam/2 - y(end))^2 * pi); 
    
    % computing pressure in order to compute burning rate 
    pVec = [pVec, p(Sa + Sb)];

    % computing burning rate 
    RbVec = [RbVec, a*pVec(end)^n];

    % computing regressed surface
    x = [x, x(end) - RbVec(end) * deltaT];
    y = [y, y(end) - RbVec(end) * deltaT];
    % computing time
    time = [time, time(end) + deltaT];
end

if graph
    figure
    subplot(311)
    plot(time, x, 'r', 'linewidth', 3);
    hold on
    plot(time, y, 'b', 'linewidth', 3);
    legend({'x', 'y'}, 'Location', 'southeast');
    xlabel('time [s]')
    ylabel('grain dimensions [m]')
    grid on 
    grid minor 
    subplot(312)
    plot(time(2:end), pVec, 'g', 'linewidth', 3);
    legend({'pressure'}, 'Location', 'southeast');
    xlabel('time [s]')
    ylabel('pressure [bar]')
    grid on 
    grid minor 
    subplot(313)
    plot(time(2:end), RbVec*1e+3, 'm', 'linewidth', 3);
    xlabel('time [s]')
    ylabel('regression rate')
    legend({'r_b [mm/s]'}, 'Location', 'southeast');
    grid on 
    grid minor 
    sgtitle(titleName)
end

end 