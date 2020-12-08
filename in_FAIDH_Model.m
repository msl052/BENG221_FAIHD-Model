%-------------------------------------------------------------------------
% User Section 1: Load Data and Define its Parameters
%-------------------------------------------------------------------------
%
% Initial conditions are the values of all variables at time zero.
%
% NOTE: Do not change the name 'initial' Define the initial values
%       in the same order as the derivatives

% Load data for US
B = readmatrix("national-history_ US.csv"); 
B = flip(B); % need to flip the data since goes from current to past

% Initialize Parameters from Literature
% a = 0.178;
% b = 0.015;
% f = 7.40e+05;

% define time window of the data
tmin = 64; 
tmax = 308;

% extract groups from data
N = 328.20*10^6; % total population
%N = 500;
nf = 10^6; % normalizing factor
data.D = B(tmin:tmax,2)/N; % death group data
data.R = B(tmin:tmax,15)/N; % recovered group data
data.I = (B(tmin:tmax,13)-data.R)/N; % infected group data
data.S = (1-data.D-data.R-data.I); % susceptible group data
data.T = (1:(tmax-tmin+1))';

%-------------------------------------------------------------------------
% User Section 2: Definition of initial conditions
%-------------------------------------------------------------------------
% Create initial structure
%N = 499; %
M = max(data.I);
FNratio = .60;%3/5; % ratio of people practicing social distancing from susceptible population
initial.I = data.I(1);	% set the initial value of 'I'
initial.R = data.R(1);	% set the initial value of 'R'
initial.S = data.S(1);	% set the initial value of 'S'
initial.F = FNratio * initial.S;    % set the initial value of 'F'
initial.A = (initial.S - initial.F); % set the initial value of 'A'
initial.H = 0/N; % set the initial value of 'H'
initial.D = 0/N; % set the initial value of 'D'

%-------------------------------------------------------------------------
% User Section 3: Definition of model parameters
%-------------------------------------------------------------------------
%
% These parameters are passed to the function that calculates the
% derivatives.
%  
% NOTE: Do not change the name 'param'!
%

W = 10;
P = 0.01*W;
a = 0.178;%W + P;
b = 0.5;%W;
f = 7.40e+05;

param.beta = 0.039; % rate S turns to I
param.r = 0.0050;    % rate I turns to H %fixed
param.g = 6e-11*N;    % rate F turns to I
param.m = 0;             % rate F or A turns to H
param.d = 7.0363e-04;          % rate I turns to D % fixed
param.p = param.g*2; % rate A turns to I
param.N = N;

%-------------------------------------------------------------------------
% User Section 3: Definition of the simulation time
%-------------------------------------------------------------------------
end_time = 300;

% Calculate and print R_0 on the screen
%N = initial.F + initial.A + initial.I + initial.R;
R_0 = param.beta * N / param.r;