%%traj ginput 

DIM = 100;
figure; plot(0,0); axis([-DIM DIM -DIM DIM])
[x,y]=ginput()

XY = [x,y]
Z=zeros(size(XY,1),1)

H=15;
L= length(Z)
Z(floor(L/3):floor(L*2/3))=H
ramp_up = 1:floor(L/3)
Z(ramp_up)=0:H/(length(ramp_up)-1):H
ramp_down = floor(L*2/3):L
Z(ramp_down)=H:-H/(length(ramp_down)-1):0
Z = Z +randn(L,1)*H/5
Z=Z-Z(1)
figure; plot(Z); hold on; plot(smooth(Z,10,'loess')); hold off
Z = smooth(Z,10,'loess')
Z=Z-Z(1)




dXY = diff(XY)
yaw= atan2(dXY(:,2),dXY(:,1)).*180/pi
yaw = [0 ; yaw]; % to start from 0  

roll = rand(length(Z),1)
roll = roll-mean(roll)
roll(1)=0
figure, plot(smooth(roll,10,'loess'))
roll = smooth(roll,10,'loess').*180/pi
roll(1)=0; % to start from 0 

pitch = rand(length(Z),1)
pitch = pitch-mean(pitch)
pitch(1)=0
figure, plot(pitch), hold on; plot(smooth(pitch,10,'loess')); hold off
pitch = smooth(pitch,10,'loess').*180/pi
pitch(1)=0 % to start fom 0 

figure, plot(pitch),
figure, plot(roll),
figure, plot(yaw),


time = (0:(250/(length(Z)-1)):250)'
constraints = [time, XY, Z, yaw, pitch, roll]

