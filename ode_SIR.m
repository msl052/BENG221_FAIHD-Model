%-------------------------------------------------------------------------
% User Section 4: Definition of the ODE system
%-------------------------------------------------------------------------
function deriv = ode_SIR (t, x, param)
    N = param.N;
    S = x(1);
    I = x(2);
    %R = x(3);
    dS = -param.beta * S * I;
    dI = param.beta * S * I - param.r * I;
    % Note: because S+I+R=constant, this equation could actually be omitted,
    % and R at any time point could simply be calculated as N-S-I.
    %dR = param.r * I;
    deriv = [dS;dI];
end