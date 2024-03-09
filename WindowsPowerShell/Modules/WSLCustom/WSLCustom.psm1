# 展示端口转发状态
function showPortProxy(){
	netsh interface portproxy show all
}


# 防火墙策略添加, 在WSL中可以Ping通宿主机
function firewallRule_WSL() {
	New-NetFirewallRule -DisplayName "WSL" -Direction Inbound  -InterfaceAlias "vEthernet (WSL)"  -Action Allow
}

# 将宿主机上的端口转发至WSL端口上
function portForward_WSL(WSL_SSH, 22, 22) {
	netsh interface portproxy add v4tov4 listenport=22 listenaddress=0.0.0.0 connectport=22 connectaddress=172.31.179.95
	netsh advfirewall firewall add rule name=WSL_SSH dir=in action=allow protocol=TCP localport=22 
}
#netsh advfirewall firewall add rule name=WSL_RSYNC dir=in action=allow protocol=TCP localport=873