# may/13/2021 11:25:40 by RouterOS 6.47.8
# software id = A82C-HLGU
#
# model = RouterBOARD 952Ui-5ac2nD
# serial number = 924909D46E5B
/interface bridge
add name=bridge1
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik
set [ find default-name=wlan2 ] ssid=MikroTik
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip hotspot profile
set [ find default=yes ] html-directory=flash/hotspot
/ip pool
add name=dhcp_pool0 ranges=199.32.155.2-199.32.155.254
add name=dhcp_pool1 ranges=199.32.155.2-199.32.155.254
add name=dhcp_pool2 ranges=192.168.99.2-192.168.99.254
/ip dhcp-server
add address-pool=dhcp_pool1 disabled=no interface=bridge1 name=dhcp1
add address-pool=dhcp_pool2 disabled=no interface=ether4 name=dhcp2
/interface bridge port
add bridge=bridge1 interface=ether2
add bridge=bridge1 interface=ether3
add bridge=bridge1 interface=ether5
/ip address
add address=199.32.155.1/24 interface=bridge1 network=199.32.155.0
add address=192.168.99.1/24 interface=ether4 network=192.168.99.0
/ip dhcp-client
add disabled=no interface=ether1
/ip dhcp-server lease
add address=199.32.155.251 client-id=1:b8:27:eb:5f:25:da mac-address=\
    B8:27:EB:5F:25:DA server=dhcp1
add address=199.32.155.252 client-id=\
    ff:e2:34:3f:3e:0:2:0:0:ab:11:89:9:b5:42:ac:40:cc:22 mac-address=\
    08:00:27:D0:4C:B8 server=dhcp1
/ip dhcp-server network
add address=192.168.99.0/24 gateway=192.168.99.1
add address=199.32.155.0/24 gateway=199.32.155.1 netmask=24
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
add action=dst-nat chain=dstnat dst-address=192.168.99.2 dst-port=8800 \
    protocol=tcp src-address=199.32.155.0/24 to-addresses=192.168.99.2 \
    to-ports=443
add action=masquerade chain=srcnat disabled=yes dst-address=199.32.155.252 \
    dst-port=8800 out-interface=bridge1 protocol=tcp src-address=\
    199.32.155.0/24
/system clock
set time-zone-name=Europe/Kiev
/system routerboard settings
set auto-upgrade=yes
/tool sniffer
set filter-interface=ether4 filter-stream=yes streaming-enabled=yes \
    streaming-server=199.32.155.254
