%% Aero 560 Final Project
% Paige and Neil

%% Setup Parameters

params.a = 4.899; %[m]
params.b = 0.25; %[m]
params.d = 0.1; %[m]
params.e = 0.15; %[m]
params.thetai = deg2rad(5); %[rads]
params.mB = 20; %[kg]
params.mS = 4; %[kg]
params.IB = diag([0.542,0.392,0.258]); %[kgm^2]
params.IS = diag([3,3,6]); %[kgm^2]
params.P = 
params.Ap = 6.023;
params.Ca = 0.053;
params.Cs = 0.882;
params.Cd = 0.065;
params.Bf = 2/3;

%% Section 4.1

% Set ThetaG Value
thetaG_41 = deg2rad(12.3);

% Initial States - Case 1
alphaS0_41 = deg2rad(-120);
betaS0_41 = deg2rad(20);
gammaS0_41 = deg2rad(5);
alphaS0dot_41 = deg2rad(0.01);
betaS0dot_41 = deg2rad(0.01);
gammaS0dot_41 = deg2rad(0.01);

x0_41 = [alphaS0_41;betaS0_41;gammaS0_41;alphaS0dot_41;betaS0dot_41;gammaS0dot_41];

%% Section 4.2

% Set ThetaG Value
thetaG_42 = deg2rad(12.3);

% Initial States - Case 3
alphaS0_42 = deg2rad(5);
betaS0_42 = deg2rad(20);
gammaS0_42 = deg2rad(5);
alphaS0dot_42 = deg2rad(0.01);
betaS0dot_42 = deg2rad(0.01);
gammaS0dot_42 = deg2rad(0.01);

alphaTgt_42 = deg2rad(0);
betaTgt_42 = deg2rad(15);
gammaTgt_42 = deg2rad(0);
alphaTgtdot_42 = deg2rad(0);
betaTgtdot_42 = deg2rad(0);
gammaTgtdot_42 = deg2rad(0);

x0_42 = [alphaS0_42;betaS0_42;gammaS0_42;alphaS0dot_42;betaS0dot_42;gammaS0dot_42];

xTarget_42 = [alphaTgt_42;betaTgt_42;gammaTgt_42;alphaTgtdot_42;betaTgtdot_42;gammaTgtdot_42];

% Gains
kP = 0.1;
kD = 1;



