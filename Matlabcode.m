clc;
clear;
close all;

%% POWER GRID FREQUENCY CONTROL USING PID

% Transfer Function
s = tf('s');
G = 1/(4*s + 1);

%% PID Controller Parameters
Kp = 2;
Ki = 1;
Kd = 0.5;

% PID Controller
C = Kp + Ki/s + Kd*s;

%% Closed Loop System
T = feedback(C*G,1);

%% Step Response
figure;
step(T);
title('Power Grid Frequency Response with PID Controller');
xlabel('Time (s)');
ylabel('Frequency Deviation');
grid on;

%% Performance Metrics
info = stepinfo(T);

disp('Performance Metrics');
disp(info);

%% Stability Check
poles = pole(T);

disp('Closed Loop Poles');
disp(poles);

%% Root Locus
figure;
rlocus(C*G);
title('Root Locus of Controlled System');
grid on;

%% Bode Plot
figure;
bode(T);
title('Bode Plot');
grid on;

%% Nyquist Plot
figure;
nyquist(T);
title('Nyquist Plot');
grid on;

disp('Program Executed Successfully');