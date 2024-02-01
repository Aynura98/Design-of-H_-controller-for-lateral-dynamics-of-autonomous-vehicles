load('Track1.mat')



t = out.yaw.time;

[n,m] = size(t);
for i = 1 : n
    yaw(i) = out.yaw.signals.values(:,:,i);
end

yaw_signal.time = t;
yaw_signal.signals.values=yaw';


