% This program plots the pressure trace for the different batches
linewidth = 2;

% each batch is tested 3 times with respect to different nozzles -> different chamber pressures 
f = figure(1);
subplot(331)
plot(pbar2438(:,1), 'r', 'linewidth', linewidth)
hold on 
plot(pbar2438(:,2), 'b', 'linewidth', linewidth)
plot(pbar2438(:,3), 'g', 'linewidth', linewidth)
ylabel('pressure [bar]')
xlabel('time [ms]')
title('pbar2438')

subplot(332)
plot(pbar2439(:,1), 'r', 'linewidth', linewidth)
hold on 
plot(pbar2439(:,2), 'b', 'linewidth', linewidth)
plot(pbar2439(:,3), 'g', 'linewidth', linewidth)
ylabel('pressure [bar]')
xlabel('time [ms]')
title('pbar2439')

subplot(333)
plot(pbar2440(:,1), 'r', 'linewidth', linewidth)
hold on 
plot(pbar2440(:,2), 'b', 'linewidth', linewidth)
plot(pbar2440(:,3), 'g', 'linewidth', linewidth)
ylabel('pressure [bar]')
xlabel('time [ms]')
title('pbar2440')

subplot(334)
plot(pbar2441(:,1), 'r', 'linewidth', linewidth)
hold on
plot(pbar2441(:,2), 'b', 'linewidth', linewidth)
plot(pbar2441(:,3), 'g', 'linewidth', linewidth)
ylabel('pressure [bar]')
xlabel('time [ms]')
title('pbar2441')

subplot(335)
plot(pbar2442(:,1), 'r', 'linewidth', linewidth)
hold on
plot(pbar2442(:,2), 'b', 'linewidth', linewidth)
plot(pbar2442(:,3), 'g', 'linewidth', linewidth)
ylabel('pressure [bar]')
xlabel('time [ms]')
title('pbar2442')

subplot(336)
plot(pbar2443(:,1), 'r', 'linewidth', linewidth)
hold on 
plot(pbar2443(:,2), 'b', 'linewidth', linewidth)
plot(pbar2443(:,3), 'g', 'linewidth', linewidth)
ylabel('pressure [bar]')
xlabel('time [ms]')
title('pbar2443')

subplot(337)
plot(pbar2444(:,1), 'r', 'linewidth', linewidth)
hold on 
plot(pbar2444(:,2), 'b', 'linewidth', linewidth)
plot(pbar2444(:,3), 'g', 'linewidth', linewidth)
ylabel('pressure [bar]')
xlabel('time [ms]')
title('pbar2444')

subplot(338)
plot(pbar2445(:,1), 'r', 'linewidth', linewidth)
hold on 
plot(pbar2445(:,2), 'b', 'linewidth', linewidth)
plot(pbar2445(:,3), 'g', 'linewidth', linewidth)
ylabel('pressure [bar]')
xlabel('time [ms]')
title('pbar2445')

subplot(339)
plot(pbar2446(:,1), 'r', 'linewidth', linewidth)
hold on
plot(pbar2446(:,2), 'b', 'linewidth', linewidth)
plot(pbar2446(:,3), 'g', 'linewidth', linewidth)
ylabel('pressure [bar]')
xlabel('time [ms]')
title('pbar2446')