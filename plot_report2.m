%% SCRIPT 1: GRAFICI DELLE TRAIETTORIE (ZOOM ESTREMO E GRADI DOVE SERVE)
close all; clc;

% Impostazioni grafiche per renderli "da pubblicazione"
set(0, 'DefaultAxesFontSize', 12);
set(0, 'DefaultLineLineWidth', 1.5);
color_meas = [0.9 0.6 0.3];   % Arancione chiaro per la MISURA (sfondo)
color_est  = [0 0.447 0.741]; % Blu per la STIMA (mezzo)
color_true = 'k--';           % Nero tratteggiato per il VERO (primo piano)

% --- ZOOM ESTREMO (10 secondi) ---
t_zoom_start = 930;
t_zoom_end   = 940;

% --- VETTORE TEMPO DEL GROUND TRUTH ---
t_true = linspace(0, 1800, size(rpy, 1))'; 

%% ================= 1. ATTITUDE (Gradi) =================
t_est  = out.att_ext.Time;
t_meas = out.att_meas.Time;

rpy_est  = squeeze(out.att_ext.Data);
if size(rpy_est, 1) == 3, rpy_est = rpy_est'; end
rpy_est = rpy_est * (180/pi); % Converti in GRADI

rpy_meas = squeeze(out.att_meas.Data);
if size(rpy_meas, 1) == 3, rpy_meas = rpy_meas'; end
rpy_meas = rpy_meas * (180/pi); % Converti in GRADI

rpy_true_deg = rpy * (180/pi); % Converti in GRADI

titles_att = {'Roll', 'Pitch', 'Yaw'};
for i = 1:3
    figure('Name', sprintf('%s Trajectory', titles_att{i}), 'Position', [100+(i*20), 100+(i*20), 800, 400]);
    plot(t_meas, rpy_meas(:, i), 'Color', color_meas); hold on;
    plot(t_est, rpy_est(:, i), 'Color', color_est);
    plot(t_true, rpy_true_deg(:, i), color_true, 'LineWidth', 2.5);
    grid on;
    xlim([t_zoom_start, t_zoom_end]);
    xlabel('Time [s]');
    ylabel([titles_att{i} ' [deg]']);
    title(sprintf('%s Tracking (Zoom %ds - %ds)', titles_att{i}, t_zoom_start, t_zoom_end));
    legend('Measured', 'Estimated', 'True', 'Location', 'best');
end

%% ================= 2. VELOCITY (m/s) =================
t_vel_est  = out.vel_ext.Time;
t_vel_meas = out.vel_meas.Time;

vel_est = squeeze(out.vel_ext.Data);
if size(vel_est, 1) == 3, vel_est = vel_est'; end

vel_meas = squeeze(out.vel_meas.Data);
if size(vel_meas, 1) == 3, vel_meas = vel_meas'; end

vel_true = vel_n;

titles_vel = {'North Velocity', 'East Velocity', 'Down Velocity'};
for i = 1:3
    figure('Name', sprintf('%s Trajectory', titles_vel{i}), 'Position', [150+(i*20), 150+(i*20), 800, 400]);
    plot(t_vel_meas, vel_meas(:, i), 'Color', color_meas); hold on;
    plot(t_vel_est, vel_est(:, i), 'Color', color_est);
    plot(t_true, vel_true(:, i), color_true, 'LineWidth', 2.5);
    grid on;
    xlim([t_zoom_start, t_zoom_end]);
    xlabel('Time [s]');
    ylabel([titles_vel{i} ' [m/s]']);
    title(sprintf('%s Tracking (Zoom %ds - %ds)', titles_vel{i}, t_zoom_start, t_zoom_end));
    legend('Measured', 'Estimated', 'True', 'Location', 'best');
end

%% ================= 3. POSITION (Lat/Lon in Gradi, Alt in Metri) =================
t_pos_est  = out.pos_ext.Time;
t_pos_meas = out.pos_meas.Time;

pos_est = squeeze(out.pos_ext.Data);
if size(pos_est, 1) == 3, pos_est = pos_est'; end

pos_meas = squeeze(out.pos_meas.Data);
if size(pos_meas, 1) == 3, pos_meas = pos_meas'; end

pos_true = pos_ideal_LLH;

titles_pos = {'Latitude', 'Longitude', 'Altitude'};
units_pos  = {'[deg]', '[deg]', '[m]'};

for i = 1:3
    figure('Name', sprintf('%s Trajectory', titles_pos{i}), 'Position', [200+(i*20), 200+(i*20), 800, 400]);
    
    if i < 3 % Lat e Lon in GRADI
        plot(t_pos_meas, pos_meas(:, i)*(180/pi), 'Color', color_meas); hold on;
        plot(t_pos_est, pos_est(:, i)*(180/pi), 'Color', color_est);
        plot(t_true, pos_true(:, i)*(180/pi), color_true, 'LineWidth', 2.5);
    else % Altitudine in METRI
        plot( ...
            t_pos_meas, pos_meas(:, i), 'Color', color_meas); hold on;
        plot(t_pos_est, pos_est(:, i), 'Color', color_est);
        plot(t_true, pos_true(:, i), color_true, 'LineWidth', 2.5);
    end
    
    grid on;
    xlim([t_zoom_start, t_zoom_end]);
    xlabel('Time [s]');
    ylabel(sprintf('%s %s', titles_pos{i}, units_pos{i}));
    title(sprintf('%s Tracking (Zoom %ds - %ds)', titles_pos{i}, t_zoom_start, t_zoom_end));
    legend('Measured', 'Estimated', 'True', 'Location', 'best');
end