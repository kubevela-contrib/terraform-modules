set -x
chmod 400 ${private_key_path}

curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh
source /root/.bash_profile
tiup cluster
echo 'MaxSessions 20' >> /etc/ssh/sshd_config
systemctl restart sshd
tiup cluster deploy db v5.4.0 ./topo.yaml --yes
tiup cluster start db --init