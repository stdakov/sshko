# sshko
Are you lazy and can not remember the ssh connection? Then this is for you! This is an SSH connection manager. It can be easily modified. 

![](img/pic2.png)

## Usage
* copy sshko.sh and put it where you want (I put it in the user home dir ~/)
* Make an alias
```
alias sshko="~/sshko.sh $@"
```
* Try it:
```
sshko
```
it should output a message
```
ssh log file is empty 
```
try to use it with an ssh connection (same as ssh command)
```
sshko user@192.168.1.101
```
it will save the connection and execute SSH and then ask you for the password

if you try it again without argument it will show you a dialog with all ssh connections
```
sshko
```
![](img/pic1.png)
Basically, it saves every connection in the ~/.sshLog.txt file


Now you don't need to remember any SSH connections, just call `sshko` and it will show you all ssh used connections.
![](img/pic2.png)

## Requirements
* installed `ssh`

Happy sshing !!! :) 
