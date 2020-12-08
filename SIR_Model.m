%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Starting script to the module 'SIR models of epidemics'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;
clc;

in_SIR_Model; % initialize parameter and intial values
% Implements the basic SIR model, and plots simulation results
%-------------------------------------------------------------------------
% Now we solve the ODE system and plot the results
%-------------------------------------------------------------------------

% Extract initial values from the 'initial' structure and collect them
% in a column vector for use in 'ode45'.
% initial_values = []; % initialize initial values
% variable_names = fieldnames(initial); % list variable names
% for i=1:length(variable_names) 
%     initial_values1 = [initial_values; initial.(variable_names{i})]; % used for ode45
% end

% % prepare legend texts
% legend_texts = cell(length(variable_names), 1);
% for i=1:length(variable_names) 
%     text = [variable_names{i} '(t)'];
%     legend_texts{i} = text;
% end

%-------------------------------------------------------------------------
% SIR Model
%-------------------------------------------------------------------------

% param.beta = 2.2e-11;
% param.r = 2.2e-11*0.2435/0.2653

% Best Ones!
param.beta = 0.039;
param.r = param.beta -0.02;

% param.beta = 3.43;
% param.r = 2;%1.5e-5;
end_time = 400;

% initial value vector for SIR
%initial_valuesSIR = [initial.S;initial.I;initial.R];
initial_valuesSIR = [initial.S;initial.I];
% integrate the ODE system for SIR Model
[t, q] = ode15s(@(t, x) ode_SIR(t, x, param), ...
   [0 end_time], ...
   initial_valuesSIR, ...
   []);

% SIR Model 
S = q(:,1);
I = q(:,2);
%R = q(:,3);
R = 1-S-I;

% Plot the SIR Model
figure;
hold on;
plot(t,S); % S
plot(t,I); % I
plot(t,R); % R
plot(data.S,'*');
plot(data.I,'*');
plot(data.R+data.D,'*');
title(['SIR Model N=',num2str(N)]);
xlabel('time [day]');
ylabel('Percentage of Population');
legend('S(t)','I(t)','R(t)');

data_D = data.D;
data_R = data.R;
data_I = data.I;
data_S = data.S;

start = 1;

f1 = figure();
movegui(f1,'southwest');
hold on;
plot(t,S);
plot(data_S(start:end),'*');
title("Susceptible");
legend("Model","Data");
xlabel('time [day]');
ylabel('Percentage of Population');

f2 = figure;
movegui(f2,'south');
hold on;
plot(t,I);
plot(data_I(start:end),'*');
title("Infected");
legend("Model","Data");
xlabel('time [day]');
ylabel('Percentage of Population');

f3 = figure;
movegui(f3,'southeast');
temp = data_R+data_D;
hold on;
plot(t,R);
plot(temp(start:end),'*');
title("Removed");
legend("Model","Data");
xlabel('time [day]');
ylabel('Percentage of Population');

% % plotting the populations relative to each other
% figure
% plot(S,y(:,4));
% ylabel('infected population');
% xlabel('susceptible population');
% title('SIR dynamics');

% figure;
% hold on;
% plot(data_I(start:end),'*');
% plot(temp(start:end),'*');
% title("I and R");
% legend("I","R");
