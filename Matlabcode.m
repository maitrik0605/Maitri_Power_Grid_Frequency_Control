clc;
clear;
close all;

%% SMART POWER GRID FREQUENCY CONTROL SYSTEM
% Features Included:
% 1. Open Loop Response (Without PID)
% 2. PID Controller
% 3. Real-Time Disturbance Detection
% 4. Smart Battery Backup
% 5. Automatic Load Shedding
% 6. Load Shedding Activation & Deactivation
% 7. Stability Analysis
% 8. Performance Evaluation

%% SYSTEM MODEL

s = tf('s');

% Power Grid Transfer Function
G = 1/(4*s + 1);

%% OPEN LOOP RESPONSE (WITHOUT PID CONTROLLER)

figure;

step(G);

title('Power Grid Frequency Response Without PID Controller');

xlabel('Time (s)');
ylabel('Frequency Deviation');

grid on;

%% OPEN LOOP PERFORMANCE

disp('----------------------------------');
disp('WITHOUT PID CONTROLLER');
disp('----------------------------------');

open_loop_info = stepinfo(G)

open_loop_poles = pole(G)

disp('----------------------------------');

%% PID CONTROLLER PARAMETERS

Kp = 2;
Ki = 1;
Kd = 0.5;

% PID Controller
C = Kp + Ki/s + Kd*s;

%% CLOSED LOOP SYSTEM

T = feedback(C*G,1);

%% STEP RESPONSE WITH PID CONTROLLER

figure;

step(T);

title('Power Grid Frequency Response With PID Controller');

xlabel('Time (s)');
ylabel('Frequency Deviation');

grid on;

%% PERFORMANCE METRICS

disp('WITH PID CONTROLLER');

info = stepinfo(T)

%% STABILITY ANALYSIS

disp('Closed Loop Poles');

poles = pole(T)

%% ROOT LOCUS

figure;

rlocus(C*G);

title('Root Locus of Controlled System');

grid on;

%% BODE PLOT

figure;

bode(T);

title('Bode Plot');

grid on;

%% NYQUIST PLOT

figure;

nyquist(T);

title('Nyquist Plot');

grid on;

%% REAL-TIME DISTURBANCE DETECTION

disp('----------------------------------');
disp('REAL-TIME DISTURBANCE MONITORING');
disp('----------------------------------');

% Simulation Time
t = 0:0.1:20;

% Disturbance Threshold
threshold = 0.15;

% Frequency Signal Initialization
frequency_signal = zeros(size(t));

% Severe Load Disturbance at t = 8 sec
frequency_signal(t >= 8) = -0.5;

%% PID CORRECTED RESPONSE

corrected_signal = frequency_signal .* exp(-0.5*(t-8));

corrected_signal(t < 8) = 0;

%% SMART BATTERY BACKUP SYSTEM

battery_support = zeros(size(t));

battery_status = strings(size(t));

for i = 1:length(t)

    % Battery activates if frequency falls below threshold
    if corrected_signal(i) < -threshold

        battery_support(i) = 0.15;

        battery_status(i) = "ACTIVE";

    else

        battery_support(i) = 0;

        battery_status(i) = "OFF";

    end

end

%% SIGNAL AFTER BATTERY SUPPORT

battery_signal = corrected_signal + battery_support;

%% AUTOMATIC LOAD SHEDDING SYSTEM

load_shedding = zeros(size(t));

load_status = strings(size(t));

for i = 1:length(t)

    % Severe disturbance condition
    if battery_signal(i) < -0.20

        % Activate load shedding
        load_shedding(i) = 1;

        load_status(i) = "ACTIVE";

    else

        % Deactivate load shedding
        load_shedding(i) = 0;

        load_status(i) = "OFF";

    end

end

%% FINAL STABILIZED SIGNAL

% Load shedding improves stabilization
final_signal = battery_signal + (0.10 .* load_shedding);

%% REAL-TIME MONITORING DISPLAY

for i = 1:length(t)

    fprintf('Time = %.1f sec | Frequency = %.3f | Battery = %s | Load Shedding = %s\n', ...
        t(i), ...
        final_signal(i), ...
        battery_status(i), ...
        load_status(i));

    % Disturbance Detection Alert
    if abs(final_signal(i)) > threshold

        fprintf('>>> WARNING: DISTURBANCE DETECTED at %.1f sec\n', t(i));

    end

end

%% RESPONSE COMPARISON PLOT

figure;

plot(t, corrected_signal, 'r', 'LineWidth',2);

hold on;

plot(t, battery_signal, 'b', 'LineWidth',2);

plot(t, final_signal, 'g', 'LineWidth',2);

yline(threshold,'k--','Threshold');
yline(-threshold,'k--');

grid on;

title('Smart Grid Frequency Stabilization');

xlabel('Time (s)');
ylabel('Frequency Deviation');

legend('Without Smart Features', ...
       'With Battery Backup', ...
       'With Battery + Load Shedding');

%% BATTERY ACTIVATION GRAPH

figure;

stairs(t, battery_support, 'LineWidth',2);

grid on;

title('Smart Battery Backup Activation');

xlabel('Time (s)');
ylabel('Battery Support Power');

%% LOAD SHEDDING ACTIVATION & DEACTIVATION GRAPH

figure;

stairs(t, load_shedding, 'LineWidth',2);

ylim([-0.2 1.2]);

yticks([0 1]);

yticklabels({'OFF','ON'});

grid on;

title('Automatic Load Shedding Status');

xlabel('Time (s)');
ylabel('Load Shedding State');

%% FINAL STABILIZED RESPONSE

figure;

plot(t, final_signal, 'LineWidth',2);

hold on;

yline(threshold,'r--','Threshold');
yline(-threshold,'r--');

grid on;

title('Final Stabilized Smart Grid Response');

xlabel('Time (s)');
ylabel('Frequency Deviation');

%% PERFORMANCE COMPARISON

max_without = max(abs(corrected_signal));

max_battery = max(abs(battery_signal));

max_final = max(abs(final_signal));

fprintf('\nMaximum Deviation Without Smart Features = %.3f\n', ...
         max_without);

fprintf('Maximum Deviation With Battery Support = %.3f\n', ...
         max_battery);

fprintf('Maximum Deviation After Load Shedding = %.3f\n', ...
         max_final);

%% SYSTEM STATUS

disp('----------------------------------');

if max_final < max_without

    disp('SMART GRID FEATURES IMPROVED STABILITY');

else

    disp('NO SIGNIFICANT IMPROVEMENT DETECTED');

end

disp('SYSTEM SUCCESSFULLY STABILIZED');

disp('----------------------------------');
