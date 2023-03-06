close all

% input
fs = 20e6
T = 10e-3
duty = 0.1
f1 = 2e6
f2 = 4e6

Nsamps = fs*T;
t = [(0:Nsamps-1)/fs]';

% pulse signal
c0 = zeros(Nsamps,1);
c0(1:duty*Nsamps,1) = 1;

if 0
    fnum = 8230
    figure(fnum)
    plot(t, c0, 'Linewidth', 5, 'Displayname', 'c0'), hold on
    title('time domain'), xlabel('time'), legend
    
    PLOT_FFT_dB_g(c0, fs, Nsamps, 'c0', 'df', 'full', 'pwr', fnum+1, [], []);
    title('freq domain')
end

flag_mixer_mode = 'nco'
switch flag_mixer_mode
    case 'nco'
        c1 = c0.*exp(1i*2*pi*f1*t);
        c2 = c0.*exp(1i*2*pi*f2*t);
        
        % signal combine
        c3 = 1/sqrt(2)*(c1+c2);
        
        figure(fnum)
        plot(t, real(c3), 'Linewidth', 1, 'Displayname', 'real c3'), hold on
        title('time domain'), xlabel('time'), legend
        
        PLOT_FFT_dB_g(c1, fs, Nsamps, 'c1', 'df', 'full', 'pwr', fnum+1, [], []);
        PLOT_FFT_dB_g(c2, fs, Nsamps, 'c2', 'df', 'full', 'pwr', fnum+1, [], []);
        PLOT_FFT_dB_g(c3, fs, Nsamps, 'c3', 'df', 'full', 'pwr', fnum+1, [], []);
        title('freq domain')
        ylim([-150, 0])
        
    case 'lo'
        c1_2 = c0.*sin(2*pi*f1*t);   
        c2_2 = c0.*sin(2*pi*f2*t);
        c3_2 = 1/sqrt(2)*(c1_2+c2_2);
        
        figure(fnum)
        plot(t, c3_2, 'Linewidth', 1, 'Displayname', 'c3-2', 'Linestyle', '-'), hold on
        title('time domain'), xlabel('time'), legend
        
        PLOT_FFT_dB_g(c1_2, fs, Nsamps, 'c1-2', 'df', 'full', 'pwr', fnum+1, [], []);
        PLOT_FFT_dB_g(c2_2, fs, Nsamps, 'c2-2', 'df', 'full', 'pwr', fnum+1, [], []);
        PLOT_FFT_dB_g(c3_2, fs, Nsamps, 'c3-2', 'df', 'full', 'pwr', fnum+1, ':', []);
        title('freq domain')
        ylim([-150, 0])
end

if 1
    fnum = 8230
    figure(fnum)
    plot(t, c0, 'Linewidth', 2, 'Displayname', 'c0'), hold on
    title('time domain'), xlabel('time'), legend
    
    PLOT_FFT_dB_g(c0, fs, Nsamps, 'c0', 'df', 'full', 'pwr', fnum+1, [], []);
    title('freq domain')
end
