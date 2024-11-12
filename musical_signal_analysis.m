% Görkem Kadir Solun - 22003214

function plotSignal(signal, t, titleText)
    % Plot the signal
    figure;
    plot(t, signal);
    title(titleText);
    xlabel('Time (s)');
    ylabel('Amplitude (X(t))');
    xlim([0, 0.05]);
    grid on;
    pause(1);
end

function soundSignals(signal1, signal2, signal3, fs)
    % Play the signals
    sound(signal1, fs);
    pause(1);
    sound(signal2, fs);
    pause(1);
    sound(signal3, fs);
    pause(1);
end

%
% Part 2 Signal Generation
%

default_fs = 8000;
t = 0:1 / default_fs:1;
E_flat_frequency = 311.13;
F_sharp_frequency = 369.99;
B_flat_frequency = 466.16;

% First generate signals with amplitude 1 and phase 0
E_flat_signal = cos(2 * pi * E_flat_frequency * t);
F_sharp_signal = cos(2 * pi * F_sharp_frequency * t);
B_flat_signal = cos(2 * pi * B_flat_frequency * t);

% Sound the signals
disp('Playing the signals with amplitude 1 and phase 0');
soundSignals(E_flat_signal, F_sharp_signal, B_flat_signal, default_fs);

% Create a chord and sound it
disp('Playing the chord with amplitude 1 and phase 0');
chord = E_flat_signal + F_sharp_signal + B_flat_signal;
sound(chord, default_fs);
pause(1);

% Plot the signals
plotSignal(E_flat_signal, t, 'E flat signal');
plotSignal(F_sharp_signal, t, 'F sharp signal');
plotSignal(B_flat_signal, t, 'B flat signal');
plotSignal(chord, t, 'D♯m Chord signal');

% Now amplify the signals according to my ID's last digits 22003214
E_flat_amplitude = 2;
F_sharp_amplitude = 1;
B_flat_amplitude = 4;

% And phasify the signals according to my ID's last digits 22003214
E_flat_phase = deg2rad(032);
F_sharp_phase = deg2rad(321);
B_flat_phase = deg2rad(214);

% New signals
E_flat_signal = E_flat_amplitude * cos(2 * pi * E_flat_frequency * t + E_flat_phase);
F_sharp_signal = F_sharp_amplitude * cos(2 * pi * F_sharp_frequency * t + F_sharp_phase);
B_flat_signal = B_flat_amplitude * cos(2 * pi * B_flat_frequency * t + B_flat_phase);

% Sound the signals
disp('Playing the signals with amplitude and phase modifications');
soundSignals(E_flat_signal, F_sharp_signal, B_flat_signal, default_fs);
disp('Playing the chord with amplitude and phase modifications');
chord = E_flat_signal + F_sharp_signal + B_flat_signal;
sound(chord, default_fs);
pause(1);

% Plot the signals
plotSignal(E_flat_signal, t, 'E flat signal');
plotSignal(F_sharp_signal, t, 'F sharp signal');
plotSignal(B_flat_signal, t, 'B flat signal');
plotSignal(chord, t, 'D♯m Chord signal');

%
% Part 3 Adding Harmonics
%
amplitude_modifiers = [1, 0.8, 0.6, 0.4];
t = 0:1 / default_fs:1;
E_flat_harmonics = zeros(1, length(t));
F_sharp_harmonics = zeros(1, length(t));
B_flat_harmonics = zeros(1, length(t));

% Add harmonics to the signals
for i = 1:length(amplitude_modifiers)
    E_flat_harmonics = E_flat_harmonics + amplitude_modifiers(i) * cos(2 * pi * i * E_flat_frequency * t);
    F_sharp_harmonics = F_sharp_harmonics + amplitude_modifiers(i) * cos(2 * pi * i * F_sharp_frequency * t);
    B_flat_harmonics = B_flat_harmonics + amplitude_modifiers(i) * cos(2 * pi * i * B_flat_frequency * t);
end

chord_harmonics = E_flat_harmonics + F_sharp_harmonics + B_flat_harmonics;

% Sound the signals
disp('Playing the signals with harmonics');
soundSignals(E_flat_harmonics, F_sharp_harmonics, B_flat_harmonics, default_fs);
disp('Playing the chord with harmonics');
sound(chord_harmonics, default_fs);
pause(1);

%
% Part 4 Fourier Analysis
%
% Perform Fourier analysis on the signals with harmonics
