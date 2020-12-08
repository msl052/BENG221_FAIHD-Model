%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Starting script to the module 'SIR models of epidemics'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;
clc;

%-------------------------------------------------------------------------
% FAIHD Model
%-------------------------------------------------------------------------

% initialize parameter and intial values
in_FAIDH_Model;


% Solve ode of the Model
initial_valuesFAIHD = [initial.F;initial.A;initial.I;initial.H;initial.D]; % initial value vector for FAIHD
[t, w] = ode15s(@(t, x) ode_FAIHD(t, x, param), ...
               [0 end_time], ...
               initial_valuesFAIHD, ...
               []); % integrate the ODE system for FAIHD Model     

% FAIHD Model
model.T = linspace(1,end_time); % time vector
model.F = interp1(t,w(:,1),model.T);
model.A = interp1(t,w(:,2),model.T);
model.I = interp1(t,w(:,3),model.T);
model.H = interp1(t,w(:,4),model.T);
model.D = interp1(t,w(:,5),model.T);
model.S = model.F+model.A;
model.R = model.D+model.H;

%-------------------------------------------------------------------------
% Plot SIHD Data and Model TOGETHER
%-------------------------------------------------------------------------
figure;
hold on;
plot(model.T,model.S,'c','LineWidth',1); % S
plot(model.T,model.I,'m','LineWidth',1); % I
plot(model.T,model.H,'b','LineWidth',1); % H
plot(model.T,model.D,'r','LineWidth',1); % D
plot(data.T,data.S,'*c');
plot(data.T,data.I,'*m');
plot(data.T,data.R,'*b');
plot(data.T,data.D,'*r');
%plot(t,y(:,2)+y(:,3)); % S
%plot(t,y(:,5)+y(:,6)); % R
legend('S(t)','I(t)','H(t)','D(t)','S Data','I Data','H Data','D Data');
title(['FAIHD Model F(0)/A(0)=',num2str(initial.F/initial.A),' N=',num2str(param.N)]);
xlabel('time [day]');
ylabel('Percentage of Population');

%-------------------------------------------------------------------------
% Plot SIHD Data and Model SEPARATE
%-------------------------------------------------------------------------
fig_loc = ["southwest","south","southeast","northwest"];
comp_model = [model.S;model.I;model.H;model.D];
comp_data = [data.S,data.I,data.R,data.D];
title_list = ["Susceptible (F+A)","Infected","Healed","Death"];
%title_list = ["Susceptible","Infected","Recovered"];
for i = 1:4
    movegui(figure,fig_loc(i));
    hold on;
    plot(model.T,comp_model(i,:));
    plot(data.T,comp_data(:,i),'*');
    title("FAIHD: "+title_list(i));
    legend("Model","Data");
    xlabel('time [day]');
    ylabel('Percentage of Population');
end


%-------------------------------------------------------------------------
% Plot F and A Model
%-------------------------------------------------------------------------
figure;
hold on;
plot(model.T,model.F);
plot(model.T,model.A);
title("FAIHD: F and A");
legend("F Model","A Model");
xlabel('time [day]');
ylabel('Percentage of Population');

%-------------------------------------------------------------------------
% Sensititivy Analysis
%-------------------------------------------------------------------------

% Define Sensitivity Analysis
init_sens = zeros(20,1);
tspan = [data.T(1) data.T(end)];
[t,X] = ode45(@(t,X) sensitivity_FAIHD(t,X,model,param), tspan, init_sens);

% Rank Sensitivity
rank(X) % if = 20 then structurally identifiable. That means they are independent

% Sensititivity of Parameter Per Group Equation
sensA = vecnorm(X,2)
