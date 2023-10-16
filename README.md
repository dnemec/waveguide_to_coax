# Automated waveguide to coax adapter design &amp; optimization

## Description
This script automates the waveguide to coax adapter design.  
It is designed to create and optimize waveguide in a **TE10** propagation mode.  
  
If you choose high resolution for optimization, it might take some time to process.  
Usually 100 combinations is more than enough to achieve good results, more than that might take a long time to finish.  

## Sources
All calculations are derived from:  
**Pozar, D. M. (2011). Microwave engineering. John Wiley & Sons.  
Wade, P. (2006). Rectangular Waveguide to Coax Transition Design. W1GHZ.**  
  
## Inputs
* **Number of combinations** - feed length and feed offset combinations  
*Around 100 is more than enough, approximate it accordingly in regards to the manufacturing precision that you are able to achieve.*  

* **Feedwidth** - diameter of a pinfeed monopole antenna conductor (probe)  
*Usually in a milimeter range.*  
*Larger diameter (thicker probe) usually results in a wider bandwidth.*

* **Central frequency** - Central frequency for which the adapter will be designed and optimized  

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
