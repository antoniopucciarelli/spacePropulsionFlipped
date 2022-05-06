# spacePropulsionFlipped

This collection of **Matlab** scripts for the **space propulsion** course's flipped class. 

## Flipped class assignment

From a set of experimental data:

* compute the **Vielle**'s law paramenters of the propellant, _a_ and _n_. 
* compute the mean **burning time** of a **BARIA** motor given its grain dimensions.
* run a **Monte Carlo** simulation of the _behaviour_ of the **burning time**.

### Initial data

**27 pressure traces** are measured from a **static firing test** of a motor. These 27 tests are made using the propellant from **9 different propellant batches**. Each batch generates 3 propellant grains; each of these 3 grains has been tested using **3 different nozzles** in order to burn the grain with **3 different combustion chamber pressure**. 

### Vielle's law computation

From the pressure traces, the **Bayern** combustion model has been used for the computation of the _effective pressure_ and the _effective burning rate_ (computed by ```reactionRate.m```). After computed these 2 parameters for each of the firing tests, the ```Uncertainty.m``` computes the **Vielle**'s law main parameter, _a_ and _n_, with their respective **absolute uncertainties**.

### Burning time

From the above results, a **BARIA** motor simulation is computed for each of the **3 nozzles configurations** (using ```baria.m```).

### Monte Carlo simulation

At the end, a **Monte Carlo** simulation is made for the computation of the **burning time properties** using a **gaussian distribution** of the aleatory on _a_ and _n_. The **gaussian distribution** is computed using the **absolute uncertainties** and the **mean values** of _a_ and _n_ assuming a **confidence level** of 90% on the population. 

The mean burning time and the standard deviation of the burning time are computed from the **Monte Carlo** simulation. From these values, the absolute uncertainty is computed for the burning time using a confidence level of 90%. 

At the end the **relative unceretainties** are computed for _a_, _n_ and the burning time.
