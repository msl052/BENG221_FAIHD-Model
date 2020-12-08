function dxdt = sensitivity_FAIHD(t,x,model,param)
%FAIHD_SEN Summary of this function goes here
%   Detailed explanation goes here
    N = 328.2*10^6; % total population
    
    F = interp1(model.T,model.F,t);
    A = interp1(model.T,model.A,t);
    I = interp1(model.T,model.I,t);
    H = interp1(model.T,model.H,t);
    D = interp1(model.T,model.D,t);
    
    dxdt = zeros(20,1);
    dxdt(1) = -param.g*I*x(1) - param.g*F*x(9) - F*I;
    dxdt(2) = -param.g*I*x(2) - param.g*F*x(10);
    dxdt(3) = -param.g*I*x(3) - param.g*F*x(11);
    dxdt(4) = -param.g*I*x(4) - param.g*F*x(12);
    dxdt(5) = -param.p*I*x(5) - param.p*A*x(9);
    dxdt(6) = -param.p*I*x(6) - param.p*A*x(10) - A*I;
    dxdt(7) = -param.p*I*x(7) - param.p*A*x(11);
    dxdt(8) = -param.p*I*x(8) - param.p*A*x(12);
    dxdt(9) = (param.g*F + param.p*A - param.r - param.d)*x(9) + F*I + param.g*I*x(1) + param.p*I*x(5);
    dxdt(10) = (param.g*F + param.p*A - param.r - param.d)*x(10) + A*I + param.g*I*x(2) + param.p*I*x(6);
    dxdt(11) = (param.g*F + param.p*A - param.r - param.d)*x(11) - I + param.g*I*x(3) + param.p*I*x(7);
    dxdt(12) = (param.g*F + param.p*A - param.r - param.d)*x(12) - I + param.g*I*x(4) + param.p*I*x(8);
    dxdt(13) = param.r*x(9);
    dxdt(14) = param.r*x(10);
    dxdt(15) = I + param.r*x(11);
    dxdt(16) = param.r*x(12);
    dxdt(17) = param.d*x(9);
    dxdt(18) = param.d*x(10);
    dxdt(19) = param.d*x(11);
    dxdt(20) = I + param.d*x(12);
    
end