rosinit %Conexión con el nodo maestro
%%  
velPub = rospublisher('/turtle1/cmd_vel','geometry_msgs/Twist'); %Crear Publicador
velMsg = rosmessage(velPub); %Creación del mensaje
%%
velMsg.Linear.X=-1; %Asignar mensaje
velMsg.Angular.Z=1;
send(velPub,velMsg); %Enviar mensaje

pause(1) %

%%
subPos = rossubscriber('/turtle1/pose','turtlesim/Pose');
%%
subPos.LatestMessage  

%%
PoseSvcClient = rossvcclient('/turtle1/teleport_absolute');
PseMsg= rosmessage(PoseSvcClient);


%%
PseMsg.X = 3;
PseMsg.Y= 3;
PseMsg.Theta = 8;
call(PoseSvcClient,PseMsg);
pause(1)

%%
subPos.LatestMessage  
%%
rosshutdown;
