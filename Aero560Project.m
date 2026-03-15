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
params.P = 4.56e-6; 
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
thetaG_init = deg2rad(60);
thetaG_42 = deg2rad(12.3);

% Calculate Omega of Sun Pointing Frame
year = 86400*365;
omegaSP = (2*pi)/year;
Omega_SP = [0; 0; omegaSP]; 

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
euler0_42 = [alphaS0_42,betaS0_42,gammaS0_42];
omega0_42 = [alphaS0dot_42;betaS0dot_42;gammaS0dot_42];

quat0_42a = eul2quat(euler0_42,"ZYZ");
%quat0_42 = [quat0_42a(4);quat0_42a(1);quat0_42a(2);quat0_42a(3)];
quat0_42 = [quat0_42a(2); quat0_42a(3); quat0_42a(4); quat0_42a(1)];

xTarget_42 = [alphaTgt_42;betaTgt_42;gammaTgt_42;alphaTgtdot_42;betaTgtdot_42;gammaTgtdot_42];
targetAngles_42 = [alphaTgt_42;betaTgt_42;gammaTgt_42];

% Gains
kP = 0.1;
kD = 1;

kP_g = 0.1;
kD_g = 1;

% Run Simulation
out = sim("Aero560ProjectSimulink.slx");

% Extract Data
alphaBetaGamma = squeeze(out.alphaBetaGamma.Data);
timeABG = squeeze(out.alphaBetaGamma.Time);

hRW = squeeze(out.angMomRW.Data);
timehRW = squeeze(out.angMomRW.Time);

SRPTorque = squeeze(out.SRPTorque.Data);
timeSRP = squeeze(out.SRPTorque.Time);

quats = squeeze(out.quaternionOut.Data);
timeQuats = squeeze(out.quaternionOut.Time);

omega = squeeze(out.omegaOut.Data);
timeOmega = squeeze(out.omegaOut.Time);


% Plots
figure()
subplot(2,1,1)
plot(timeABG,alphaBetaGamma(:,1),'LineWidth',1.2)
hold on
plot(timeABG,alphaBetaGamma(:,2),'LineWidth',1.2)
plot(timeABG,alphaBetaGamma(:,3),'LineWidth',1.2)
ylim([-10,20])
grid on
legend("\alpha","\beta","\gamma")
ylabel("\alpha, \beta, \gamma [deg]")

subplot(2,1,2)
plot(timehRW,hRW(1,:),'LineWidth',1.2)
hold on
plot(timehRW,hRW(2,:),'LineWidth',1.2)
plot(timehRW,hRW(3,:),'LineWidth',1.2)
ylim([-.1,.1])
grid on
legend("h_x","h_y","h_z")
ylabel("h_x, h_y, h_z [Nms]")
xlabel("Time [s]")

figure()
plot(timeSRP, SRPTorque(1,:),'LineWidth',1.2)
hold on
plot(timeSRP, SRPTorque(2,:),'LineWidth',1.2)
plot(timeSRP, SRPTorque(3,:),'LineWidth',1.2)
grid on
xlim([0, 360]) 
ylim([-1e-6,2.1e-6])
ylabel("SRP Torque [Nm]")
xlabel("Time [s]")

figure()
subplot(2,1,1)
plot(timeQuats,quats(1,:),'LineWidth',1.2)
hold on
plot(timeQuats,quats(2,:),'LineWidth',1.2)
plot(timeQuats,quats(3,:),'LineWidth',1.2)
plot(timeQuats,quats(4,:),'LineWidth',1.2)
grid on
ylim([-0.1,1.1])
xlim([0, 360])
xlabel("Time [s]")
ylabel("Quaternions")
legend("\epsilon_1","\epsilon_2","\epsilon_3","eta")
subplot(2,1,2)
plot(timeOmega,omega(1,:),'LineWidth',1.2)
hold on
plot(timeOmega,omega(2,:),'LineWidth',1.2)
plot(timeOmega,omega(3,:),'LineWidth',1.2)
grid on
xlim([0, 360])
xlabel("Time [s]")
ylabel("Omega [rad/s]")
legend("\omega_x","\omega_y","\omega_z")


%% Control Flow Section

% Run Simulation
out2 = sim("Control_Flow.slx");

% Extract Data
booleanData = squeeze(out2.Boolean.Data);
booleanTime = squeeze(out2.Boolean.Time);

RWAngMom = squeeze(out2.rwAngMomentum.Data);
RWTime = squeeze(out2.rwAngMomentum.Time);

quaternions = squeeze(out2.quats.Data);
quaternionsTime = squeeze(out2.quats.Time);

omega2 = squeeze(out2.omegas.Data);
omega2Time = squeeze(out2.omegas.Time);

torqueSRP = squeeze(out2.SRPTorque.Data);
timeTorqueSRP = squeeze(out2.SRPTorque.Time);

ABGPlot = squeeze(out2.alphaBetaGamma.Data);
timeABGPlot = squeeze(out2.alphaBetaGamma.Time);

% Plot
figure()
subplot(2,1,1)
plot(RWTime,RWAngMom(:,1),LineWidth=1.2)
hold on
plot(RWTime,RWAngMom(:,2),LineWidth=1.2)
plot(RWTime,RWAngMom(:,3),LineWidth=1.2)
grid on
legend("h_x","h_y","h_z")
ylabel("h_x, h_y, h_z [Nms]")
xlabel("Time [s]")
subplot(2,1,2)
plot(booleanTime,booleanData,LineWidth=1.5,LineStyle="--")
grid on
ylim([-0.1 1.1])
ylabel("Gimbal Drive")
xlabel("Time [s]")

figure()
subplot(2,1,1)
hold on
plot(quaternionsTime,quaternions(1,:),LineWidth=1.2)
plot(quaternionsTime,quaternions(2,:),LineWidth=1.2)
plot(quaternionsTime,quaternions(3,:),LineWidth=1.2)
plot(quaternionsTime,quaternions(4,:),LineWidth=1.2)
ylim([-0.1,1.1])
grid on
xlabel("Time [s]")
ylabel("Quaternions")
legend("\epsilon_1","\epsilon_2","\epsilon_3","eta")

subplot(2,1,2)
hold on
plot(omega2Time,omega2(1,:),LineWidth=1.2)
plot(omega2Time,omega2(2,:),LineWidth=1.2)
plot(omega2Time,omega2(3,:),LineWidth=1.2)
grid on
xlabel("Time [s]")
ylabel("Omega [rad/s]")
legend("\omega_x","\omega_y","\omega_z")

figure()
plot(timeTorqueSRP,torqueSRP(1,:),LineWidth=1.2)
hold on
plot(timeTorqueSRP,torqueSRP(2,:),LineWidth=1.2)
plot(timeTorqueSRP,torqueSRP(3,:),LineWidth=1.2)
grid on
ylabel("SRP Torque [Nm]")
xlabel("Time [s]")

figure()
subplot(2,1,1)
plot(timeABGPlot,ABGPlot(:,1),LineWidth=1.2)
hold on
plot(timeABGPlot,ABGPlot(:,2),LineWidth=1.2)
plot(timeABGPlot,ABGPlot(:,3),LineWidth=1.2)
grid on
grid on
legend("\alpha","\beta","\gamma")
ylabel("\alpha, \beta, \gamma [deg]")
xlabel("Time [s]")
subplot(2,1,2)
plot(booleanTime,booleanData,LineWidth=1.5,LineStyle="--")
grid on
ylim([-0.1 1.1])
ylabel("Gimbal Drive")
xlabel("Time [s]")