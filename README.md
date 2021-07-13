# Automated waveguide to coax adapter design &amp; optimization

## Description
This script automates the waveguide to coax adapter design.  
If you choose high resolution for optimization, it might take some tome.  
Usually 100 combinations is enough to get good results, more than that might take a long time to finish.  
  
All calculations are derived from:  
'Pozar, D. M. (2011). Microwave engineering. John Wiley & Sons.'  
'Wade, P. (2006). Rectangular Waveguide to Coax Transition Design. W1GHZ.'  
  
## Inputs
* Number of feed length - feed offset combinations
  Usually around 50-100.

* Feedwidth - diameter of a pinfeed monopole antenna conductor
  Whatever your diameter is, usually in a milimeter range.

* Central frequency - selfexplainable, a frequency for which the adapter will be designed and optimized


## Outputs

### Textual output of optimized parameters and resulting performance  
![Output](https://raw.githubusercontent.com/dnemec/waveguide_to_coax/main/Images/Output.PNG?raw=true)
  
### Phase analysis, a visualisation of TExx propagation modes
![Phase](https://raw.githubusercontent.com/dnemec/waveguide_to_coax/main/Images/Phase.png?raw=true)
  
### Attenuation analysis
![Attenuation](https://raw.githubusercontent.com/dnemec/waveguide_to_coax/main/Images/Attenuation.png?raw=true)
  
### VSWR
![VSWR](https://raw.githubusercontent.com/dnemec/waveguide_to_coax/main/Images/VSWR.png?raw=true)
  
### Return loss
![RL](https://raw.githubusercontent.com/dnemec/waveguide_to_coax/main/Images/Returnloss.png?raw=true)
  
### Waveguide visualization
![WG](https://raw.githubusercontent.com/dnemec/waveguide_to_coax/main/Images/Waveguide.png?raw=true)
