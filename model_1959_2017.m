% Load data and define inital variables
load mauna_loa_co2.txt;
co2 = mauna_loa_co2(:,2)

load temperature_anomaly.txt
temp = temperature_anomaly(:,2)
year = linspace(1959,2017, 2017-1959+1)


% Plot temperature & CO2 over time
figure
yyaxis left
xlabel('Year')
plot(year, co2)
ylabel('CO_2 (ppm)')
hold on 
yyaxis right
plot(year, temp)
ylabel('Temperature (Relative to 1951-80 Average')
title('CO_2 and Temperature Over Time')


% Smooth noise in the data, otherwise the predictions have the exact same
% shape 
smooth_co2 = smoothdata(co2)
smooth_temp = smoothdata(temp) 

smooth_co2 = smoothdata(smooth_co2)
smooth_temp = smoothdata(smooth_temp) 


figure
yyaxis left
xlabel('Year')
plot(year, smooth_co2)
ylabel('CO_2 (ppm)')
hold on 
yyaxis right
plot(year, smooth_temp)
%legend('CO_2', 'Temperature')
ylabel('Temperature (Relative to 1951-80 Average')
title('CO_2 and Temperature Over Time (Smoothed)')


% Take fourier transformations of co2 and temp 
f_co2 = fft(smooth_co2) / length(smooth_co2)
f_temp = fft(smooth_temp) / length(smooth_temp)


% Create empirical transfer function
tf = f_temp./ f_co2
tf_rs = reshape(tf,[1,length(tf)])  

% BASIC TESTS
% test that temp response is equivalent - these graphs should show up as
% one line
temp_response = ifft(f_co2.*tf) * length(f_co2)

figure 
plot(year, smooth_temp)
hold on 
plot(year, temp_response)
legend('original', 'predicted')

%{
% sine wave with rough values of natural CO2 levels (2 increasing versions)
co2_250 = 50 * sin(.007*t) + 250
co2_400 = 50 * sin(.007*t) + 400
co2_800 = 50 * sin(.007*t) + 800

f_co2_250 = fft(co2_250) / length(co2_250)
f_co2_400 = fft(co2_400) / length(co2_400)
f_co2_800 = fft(co2_800) / length(co2_800)

response_250 = ifft(f_co2_250.*tf_rs) * length(co2_250)
response_400 = ifft(f_co2_400.*tf_rs) * length(co2_400)
response_800 = ifft(f_co2_800.*tf_rs) * length(co2_800)

figure
plot(t, response_250)
hold on 
plot(t, response_400)
plot(t, response_800)
legend('temp+250', 'temp+400', 'temp+600')
%}

% EMISSIONS SCENARIOS
load emissions.txt;
scen_year = emissions(:,1)

% SCENARIO A - BUSINESS AS USUAL
scen_a_co2 = emissions(:,2)

scen_year = scen_year(1:59)
scen_a_co2 = scen_a_co2(1:59)

f_scen_a = fft(scen_a_co2) / length(scen_a_co2)

response_scen_a = ifft(f_scen_a.*tf) * length(f_scen_a) 

figure
xlabel('Year')
yyaxis left
plot(year, co2)
hold on 
ylabel('CO_2 (ppm)')
plot(scen_year, scen_a_co2)
yyaxis right
plot(year, temp)
plot(scen_year, response_scen_a )
plot(scen_year, response_scen_a + 1.5 )
legend('historical-co2', 'projected-co2', 'historical-temperature', 'projected-temperature', 'corrected-projection')
legend('Location','northwest')
ylabel('Temperature (Relative to 1951-80 Average')
title('CO_2 and Temperature Over Time (Emissions Scenario A)')

% SCENARIO B 
scen_b_co2 = emissions(:,3)

scen_year = scen_year(1:59)
scen_b_co2 = scen_b_co2(1:59)

f_scen_b = fft(scen_b_co2) / length(scen_b_co2)

response_scen_b = ifft(f_scen_b.*tf) * length(f_scen_b) 

figure
xlabel('Year')
yyaxis left
plot(year, co2)
hold on 
ylabel('CO_2 (ppm)')
plot(scen_year, scen_b_co2)
yyaxis right
plot(year, temp)
plot(scen_year, response_scen_b )
plot(scen_year, response_scen_b + 1.25)
legend('historical-co2', 'projected-co2', 'historical-temperature', 'projected-temperature', 'corrected-projection')
legend('Location','northwest')
ylabel('Temperature (Relative to 1951-80 Average')
title('CO_2 and Temperature Over Time (Emissions Scenario B)')

% SCENARIO C
scen_c_co2 = emissions(:,4)

scen_year = scen_year(1:59)
scen_c_co2 = scen_c_co2(1:59)

f_scen_c = fft(scen_c_co2) / length(scen_c_co2)

response_scen_c = ifft(f_scen_c.*tf) * length(f_scen_c) 

figure
xlabel('Year')
yyaxis left
plot(year, co2)
hold on 
ylabel('CO_2 (ppm)')
plot(scen_year, scen_c_co2)
yyaxis right
plot(year, temp)
plot(scen_year, response_scen_c )
plot(scen_year, response_scen_c + 0.8 )
legend('historical-co2', 'projected-co2', 'historical-temperature', 'projected-temperature', 'corrected-projection')
legend('Location','northwest')
ylabel('Temperature (Relative to 1951-80 Average')
title('CO_2 and Temperature Over Time (Emissions Scenario C)')


% SCENARIO D
scen_d_co2 = emissions(:,5)

scen_year = scen_year(1:59)
scen_d_co2 = scen_d_co2(1:59)

f_scen_d = fft(scen_d_co2) / length(scen_d_co2)

response_scen_d = ifft(f_scen_d.*tf) * length(f_scen_d) 

figure
xlabel('Year')
yyaxis left
plot(year, co2)
hold on 
ylabel('CO_2 (ppm)')
plot(scen_year, scen_d_co2)
yyaxis right
plot(year, temp)
plot(scen_year, response_scen_d )
plot(scen_year, response_scen_d + 0.8 )
legend('historical-co2', 'projected-co2', 'historical-temperature', 'projected-temperature', 'corrected-projection')
legend('Location','northwest')
ylabel('Temperature (Relative to 1951-80 Average')
title('CO_2 and Temperature Over Time (Emissions Scenario D)')

% SCENARIO E
scen_e_co2 = emissions(:,6)

scen_year = scen_year(1:59)
scen_e_co2 = scen_e_co2(1:59)

f_scen_e = fft(scen_e_co2) / length(scen_e_co2)

response_scen_e = ifft(f_scen_e.*tf) * length(f_scen_e) 

figure
xlabel('Year')
yyaxis left
plot(year, co2)
hold on 
ylabel('CO_2 (ppm)')
plot(scen_year, scen_e_co2)
yyaxis right
plot(year, temp)
plot(scen_year, response_scen_e )
plot(scen_year, response_scen_e + 0.6 )
legend('historical-co2', 'projected-co2', 'historical-temperature', 'projected-temperature', 'corrected-projection')
legend('Location','northwest')
ylabel('Temperature (Relative to 1951-80 Average')
title('CO_2 and Temperature Over Time (Emissions Scenario E)')
