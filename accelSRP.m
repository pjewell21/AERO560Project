function [aSRP] = accelSRP (area,Psr,JDvect,cr,mass)

% Inputs:
% area = area of spacecraft exposed to sun [m2]
% Psr = solar radiation pressure
% mass = mass of the spacecraft
% JDvect = vector of Julian Dates

% Outputs:
% aSRP = vector of SRP values

for i = 1:length(JDvect)
    [lamda eps r_S] = solar_position(JDvect(i));
    fSRP = -Psr*cr*area*r_S;
    aSRP(i) = fSRP/mass;

end
