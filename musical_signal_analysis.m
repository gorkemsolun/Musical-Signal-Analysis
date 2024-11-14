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

function fourierAnalysis(signal, fs, titleText)
    % Perform Fourier analysis on the signal
    N = length(signal);
    N_2 = floor(N / 2);
    f = fs * (0:N_2) / N;
    Y = fft(signal);
    P2 = abs(Y / N);
    P1 = P2(1:N_2 + 1);
    P1(2:end - 1) = 2 * P1(2:end - 1);

    figure;
    plot(f, P1);
    title(titleText);
    xlabel('Frequency (Hz)');
    ylabel('Amplitude (X(f))');
    xlim([0, fs / 2]);
    grid on;
    pause(1);
end

%
% Part 2 Signal Generation
%

default_fs = 8000;
t = 0:1 / default_fs:1;
E_flat_frequency = 311; % 311.13 Hz
F_sharp_frequency = 367; % 369.99 Hz
B_flat_frequency = 466; % 466.16 Hz

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
plotSignal(E_flat_signal, t, 'E flat signal A=1 phase=0');
plotSignal(F_sharp_signal, t, 'F sharp signal A=1 phase=0');
plotSignal(B_flat_signal, t, 'B flat signal A=1 phase=0');
plotSignal(chord, t, 'D♯m Chord signal A=1 phase=0');

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
plotSignal(E_flat_signal, t, 'E flat signal A=2 phase=32°');
plotSignal(F_sharp_signal, t, 'F sharp signal A=1 phase=321°');
plotSignal(B_flat_signal, t, 'B flat signal A=4 phase=214°');
plotSignal(chord, t, 'D♯m Chord signal A=2,1,4 phase=32°,321°,214°');

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
    E_flat_harmonics = E_flat_harmonics + E_flat_amplitude * amplitude_modifiers(i) * cos(2 * pi * i * E_flat_frequency * t + E_flat_phase);
    F_sharp_harmonics = F_sharp_harmonics + F_sharp_amplitude * amplitude_modifiers(i) * cos(2 * pi * i * F_sharp_frequency * t + F_sharp_phase);
    B_flat_harmonics = B_flat_harmonics + B_flat_amplitude * amplitude_modifiers(i) * cos(2 * pi * i * B_flat_frequency * t + B_flat_phase);
end

chord_harmonics = E_flat_harmonics + F_sharp_harmonics + B_flat_harmonics;

% Sound the signals
disp('Playing the signals with harmonics');
soundSignals(E_flat_harmonics, F_sharp_harmonics, B_flat_harmonics, default_fs);
disp('Playing the chord with harmonics');
sound(chord_harmonics, default_fs);
pause(1);

% Plot the signals
plotSignal(E_flat_harmonics, t, 'E flat signal with harmonics');
plotSignal(F_sharp_harmonics, t, 'F sharp signal with harmonics');
plotSignal(B_flat_harmonics, t, 'B flat signal with harmonics');
plotSignal(chord_harmonics, t, 'D♯m Chord signal with harmonics');

%
% Part 4 Fourier Analysis
%
% Perform Fourier analysis on the signals with harmonics
disp('Performing Fourier analysis on the signals with harmonics');
fourierAnalysis(E_flat_harmonics, default_fs, 'Fourier Analysis of E flat signal with harmonics');
fourierAnalysis(F_sharp_harmonics, default_fs, 'Fourier Analysis of F sharp signal with harmonics');
fourierAnalysis(B_flat_harmonics, default_fs, 'Fourier Analysis of B flat signal with harmonics');
fourierAnalysis(chord_harmonics, default_fs, 'Fourier Analysis of D♯m Chord signal with harmonics');

%
% Part 5 Aliasing and reconstruction
%
% Intentionally undersample the signals below the Nyquist frequency
% for the highest note in the chord (B flat) and try to reconstruct
% original chord and the second, third and fourth harmonics
aliased_fs = (B_flat_frequency * 3) / 2;
aliased_t = 0:1 / aliased_fs:1;

% Generate the aliased original chord
aliased_chord = interp1(t, chord, aliased_t, 'linear');
aliased_chord_resampled = interp1(aliased_t, aliased_chord, t, 'linear');

% Generate the aliased harmonics
aliased_harmonic_fs = (B_flat_frequency * 4 * 3) / 2;
aliased_harmonic_t = 0:1 / aliased_harmonic_fs:1;

aliased_chord_harmonics = interp1(t, chord_harmonics, aliased_harmonic_t, 'linear');
aliased_chord_harmonics_resampled = interp1(aliased_harmonic_t, aliased_chord_harmonics, t, 'linear');

disp('Play the original chord');
sound(chord, default_fs);
pause(1);
disp('Playing the aliased original chord');
sound(aliased_chord_resampled, default_fs);
pause(1);

disp('Playing the chord with harmonics');
sound(chord_harmonics, default_fs);
pause(1);
disp('Playing the aliased chord with harmonics');
sound(aliased_chord_harmonics_resampled, default_fs);
pause(1);

% Plot the signals
disp('Plotting the signals');
plotSignal(chord, t, 'D♯m Chord signal');
plotSignal(aliased_chord_resampled, t, 'Aliased D♯m Chord signal');
plotSignal(chord_harmonics, t, 'D♯m Chord signal with harmonics');
plotSignal(aliased_chord_harmonics_resampled, t, 'Aliased D♯m Chord signal with harmonics');

% Perform Fourier analysis on the aliased signals
disp('Performing Fourier analysis on the aliased signals');
fourierAnalysis(chord, default_fs, 'Fourier Analysis of D♯m Chord signal');
fourierAnalysis(aliased_chord_resampled, default_fs, 'Fourier Analysis of Aliased D♯m Chord signal');
fourierAnalysis(chord_harmonics, default_fs, 'Fourier Analysis of D♯m Chord signal with harmonics');
fourierAnalysis(aliased_chord_harmonics_resampled, default_fs, 'Fourier Analysis of Aliased D♯m Chord signal with harmonics');
