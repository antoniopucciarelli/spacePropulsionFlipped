% Flipped class project 
% MSc in aeronautical engineering
% Space propulsion course
%
% Initial data: pressure trace of 27 static firings of a SRM using the same propellant composition (HTPB + Al + NH4ClO4)
% but from different manufacturing batches (# of batches 9). From these 27 static firings, it has been used 3 different nozzles.
% These 3 nozzles allow to have different combustion chamber pressures traces (3 nozzles each firing for each batch -> 3x9 tests).  
%  
% Aim: 
%   - find the [a, n] parameters of the Vielle's law for the modeling of the combustion behaviour.
%   - simulate the combustion behaviour of 3 SRM with different nozzles using the computed [a, n].
%   - compute a Monte Carlo simulation of the burning time using the computed [a, n] and the 3 different nozzles.
%
clc
clear 
close all 

% loading data 
load tracesbar1.mat;

% plotting data -> it allows to understand the pressure traces for each firing test.
run plotData.m; 

% computing effective pressure and burning rate 
PeffVec = zeros(1,27);
RbVec = zeros(1,27);

% web 
web = 3e-2;

% pbar2438 analysis
[RbVec(1), PeffVec(1)] = reactionRate(pbar2438(:,1), web, 5, false);
[RbVec(2), PeffVec(2)] = reactionRate(pbar2438(:,2), web, 5, false);
[RbVec(3), PeffVec(3)] = reactionRate(pbar2438(:,3), web, 5, false);
% pbar2439 analysis
[RbVec(4), PeffVec(4)] = reactionRate(pbar2439(:,1), web, 5, false);
[RbVec(5), PeffVec(5)] = reactionRate(pbar2439(:,2), web, 5, false);
[RbVec(6), PeffVec(6)] = reactionRate(pbar2439(:,3), web, 5, false);
% pbar2440 analysis
[RbVec(7), PeffVec(7)] = reactionRate(pbar2440(:,1), web, 5, false);
[RbVec(8), PeffVec(8)] = reactionRate(pbar2440(:,2), web, 5, false);
[RbVec(9), PeffVec(9)] = reactionRate(pbar2440(:,3), web, 5, false);
% pbar2441 analysis
[RbVec(10), PeffVec(10)] = reactionRate(pbar2441(:,1), web, 5, false);
[RbVec(11), PeffVec(11)] = reactionRate(pbar2441(:,2), web, 5, false);
[RbVec(12), PeffVec(12)] = reactionRate(pbar2441(:,3), web, 5, false);
% pbar2442 analysis
[RbVec(13), PeffVec(13)] = reactionRate(pbar2442(:,1), web, 5, false);
[RbVec(14), PeffVec(14)] = reactionRate(pbar2442(:,2), web, 5, false);
[RbVec(15), PeffVec(15)] = reactionRate(pbar2442(:,3), web, 5, false);
% pbar2443 analysis
[RbVec(16), PeffVec(16)] = reactionRate(pbar2443(:,1), web, 5, false);
[RbVec(17), PeffVec(17)] = reactionRate(pbar2443(:,2), web, 5, false);
[RbVec(18), PeffVec(18)] = reactionRate(pbar2443(:,3), web, 5, false);
% pbar2444 analysis
[RbVec(19), PeffVec(19)] = reactionRate(pbar2444(:,1), web, 5, false);
[RbVec(20), PeffVec(20)] = reactionRate(pbar2444(:,2), web, 5, false);
[RbVec(21), PeffVec(21)] = reactionRate(pbar2444(:,3), web, 5, false);
% pbar2435 analysis
[RbVec(22), PeffVec(22)] = reactionRate(pbar2445(:,1), web, 5, false);
[RbVec(23), PeffVec(23)] = reactionRate(pbar2445(:,2), web, 5, false);
[RbVec(24), PeffVec(24)] = reactionRate(pbar2445(:,3), web, 5, false);
% pbar2446 analysis
[RbVec(25), PeffVec(25)] = reactionRate(pbar2446(:,1), web, 5, false);
[RbVec(26), PeffVec(26)] = reactionRate(pbar2446(:,2), web, 5, false);
[RbVec(27), PeffVec(27)] = reactionRate(pbar2446(:,3), web, 5, false);

% computing vielle's law with uncertainties
[a, Inc_a, n, Inc_n, R2] = Uncertainty(PeffVec, RbVec);

% computing standard deviation from uncertainties with a confidence interval of 90%
z    = 1.64;                    % this parameter is related to the confidence level 
aSTD = Inc_a * sqrt(27) / z;    % a coefficient standard deviation -> # of tests = 27
nSTD = Inc_n * sqrt(27) / z;    % n exponent standard deviation -> # of tests = 27

% printing results
fprintf('UNCERTAINTIES:\n');
fprintf('\ta     = %f m/bar^n\n', a);
fprintf('\tInc_a = %f \n', Inc_a);
fprintf('\tstd_a = %f \n', aSTD);
fprintf('\tn     = %f \n', n);
fprintf('\tInc_n = %f \n', Inc_n);
fprintf('\tstd_n = %f \n\n', nSTD);

%% firings
% SRM data allocation -> grain dimensions properties 
outDiam   = 160e-3;
innerDiam = 100e-3;
len       = 290e-3;
% setting up cStar -> this parameter is computed from the results given by the NASA CEA
cStar = 1330;
% setting up time interval for the study
deltaT = 1e-4;
% total density computation 
percNH4ClO4 = 68/100;
percAl      = 18/100;
percHTPB    = 14/100;
rhoNH4ClO4  = 1.95 * 1e-3 / (1e-2)^3;
rhoAl       = 2.7 * 1e-3 / (1e-2)^3;
rhoHTPB     = 0.92 * 1e-3 / (1e-2)^3;
rhop        = 1 / (percNH4ClO4/rhoNH4ClO4 + percAl/rhoAl + percHTPB/rhoHTPB);

% simulating baria motor low pressure nozzle 
throatDiam = 28.8e-3;
dimensions = [outDiam, innerDiam, throatDiam, len];
[~, ~, ~, ~, ~] = baria(a, n, cStar, rhop, deltaT, dimensions, true, 'LOW PRESSURE');
% simulating baria motor mid pressure nozzle 
throatDiam = 25.25e-3;
dimensions = [outDiam, innerDiam, throatDiam, len];
[~, ~, ~, ~, ~] = baria(a, n, cStar, rhop, deltaT, dimensions, true, 'MID PRESSURE');
% simulating baria motor high pressure nozzle
throatDiam = 21.81e-3;
dimensions = [outDiam, innerDiam, throatDiam, len]; 
[~, ~, ~, ~, ~] = baria(a, n, cStar, rhop, deltaT, dimensions, true, 'HIGH PRESSURE');

%% monte carlo simulation -- low pressure
% setting up nozzle dimensions -> combustion chamber pressure 
throatDiam = 28.8e-3;
dimensions = [outDiam, innerDiam, throatDiam, len];

% relative tolerances setup
meanTol      = 5e-4;
deviationTol = 5e-4;

% setting up additional loop constraints
nMax = 200;

% running monte carlo simulation
[aVec, nVec, tVec, meanVec, deviationVec, aRelUncertainty, nRelUncertainty, tRelUncertainty] = monteCarlo(a, n, Inc_a, Inc_n, aSTD, nSTD, cStar, rhop, deltaT, dimensions, meanTol, deviationTol, nMax, z, 'LOW PRESSURE');

% saving results
save monteCarlo-lowPressure.mat aVec nVec tVec meanVec deviationVec aRelUncertainty nRelUncertainty tRelUncertainty;

%% monte carlo simulation -- mid pressure 
% setting up nozzle -> combustion chamber pressure 
throatDiam = 25.25e-3;
dimensions = [outDiam, innerDiam, throatDiam, len];

% relative tolerances setup
meanTol      = 5e-4;
deviationTol = 5e-4;

% setting up additional loop constraints
nMax = 200;

% running monte carlo simulation
[aVec, nVec, tVec, meanVec, deviationVec, aRelUncertainty, nRelUncertainty, tRelUncertainty] = monteCarlo(a, n, Inc_a, Inc_n, aSTD, nSTD, cStar, rhop, deltaT, dimensions, meanTol, deviationTol, nMax, z, 'MID PRESSURE');

% saving results
save monteCarlo-midPressure.mat aVec nVec tVec meanVec deviationVec aRelUncertainty nRelUncertainty tRelUncertainty;

%% monte carlo simulation -- high pressure 
throatDiam = 21.81e-3;
dimensions = [outDiam, innerDiam, throatDiam, len];

% relative tolerances setup
meanTol      = 5e-4;
deviationTol = 5e-4;

% setting up additional loop constraints
nMax = 200;

% running monte carlo simulation
[aVec, nVec, tVec, meanVec, deviationVec, aRelUncertainty, nRelUncertainty, tRelUncertainty] = monteCarlo(a, n, Inc_a, Inc_n, aSTD, nSTD, cStar, rhop, deltaT, dimensions, meanTol, deviationTol, nMax, z, 'HIGH PRESSURE');

% saving results
save monteCarlo-highPressure.mat aVec nVec tVec meanVec deviationVec aRelUncertainty nRelUncertainty tRelUncertainty;
