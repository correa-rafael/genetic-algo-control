# Genetic Algorithm Control

This repository contains implementations of different control techniques to regulate tunneling current in scanning tunneling microscopy (STM), based on the report **"Performance Comparison of Genetic Algorithm Against Established Control Techniques for Tunneling Current Regulation"**.

## Controllers

- **Pole Placement Controller:** To synthesize a pole placement controller, use the MATLAB script `pole_placement.m` located in the Others directory. This script calls the auxiliary function `bezoutd_AB.m` to perform the pole placement control design.

- **H-Infinity Controller:** For H-Infinity controller synthesis, utilize the MATLAB script `hinf_design.m` located in Others directory. This script is designed to handle H-Infinity control design.

- **Genetic Algorithm Controller:** To synthesize a controller using the Genetic Algorithm, please refer to the `README.md` file inside the GA directory. It contains detailed instructions on how to run the genetic algorithm for controller design.
