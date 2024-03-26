# Genetic Algorithm Controller

This folder contains files intended to synthesize a controller using a genetic algorithm. The main file, `ga_controller.m`, should be executed with the necessary modifications. The file `controller_test.m` contains the cost function for the genetic algorithm, and it should be modified to adjust the cost function's parameters. The .mat files contain the coefficients R and S of different controllers synthesized by the genetic algorithm. You can visualize the cost function parameters of each controller by comparing their names with the names of the `controller_test_???` functions.

## File Descriptions

- **ga_controller.m:** The main file responsible for executing the genetic algorithm for controller synthesis. Make sure to modify it according to your specific requirements.

- **controller_test.m:** Contains the cost function used in the genetic algorithm. Modify this file to adjust the parameters of the cost function as needed.

- **.mat files:** These files store the coefficients R and S of controllers obtained through the genetic algorithm.

- **GA_test.slx:** This simulation file is executed at each iteration of the genetic algorithm.

- **systems_parameters.mat:** Contains the parameters of the system plant.

## Getting Started

To use the genetic algorithm controller synthesis, follow these steps:

1. Open `ga_controller.m` and make any necessary changes.
2. Modify `controller_test.m` to design and implement your specific cost function based on the problem requirements.
3. Run `ga_controller.m` after setting up the necessary configurations.
4. The genetic algorithm will evolve the controllers, and the resulting coefficients R and S must be saved in the corresponding .mat files.
5. Use the obtained controllers for your specific system by loading the appropriate .mat file and applying it to your control loop.
