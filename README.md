Smart Power Grid Frequency Control Using PID Controller

1. Problem Statement - Design a controller to regulate power grid frequency under sudden load changes.

2. Objective - The aim of this project is to stabilize frequency deviation in a power grid system using a PID controller.

3. Technologies Used
   > MATLAB
   > Control System Toolbox
   
4.System Model The power system is represented by: G(s) = 1 / (4s + 1)
Where:
Input = Control Signal
Output = Frequency Deviation

5. Features
  > PID-based frequency stabilization
  > Stable closed-loop response
  > Reduced oscillations
  > Performance evaluation using:
    a) Step Response
    b) Root Locus
    c) Bode Plot
    d) Nyquist Plot

6. Controller Parameters
Parameter	Value
Kp	2
Ki	1
Kd	0.5

7. How It Works
  > The system experiences frequency deviation due to sudden load changes.
  > The PID controller continuously monitors the error.
  > Control action is applied to restore frequency stability.
  > Stability and response are analyzed using MATLAB.

8. Results
 > Faster settling time
 > Minimal oscillations
 > Stable response
 > Zero steady-state error

9.Files Included
 > MATLAB Source Code
 > Screenshots
 > README Documentation

10. Future Improvements
 > Battery Energy Storage Integration
 > IoT Monitoring
 > Automatic Load Shedding
 > AI-based Adaptive Controllers

11. Team Details
    1. Maitri K - 1BG24EE021
    2. Tejaswini Bevoor - 1BG24EE047
