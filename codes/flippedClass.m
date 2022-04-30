% Flipped class project 

% loading data 
load tracesbar1.mat;

% plotting data
%run plotData.m; 

% computing effective pressure and burning rate 
PeffVec = zeros(1,27);
RbVec = zeros(1,27);

% web 
web = 3e-2;

% pbar2438 analysis
[RbVec(1), PeffVec(1)] = reactionRate (pbar2438(:,1), web, 5, false);
[RbVec(2), PeffVec(2)] = reactionRate (pbar2438(:,2), web, 5, false);
[RbVec(3), PeffVec(3)] = reactionRate (pbar2438(:,3), web, 5, false);
% pbar2439 analysis
[RbVec(4), PeffVec(4)] = reactionRate (pbar2439(:,1), web, 5, false);
[RbVec(5), PeffVec(5)] = reactionRate (pbar2439(:,2), web, 5, false);
[RbVec(6), PeffVec(6)] = reactionRate (pbar2439(:,3), web, 5, false);
% pbar2440 analysis
[RbVec(7), PeffVec(7)] = reactionRate (pbar2440(:,1), web, 5, false);
[RbVec(8), PeffVec(8)] = reactionRate (pbar2440(:,2), web, 5, false);
[RbVec(9), PeffVec(9)] = reactionRate (pbar2440(:,3), web, 5, false);
% pbar2441 analysis
[RbVec(10), PeffVec(10)] = reactionRate (pbar2441(:,1), web, 5, false);
[RbVec(11), PeffVec(11)] = reactionRate (pbar2441(:,2), web, 5, false);
[RbVec(12), PeffVec(12)] = reactionRate (pbar2441(:,3), web, 5, false);
% pbar2442 analysis
[RbVec(13), PeffVec(13)] = reactionRate (pbar2442(:,1), web, 5, false);
[RbVec(14), PeffVec(14)] = reactionRate (pbar2442(:,2), web, 5, false);
[RbVec(15), PeffVec(15)] = reactionRate (pbar2442(:,3), web, 5, false);
% pbar2443 analysis
[RbVec(16), PeffVec(16)] = reactionRate (pbar2443(:,1), web, 5, false);
[RbVec(17), PeffVec(17)] = reactionRate (pbar2443(:,2), web, 5, false);
[RbVec(18), PeffVec(18)] = reactionRate (pbar2443(:,3), web, 5, false);
% pbar2444 analysis
[RbVec(19), PeffVec(19)] = reactionRate (pbar2444(:,1), web, 5, false);
[RbVec(20), PeffVec(20)] = reactionRate (pbar2444(:,2), web, 5, false);
[RbVec(21), PeffVec(21)] = reactionRate (pbar2444(:,3), web, 5, false);
% pbar2435 analysis
[RbVec(22), PeffVec(22)] = reactionRate (pbar2445(:,1), web, 5, false);
[RbVec(23), PeffVec(23)] = reactionRate (pbar2445(:,2), web, 5, false);
[RbVec(24), PeffVec(24)] = reactionRate (pbar2445(:,3), web, 5, false);
% pbar2446 analysis
[RbVec(25), PeffVec(25)] = reactionRate (pbar2446(:,1), web, 5, false);
[RbVec(26), PeffVec(26)] = reactionRate (pbar2446(:,2), web, 5, false);
[RbVec(27), PeffVec(27)] = reactionRate (pbar2446(:,3), web, 5, false);

% computing vielle's law with uncertainties
[a, Inc_a, n, Inc_n, R2] = Uncertainty(PeffVec, RbVec)

%% firings
% SRM data allocation 
outDiam     = 160e-3;
innerDiam   = 100e-3;
len         = 290e-3;
dimensions  = [outDiam, innerDiam, throatDiam, len];
% setting up cStar
cStar       = 1560;
% setting up time interval for the study
deltaT      = 1e-4;
% total density computation 
percNH4ClO4 = 68/100;
percAl      = 18/100;
percHTPB    = 14/100;
rhoNH4ClO4  = 1.95 * 1e-3 / (1e-2)^3;
rhoAl       = 2.7 * 1e-3 / (1e-2)^3;
rhoHTPB     = 0.92 * 1e-3 / (1e-2)^3;
rhop        = 1 / (percNH4ClO4/rhoNH4ClO4 + percAl/rhoAl + percHTPB/rhoHTPB);

% simulating baria motor low pressure nozzle 
throatDiam  = 28.8e-3;
dimensions  = [outDiam, innerDiam, throatDiam, len];
[time, pVec, x, y, RbVec] = baria(a, n, cStar, rhop, deltaT, dimensions, true);
% simulating baria motor mid pressure nozzle 
throatDiam  = 25.25e-3;
dimensions  = [outDiam, innerDiam, throatDiam, len];
[time, pVec, x, y, RbVec] = baria(a, n, cStar, rhop, deltaT, dimensions, true);
% simulating baria motor high pressure nozzle
throatDiam  = 21.81e-3;
dimensions  = [outDiam, innerDiam, throatDiam, len]; 
[time, pVec, x, y, RbVec] = baria(a, n, cStar, rhop, deltaT, dimensions, true);

%% monte carlo simulation 
rng('default');
deviation = [];
mean      = [];



