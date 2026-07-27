%% SCRIPT 3: GRAFICI MACROSCOPICI (0 - 1800s) PER REPORT (Sostituzione Scope Simulink)
close all; clc;

% Impostazioni grafiche uniformi
set(0, 'DefaultAxesFontSize', 12);
set(0, 'DefaultLineLineWidth', 1.5);

% Assumiamo che il vettore tempo sia identico tra le due run
t = out.att_err.Time; 

%% ================= 1. ATTITUDE ERRORS (Pure Mech vs ESKF) =================
% Estrazione dati Open-Loop (usa out_nofilt)
err_att_nofilt = squeeze(out_nofilt.att_err_nofilt.Data);
if size(err_att_nofilt, 1) == 3, err_att_nofilt = err_att_nofilt'; end
err_att_nofilt = err_att_nofilt * (180/pi); % Converti in GRADI

% Estrazione dati Closed-Loop (usa out)
err_att_filt = squeeze(out.att_err.Data);
if size(err_att_filt, 1) == 3, err_att_filt = err_att_filt'; end
err_att_filt = err_att_filt * (180/pi); % Converti in GRADI

% Figura 5.1: Attitude Error NO FILTER
figure('Name', 'Attitude Error (Pure Mechanization)', 'Position', [100, 100, 800, 500]);
plot(t, err_att_nofilt);
grid on; xlabel('Time [s]'); ylabel('Error [deg]');
title('Attitude Estimation Error (Pure Mechanization)');
legend('Roll', 'Pitch', 'Yaw', 'Location', 'best');

% Figura 5.2: Attitude Error FILT
figure('Name', 'Attitude Error (ESKF)', 'Position', [120, 120, 800, 500]);
plot(t, err_att_filt);
grid on; xlabel('Time [s]'); ylabel('Error [deg]');
title('Attitude Estimation Error (ESKF)');
legend('Roll', 'Pitch', 'Yaw', 'Location', 'best');


%% ================= 2. GYRO BIAS ESTIMATION =================
% Figura 5.3: Gyro Bias Convergence
bg_est = squeeze(out.bg_est.Data);
if size(bg_est, 1) == 3, bg_est = bg_est'; end

figure('Name', 'Gyroscope Bias Estimation', 'Position', [140, 140, 800, 500]);
plot(t, bg_est);
grid on; xlabel('Time [s]'); ylabel('Bias [rad/s]');
title('Gyroscope Bias Estimation (ESKF)');
legend('Bias p', 'Bias q', 'Bias r', 'Location', 'best');


%% ================= 3. VELOCITY ERRORS (Pure Mech vs ESKF) =================
err_vel_nofilt = squeeze(out_nofilt.vel_err_nofilt.Data);
if size(err_vel_nofilt, 1) == 3, err_vel_nofilt = err_vel_nofilt'; end

err_vel_filt = squeeze(out.vel_err.Data);
if size(err_vel_filt, 1) == 3, err_vel_filt = err_vel_filt'; end

% Figura 5.13: Velocity Error NO FILTER
figure('Name', 'Velocity Error (Pure Mechanization)', 'Position', [160, 160, 800, 500]);
plot(t, err_vel_nofilt);
grid on; xlabel('Time [s]'); ylabel('Error [m/s]');
title('Velocity Estimation Error (Pure Mechanization)');
legend('North', 'East', 'Down', 'Location', 'best');

% Figura 5.14: Velocity Error FILT
figure('Name', 'Velocity Error (ESKF)', 'Position', [180, 180, 800, 500]);
plot(t, err_vel_filt);
grid on; xlabel('Time [s]'); ylabel('Error [m/s]');
title('Velocity Estimation Error (ESKF)');
legend('North', 'East', 'Down', 'Location', 'best');


%% ================= 4. POSITION ERRORS (Pure Mech vs ESKF) =================
err_pos_nofilt = squeeze(out_nofilt.pos_err_nofilt.Data);
if size(err_pos_nofilt, 1) == 3, err_pos_nofilt = err_pos_nofilt'; end

err_pos_filt = squeeze(out.pos_err.Data);
if size(err_pos_filt, 1) == 3, err_pos_filt = err_pos_filt'; end

% Figura 5.10: Position Error NO FILTER (Tutte e 3 insieme, senza conversioni)
figure('Name', 'Position Error (Pure Mechanization)', 'Position', [200, 200, 800, 500]);
plot(t, err_pos_nofilt);
grid on; xlabel('Time [s]'); ylabel('Error');
title('Position Estimation Error (Pure Mechanization)');
legend('Latitude [rad]', 'Longitude [rad]', 'Altitude [m]', 'Location', 'best');

% Figura 5.11: Position Error FILT (Solo Latitudine e Longitudine in rad)
figure('Name', 'Lat/Lon Error (ESKF)', 'Position', [220, 220, 800, 500]);
plot(t, err_pos_filt(:, 1:2)); % Plot solo prime due colonne
grid on; xlabel('Time [s]'); ylabel('Error [rad]');
title('Latitude/Longitude Estimation Error (ESKF)');
legend('Latitude', 'Longitude', 'Location', 'best');

% Figura 5.12: Position Error FILT (Solo Altitudine in metri)
figure('Name', 'Altitude Error (ESKF)', 'Position', [240, 240, 800, 500]);
plot(t, err_pos_filt(:, 3), 'Color', [0.8500 0.3250 0.0980]); % Colore per distinguerla
grid on; xlabel('Time [s]'); ylabel('Error [m]');
title('Altitude Estimation Error (ESKF)');
legend('Altitude', 'Location', 'best');