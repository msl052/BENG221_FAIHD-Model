%-------------------------------------------------------------------------
% User Section 4: Definition of the ODE system
%-------------------------------------------------------------------------
function deriv = ode_FAIHD(t, x, param)

    N = param.N; % total population
    
    F = x(1);
    A = x(2);
    I = x(3);
    H = x(4);
    D = x(5);
    dF = -param.g * F * I - param.m * F;
    dA = -param.p * A * I - param.m * A;
    dI = param.g*F*I + param.p*A*I - param.r * I - param.d * I;
    dH = param.r * I + param.m * F + param.m * A;
    dD = param.d * I;
    deriv = [dF;dA;dI;dH;dD];
end