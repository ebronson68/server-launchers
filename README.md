# server-launchers

Launchers and services for Linux-based game servers



```
apt update -y && apt full-upgrade -y
apt install make cc build-essential default-jre -y
chmod +x  /usr/local/bin/minecraft
useradd -r minecraft -d /home/minecraft/ -m
cd /opt
git clone https://github.com/ncopa/su-exec.git
cd su-exec/
make install
mv su-exec /usr/bin
rm -r /opt/su-exec/
cd /home/minecraft/
wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/dTools.jar -O $DIRECTORY/BuildTools.jar
minecraft install
su-exec minecraft /bin/bash -c "cd /home/minecraft && tmux -S /tmp/tmux-997/minecraft session -d -s minecraft -n minecraft java -jar BuildTools.jar"
minecraft attach
vim eula.txt
```
