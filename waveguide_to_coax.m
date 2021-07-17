%DESIGN AND OPTIMIZATION OF A RECTANGULAR WAVEGUIDE
%DEFAULT MODE OF PROPAGATION IS BY DESIGN TE10

clear all
close all
clc

format shortEng
format compact

%INPUTS

%NUMBER OF OFFSET-LENGTH COMBINATIONS (FOR OPTIMIZATION)
number_of_combinations = input('Enter the number of offset - feed length combinations for optimization.\n');
clc

%PINFEED MONOPOLE CONDUCTOR DIAMETER
feedwidth = input('Enter the pinfeed monopole conductor diameter in milimeters.\n');
feedwidth = feedwidth * 1e-3;
clc

%CENTRAL FREQUENCY IN HERTZ (e.g. 1GHz = 1e9)
fc = input('Enter the central frequency in Hz.\n');
clc

%MEDIUM PARAMETERS
%AIR
c0 = 299792458;
e0 = 8.854187817e-12;
u0 = 1.256637061e-6;

e_r = 1.00058986;
u_r = 1.00000037;

e = e0 * e_r;
u = u0 * u_r;

%CENTRAL FREQUENCY
omega = 2 * pi * fc;
lambda_fc = c0 / fc;
lambda4_fc = lambda_fc / 4;

fprintf('Frequency = %d Hz', fc);
fprintf('\nWavelength = %d m', lambda_fc);
fprintf('\nQuarterwave length = %d m', lambda4_fc);
fprintf('\n');

%WAVEGUIDE SIZE CALCULATION
a = 3 / (4 * fc * sqrt(u * e));
b = (a / 2) - 0.6e-3;

lambda_g = (2 * pi) / (sqrt( (omega * sqrt(u * e))^2 - (pi / a)^2));
length = lambda_g / 2;

fprintf('\n');
fprintf('Waveguide dimensions');
fprintf('\na = %d m', a);
fprintf('\nb = %d m', b);
fprintf('\nlength = %d m', length);
fprintf('\n');
fprintf('\n');

%TRANSMISSION MODES
fcmn(2) = zeros();
for m = 1:3
    for n = 1:3
        
        fcmn(m, n) = (1 / (2 * pi * sqrt(u * e))) * sqrt( (((m-1) * pi) / a)^2 + (((n-1) * pi) / b)^2);
        
    end
end

for m = 1:3
    for n = 1:3
        fcmnn = fcmn(m,n);
        fprintf('Cutoff frequency of TE%d%d mode is %d Hz\n',m-1,n-1,fcmnn)
    end
end

%PHASE ANALYSIS
omega_beta_analysis_10 = linspace( ((2 * pi * fcmn(2,1))), ((2 * pi * fcmn(3,1)) * 1.2), 100);
k10 = (omega_beta_analysis_10 .* sqrt(u * e));
beta10 = sqrt(k10.^2 - ((pi / a)^2));

omega_beta_analysis_20 = linspace( ((2 * pi * fcmn(3,1))), ((2 * pi * fcmn(3,1)) * 1.2), 100);
k20 = (omega_beta_analysis_20 .* sqrt(u * e));
beta20 = sqrt(k20.^2 - (((2 * pi) / a)^2));

omega_beta_analysis = linspace( ((2 * pi * fcmn(2,1)) * 0.8), ((2 * pi * fcmn(3,1)) * 1.2), 100);

figure('DefaultLegendFontSize',16,'DefaultLegendFontSizeMode','manual');
plot(((omega_beta_analysis_10)./(2 * pi)), beta10,'DisplayName','TE10','LineWidth',1.5);
hold on
plot(((omega_beta_analysis_20)./(2 * pi)), beta20,'DisplayName','TE20','LineWidth',1.5);
title('\bf Phase','FontSize',16)
xlabel('\bf Frequency [Hz]','FontSize',16) 
ylabel('\bf \beta [rad/m]','FontSize',16) 
legend();
grid on
pause(5);

