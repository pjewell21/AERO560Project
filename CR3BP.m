function dstate = CR3BP(time, state, mustar)

x = state(1);
y = state(2);
z = state(3);
dx = state(4);
dy = state(5);
dz = state(6);

r1 = sqrt((x-mustar)^2 + y^2 + z^2);
r2 = sqrt((x+1-mustar)^2 + y^2 + z^2);

ddx = (-(1-mustar)*(x-mustar)/(r1^3)) - ((mustar*(x+1-mustar))/(r2^3)) + x + (2*dy);
ddy = ((-(1-mustar)*y)/(r1^3)) - ((mustar*y)/(r2^3)) + y - (2*dx);
ddz = ((-(1-mustar)*z)/(r1^3)) - ((mustar*z)/(r2^3));

dstate = [dx;dy;dz;ddx;ddy;ddz]; % must be a column vector

end