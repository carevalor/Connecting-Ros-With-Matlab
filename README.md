# Connecting-Ros-With-Matlab
#### Start ROS and Hello Turtle Simulation

First launch three linux terminals. At the first terminal run the following commnand to start ROS.

`$ roscore`

Then, run the following command to start the hello turtle simulation

`$ rosrun turtlesim turtlesim_node`


#### Master Node

Once ROS is working, connect matlab with the master node using this command with matlab.
```matlab
rosinit
```
#### Publisher

Now Matlab is connected with ROS' master node. Let's create a publisher. 
This publisher will allows us to put information into a topic.
```matlab
velPub = rospublisher('/turtle1/cmd_vel','geometry_msgs/Twist');
```
The rospublisher function has two arguments. The first one refers to the topic. Topics can be listed with the rostopic list command at the terminal.
The second one refers to the message type of the topic.

Then, you have to create the message. Run the following matlab command.
```matlab
velMsg = rosmessage(velPub);
```
Now, send a message with velocity information to the topic using the publisher. 
```matlab
velMsg.Linear.X=-1;
velMsg.Angular.Z=1;
send(velPub,velMsg);
pause(1) 
```
You will see the turtle moving on.

#### Subscriber

Now, we wanna see the turtle's position and orientation. So, we need to subscribe to a topic.
First, you're gonna create a subscriber. Again, the first argument is the topic's name and the second one is the message type.

```matlab
subPos = rossubscriber('/turtle1/pose','turtlesim/Pose');
subPos.LatestMessage  
```
Finnaly, use the LatestMessage option to know the previous values of position and orientation.

If we send a message using our publisher, the values changes.

```matlab
PseMsg.X = 3;
PseMsg.Y= 3;
PseMsg.Theta = 8;
call(PoseSvcClient,PseMsg);
pause(1)
subPos.LatestMessage 
```
#### Teleport
Also, we can use a service to change the pose of the turtle. We can't change the pose values using the pose topic. So, we need to create a client for the teleport service. The rossvcclient only needs an argument, the service. We also need to create a message to send the new pose values.

```matlab
PoseSvcClient = rossvcclient('/turtle1/teleport_absolute');
PseMsg= rosmessage(PoseSvcClient);
```matlab

#### Disconnect

When you finish to use ROS with matlab,  use the following command to finish the master node.
```matlab
rosshutdown;
```
