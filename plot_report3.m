%% SCRIPT 2: GRAFICI ERRORE MISURA VS ERRORE STIMA (Zoom e Gradi)
close all; clc;

% Impostazioni grafiche per renderli "da pubblicazione"
set(0, 'DefaultAxesFontSize', 12);
set(0, 'DefaultLineLineWidth', 1.5);
color_meas = [0.9 0.6 0.3];   % Arancione per l'ERRORE DI MISURA (Rumore)
color_est  = [0 0.447 0.741]; % Blu per l'ERRORE DI STIMA (Filtro)

% --- ZOOM ESTREMO (10 secondi come per le traiettorie) ---
t_zoom_start = 930;
t_zoom_end   = 940;

%% ================= 1. ERRORI ATTITUDE (Gradi) =================
t_est  = out.att_err.Time;
t_meas = out.ahrs_noise.Time;

err_att_est  = squeeze(out.att_err.Data);
if size(err_att_est, 1) == 3, err_att_est = err_att_est'; end
err_att_est = err_att_est * (180/pi); % Converti in GRADI

err_att_meas = squeeze(out.ahrs_noise.Data);
if size(err_att_meas, 1) == 3, err_att_meas = err_att_meas'; end
err_att_meas = err_att_meas * (180/pi); % Converti in GRADI

titles_att = {'Roll Error', 'Pitch Error', 'Yaw Error'};
for i = 1:3
    figure('Name', titles_att{i}, 'Position', [100+(i*20), 100+(i*20), 800, 400]);
    plot(t_meas, err_att_meas(:, i), 'Color', color_meas); hold on;
    plot(t_est, err_att_est(:, i), 'Color', color_est, 'LineWidth', 2);
    grid on;
    xlim([t_zoom_start, t_zoom_end]);
    xlabel('Time [s]');
    ylabel([titles_att{i} ' [deg]']);
    title(sprintf('%s (Zoom %ds - %ds)', titles_att{i}, t_zoom_start, t_zoom_end));
    legend('Measurement Error (AHRS)', 'Estimation Error (ESKF)', 'Location', 'best');
end

%% ================= 2. ERRORI VELOCITY (m/s) =================
t_vel_est  = out.vel_err.Time;
t_vel_meas = out.gps_vel_noise.Time;

err_vel_est  = squeeze(out.vel_err.Data);
if size(err_vel_est, 1) == 3, err_vel_est = err_vel_est'; end

err_vel_meas = squeeze(out.gps_vel_noise.Data);
if size(err_vel_meas, 1) == 3, err_vel_meas = err_vel_meas'; end

titles_vel = {'North Velocity Error', 'East Velocity Error', 'Down Velocity Error'};
for i = 1:3
    figure('Name', titles_vel{i}, 'Position', [150+(i*20), 150+(i*20), 800, 400]);
    plot(t_vel_meas, err_vel_meas(:, i), 'Color', color_meas); hold on;
    plot(t_vel_est, err_vel_est(:, i), 'Color', color_est, 'LineWidth', 2);
    grid on;
    xlim([t_zoom_start, t_zoom_end]);
    xlabel('Time [s]');
    ylabel([titles_vel{i} ' [m/s]']);
    title(sprintf('%s (Zoom %ds - %ds)', titles_vel{i}, t_zoom_start, t_zoom_end));
    legend('Measurement Error (GNSS)', 'Estimation Error (ESKF)', 'Location', 'best');
end

%% ================= 3. ERRORI POSITION (Lat/Lon in Gradi, Alt in Metri) =================
t_pos_est  = out.pos_err.Time;
t_pos_meas = out.gps_pos_noise.Time;

err_pos_est = squeeze(out.pos_err.Data);
if size(err_pos_est, 1) == 3, err_pos_est = err_pos_est'; end

err_pos_meas = squeeze(out.gps_pos_noise.Data);
if size(err_pos_meas, 1) == 3, err_pos_meas = err_pos_meas'; end

titles_pos = {'Latitude Error', 'Longitude Error', 'Altitude Error'};
units_pos  = {'[deg]', '[deg]', '[m]'};

for i = 1:3
    figure('Name', titles_pos{i}, 'Position', [200+(i*20), 200+(i*20), 800, 400]);
    
    if i < 3 % Lat e Lon in GRADI
        plot(t_pos_meas, err_pos_meas(:, i)*(180/pi), 'Color', color_meas); hold on;
        plot(t_pos_est, err_pos_est(:, i)*(180/pi), 'Color', color_est, 'LineWidth', 2);
    else % Altitudine in METRI
        plot(t_pos_meas, err_pos_meas(:, i), 'Color', color_meas); hold on;
        plot(t_pos_est, err_pos_est(:, i), 'Color', color_est, 'LineWidth', 2);
    end
    
    grid on;
    xlim([t_zoom_start, t_zoom_end]);
    xlabel('Time [s]');
    ylabel(sprintf('%s %s', titles_pos{i}, units_pos{i}));
    title(sprintf('%s (Zoom %ds - %ds)', titles_pos{i}, t_zoom_start, t_zoom_end));
    legend('Measurement Error (GNSS)', 'Estimation Error (ESKF)', 'Location', 'best');
end