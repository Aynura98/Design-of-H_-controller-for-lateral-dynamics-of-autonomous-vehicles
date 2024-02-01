function [ k8, res ] = h8( A, Bu, Bw, Cz, Dzu, Dzw )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
warning('off','YALMIP:strict');
warning('off','sedumi:strict');

nx=size(A,1);
nu=size(Bu,2);
nw=size(Bw,2);
nz=size(Cz,1);

X = sdpvar(nx,nx);
Y = sdpvar(nu,nx);
gamma8 = sdpvar(1);

v11 = (A*X+Bu*Y)+(A*X+Bu*Y)';
v12 = Bw;
v13 = (Cz*X+Dzu*Y)';
v21 = Bw';
v22 = -gamma8*eye(nw);
v23 = Dzw';
v31 = Cz*X+Dzu*Y;
v32 = Dzw;
v33 = -gamma8*eye(nz);
V1 =  (X >= 0) ;
V2 = ([v11  v12   v13;
       v21  v22   v23;
       v31  v32   v33] <= 0);
V3 = (gamma8 >= 0); 

V = [V1, V2, V3];

options = sdpsettings('solver','lmilab','verbose',0);
res = optimize( V, gamma8, options)
k8 = double(Y)*inv(double(X));

end

