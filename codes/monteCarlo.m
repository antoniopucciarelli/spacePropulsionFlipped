function [aVec, nVec, tVec, meanVec, deviationVec, aRelUncertainty, nRelUncertainty, tRelUncertainty] = monteCarlo(a, n, Inc_a, Inc_n, aSTD, nSTD, cStar, rhop, deltaT, dimensions, meanTol, deviationTol, nMax, z, titleName)
% This program computes the monte carlo simulation of the given SRM modeled with Vielle's law.
% The input and output are normal distributions.
% inputs:
%   - a             -- Vielle's law coefficient
%   - n             -- Vielle's law exponent
%   - Inc_a         -- a coefficient absolute uncertainty
%   - Inc_n         -- n exponent absolute uncertainty
%   - aSTD          -- a coefficient standard deviation assuming a normal distribution
%   - nSTD          -- n exponent standard deviation assuming a normal distribution 
%   - cStar         -- combustion chamber property
%   - rhop          -- propellant density
%   - deltaT        -- simulation time step  
%   - dimensions    -- combusiton chamber initial dimensions 
%       * [liner diameter, initial grain hole diameter, nozzle throat diameter, combustion chamber length]
%   - meanTol       -- relative tolerance of burning time
%   - deviationTol  -- relative tolerance of the standard deviation
%   - nMax          -- max number of iteration in the monte carlo simulation 
%   - z             -- confidence level coefficient
%   - titleName     -- simulation name
%
% outputs:
%   - aVec              -- list of all the random a coefficients in the monte carlo simulation
%   - nVec              -- list of all the random n exponents in the monte carlo simulation
%   - tVec              -- list of all the computed burning time in the monte carlo simulation
%   - meanVec           -- list of all the mean burning time computed during the monte carlo simulation 
%   - deviationVec      -- list of all the standard deviation parameters computed during the monte carlo simulation
%   - aRelUncertainty   -- a coefficient relative uncertainty 
%   - nRelUncertainty   -- n exponent relative uncertainty
%   - tRelUncertainty   -- burning time relative uncertainty
%

% setting up storing values arrays
deviationVec = [];
meanVec      = [];
tVec         = [];
aVec         = [];
nVec         = [];

% setting up errors and tolerances 
% errors name
meanError      = 1; 
deviationError = 1;
% setting up loop controller
errors = true;
% setting up additional loop constraints
counter = 0;

while errors && counter < nMax
    % counter update    
    counter = counter + 1;

    % computing new values for the Monte Carlo simulation 
    aMC = random('Normal', a, aSTD); 
    nMC = random('Normal', n, nSTD); 

    % storing random values
    aVec = [aVec, aMC];
    nVec = [nVec, nMC];
    
    % baria simulation 
    [time, ~, ~, ~, ~] = baria(aMC, nMC, cStar, rhop, deltaT, dimensions, false);
    
    % collecting the burning time -> end of the time vector 
    t = time(end);
    
    % updating storing time vector 
    tVec = [tVec, t];
    
    % computing mean
    meanVec = [meanVec, mean(tVec)];

    % computing standard deviation 
    deviationVec = [deviationVec, std(tVec)];

    % computing errors 
    if length(deviationVec) > 2
        deviationError = abs((deviationVec(end-1) - deviationVec(end))/deviationVec(end));
        meanError      = abs((meanVec(end-1) - meanVec(end))/meanVec(end));
        % checking tolerances
        if deviationError < deviationTol && meanError < meanTol
            errors = false; 
        end
    end
end

% computing relative uncertainty with a confidence level dictated by z
tUncertainty = z * deviationVec(end) / sqrt(counter);

% computing relative uncertainties 
aRelUncertainty = Inc_a / a * 100; 
nRelUncertainty = Inc_n / n * 100; 
tRelUncertainty = tUncertainty / meanVec(end) * 100;

% printing results
fprintf(titleName);
fprintf('\n\ttMean = %f s\n', meanVec(end));
fprintf('\tInc_t = %f\n', tUncertainty);
fprintf('\tstd_t = %f\n', deviationVec(end));
fprintf('\ta rel. uncertainty = %f\n', aRelUncertainty);
fprintf('\tn rel. uncertainty = %f\n', nRelUncertainty);
fprintf('\tt rel. uncertainty = %f\n\n', tRelUncertainty);

% plotting results
figure 
sgtitle(titleName);
subplot(311)
plot(tVec, 'r', 'linewidth', 3);
ylabel('time [s]');
xlabel('iteration');
grid on
grid minor
subplot(312)
plot(meanVec, 'b', 'linewidth', 3);
h = ylabel('$$\overline{t}$$');
set(h,'Interpreter','latex')
xlabel('iteration');
grid on
grid minor
subplot(313)
plot(deviationVec, 'g', 'linewidth', 3);
ylabel('\sigma')
xlabel('iteration');
grid on
grid minor 

end