%ATTENUATION ANALYSIS
sigma = linspace(1e7, 7e7, 1000); %Conductivity range of common metals

k = omega * sqrt(u * e);
beta = sqrt(k^2 - ((pi / a)^2));

Rs = sqrt( (omega * u0) ./ (2 .* sigma));

alpha_c = (Rs ./ (a^3 * b * beta * k * n)) * ((2 * b * pi^2) + (a^3 * k^2)) ./ 8.685889638;

figure('DefaultLegendFontSize',16,'DefaultLegendFontSizeMode','manual');
plot(sigma, alpha_c,'LineWidth',1.5);
title('Attenuation','FontSize',16)
xlabel('\bf Conductivity, \sigma [S/m]','FontSize',16) 
ylabel('\bf \alpha [dB/m]','FontSize',16)
grid on
pause(5);

%PINFEED OPTIMIZATION PARAMETERS
height = b;
width = a;
feedheight = lambda4_fc;
length = lambda_g / 2;

optimization_points = round(sqrt(number_of_combinations));

%PARAMETER TUNING
%DEFAULT - +- 20% OF FEED LENGTH
%+-50% OF lambdag/4 FEED OFFSET

feedheightrange = linspace((feedheight * 0.8), (feedheight * 1.2), optimization_points);
feedoffsetrange = linspace(0.5, 1.5, optimization_points);

absolute_min = 0;
optimal_height = 0;
optimal_distance = 0;

%OPTIMIZATION ALGORHYTHM

fprintf('\n');
fprintf('Optimization in progress, please wait.');
fprintf('\n');

iter = 0;
for m = 1:optimization_points
    for n = 1:optimization_points
        
        clear wg
        clear rl
        
        feedoffset_position = - (lambda_g / 4) + ((lambda_g / 4) * feedoffsetrange(n)); %CENTERS THE OFFSET TO CLOSED END POSITION
        feedoffset = [feedoffset_position 0];
        
        wg = waveguide('FeedHeight', feedheightrange(m), 'Length', length, 'Width', width, 'Height', height, 'FeedOffset', feedoffset, 'FeedWidth', feedwidth);
        rl = returnLoss(wg, fc, 50);
        
            if rl > absolute_min
                absolute_min = rl;
                optimal_height = feedheightrange(m);
                optimal_distance = feedoffset(1); 
           
            end
         
    end
end
fprintf('Optimization done.');
fprintf('\n');
fprintf('\n');

%SIMULATION AND DISPLAY OF OPTIMIZED WAVEGUIDE TO COAX ADAPTER
freqspan = linspace((fc * 0.8), (fc * 1.2), 250);

wg = waveguide('FeedHeight', optimal_height, 'Length', length, 'Width', width, 'Height', height, 'FeedOffset', [optimal_distance 0], 'FeedWidth', feedwidth);
show(wg)

figure;
vswr(wg, freqspan, 50);
yline(1.5, 'r', '1.5', 'LineWidth', 1.5);

figure;
returnLoss(wg, freqspan, 50);
yline(10, 'r', '10dB', 'LineWidth', 1.5);

rlpeaks = returnLoss(wg, freqspan, 50);
[peakrl, peakf] = findpeaks(rlpeaks);

optimal_distance;
optimal_distance = (lambda_g / 4) - feedoffset(1);

fprintf('Return loss at central frequency: %.4f\n', absolute_min)
fprintf('Peak return loss: %.4f at %.4f Hz\n', peakrl, freqspan(peakf))
fprintf('Optimal height: %.4f m\n', optimal_height)
fprintf('Optimal height: %.4f lambda0\n', (optimal_height/lambda_fc))
fprintf('Optimal height: %.4f lambda0/4\n', (optimal_height/lambda4_fc))
fprintf('Optimal distance: %.4f m\n', optimal_distance)
fprintf('Optimal distance: %.4f lambda_g\n', (optimal_distance/lambda_g))
fprintf('Optimal distance: %.4f lambda_g/4\n', (optimal_distance/(lambda_g/4)))


