function [Rb, Peff] = reactionRate (pressure, web, target, graph)
% This code computes the reaction rate of a solid propellant given the pressure trace of a 
% firing test. The pressure is related to the reaction rate using the Bayer Chemie method.
% 
% Input: pressure
% Output: reaction rate 

% computing max pressure: value and position
[Pmax, maxPos] = max(pressure(200:end-200)); 

% getting target% of the max pressure -> in relation to the Bayer-Chemie method 
Ptarget = target/100 * Pmax; 

%% find the first position of the Ptarget in the pressure array
% ignition study 
counter = 1;
found = false;

% loop on the first half of the pressure curve
while !found && maxPos - counter > 0
  if pressure(maxPos - counter) > Ptarget
    counter = counter + 1;
  else
    found = true; 
    ignitionPos = maxPos - counter;
  endif
endwhile

if !found 
  % print error
  error('Ignition pressure has not been found.')
endif

% extintion study
counter = 1;
found = false; 

% loop on the second half of the pressure curve
while !found && maxPos + counter < length(pressure)
  if pressure(maxPos + counter) > Ptarget 
    counter = counter + 1; 
  else 
    found = true;
    extintionPos = maxPos + counter; 
  endif
endwhile

if !found
  % print error
  error('Extintion pressure has not been found.')
endif

% computing reference pressure 
% computing burning time interval
deltaT = extintionPos - ignitionPos;

% using trapezoid integration 
pressureIntegral = 0.0;
for ii = ignitionPos+1:extintionPos
  pressureIntegral = pressureIntegral + (pressure(ii) + pressure(ii-1))/2;
endfor

% setting up I value used in Bayer-Chemie model
I = pressureIntegral / 2;

% reference pressure Bayer-Chemei
Pref = I / deltaT;

% computing reference ignition and extintion points
% ignition study 
counter = 1;
found = false;

% loop on the first half of the pressure curve
while !found && maxPos - counter > 0
  if pressure(maxPos - counter) > Pref
    counter = counter + 1;
  else
    found = true; 
    ignitionEffPos = maxPos - counter;
  endif
endwhile

if !found
  % print error
  error('Ignition reference pressure has not been found.')
endif

% extintion study
counter = 1;
found = false; 

% loop on the second half of the pressure curve
while !found && maxPos + counter < length(pressure)
  if pressure(maxPos + counter) > Pref 
    counter = counter + 1; 
  else 
    found = true;
    extintionEffPos = maxPos + counter;
  endif
endwhile

if !found
  % print error
  error('Extintion reference pressure has not been found.')
endif

% computing effection pressure integral 
pressureIntegral = 0.0;

% computing reference time interval
deltaT = extintionEffPos - ignitionEffPos;

% using trapezoid integration 
pressureIntegral = 0.0;
for ii = ignitionEffPos+1:extintionEffPos
  pressureIntegral = pressureIntegral + (pressure(ii) + pressure(ii-1))/2;
endfor

% computing effective pressure 
Peff = pressureIntegral/deltaT;

% burning rate 
deltaT = deltaT / 1e+3;
Rb = web/deltaT;

% plotting data 
if graph
  figure(1, 'position', [0, 0, 700, 600])
  plot(pressure, 'k', 'linewidth', 3);
  hold on 
  plot(maxPos+200, Pmax, 'go', 'linewidth', 5)
  plot(extintionPos, pressure(extintionPos), 'ro', 'linewidth', 5)
  plot(extintionEffPos, pressure(extintionEffPos), 'bo', 'linewidth', 5)
  plot(ignitionPos, pressure(ignitionPos), 'ro', 'linewidth', 5)
  plot(ignitionEffPos, pressure(ignitionEffPos), 'bo', 'linewidth', 5) 
  grid on 
  grid minor
  h = legend('pressure', 'max pressure', 'combustion', 'reference');
  legend (h, "location", "northeastoutside");
  xlabel('time [ms]')
  ylabel('pressure [bar]')
endif

endfunction