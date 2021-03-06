#!/bin/bash
#
set -e
TOOL=GCC_ARM

# Hook point for your wifi SSID and password
WIFI_SSID="ssid"
WIFI_PASS="password"

function patch_wifi {
    sed -i -e "s/SSID/${WIFI_SSID}/g" mbed_app.json
    sed -i -e "s/Password/${WIFI_PASS}/g" mbed_app.json
}

echo Compiling with $TOOL
echo Ethernet v4
cp configs/eth_v4.json ./mbed_app.json
BOARD=K64F
mbed compile -m $BOARD -t $TOOL
cp BUILD/$BOARD/$TOOL/mbed-os-example-client.bin $BOARD-$TOOL-eth-v4.bin

BOARD=NUCLEO_F429ZI
mbed compile -m $BOARD -t $TOOL
cp ./BUILD/$BOARD/$TOOL/mbed-os-example-client.bin $BOARD-$TOOL-eth-v4.bin
cp configs/eth_odin_v4.json ./mbed_app.json

BOARD=UBLOX_EVK_ODIN_W2
mbed compile -m $BOARD -t $TOOL
cp ./BUILD/$BOARD/$TOOL/mbed-os-example-client.bin $BOARD-$TOOL-eth-v4.bin

echo Ethernet v6
cp configs/eth_v6.json ./mbed_app.json
BOARD=K64F
mbed compile -m $BOARD -t $TOOL
cp BUILD/$BOARD/$TOOL/mbed-os-example-client.bin $BOARD-$TOOL-eth-v6.bin

BOARD=NUCLEO_F429ZI
mbed compile -m $BOARD -t $TOOL
cp ./BUILD/$BOARD/$TOOL/mbed-os-example-client.bin $BOARD-$TOOL-eth-v4.bin

BOARD=UBLOX_EVK_ODIN_W2
cp configs/eth_odin_v6.json ./mbed_app.json
mbed compile -m $BOARD -t $TOOL
cp ./BUILD/$BOARD/$TOOL/mbed-os-example-client.bin $BOARD-$TOOL-eth-v6.bin

echo WIFI - ESP8266
cp configs/wifi_esp8266_v4.json ./mbed_app.json
BOARD=K64F
patch_wifi
mbed compile -m $BOARD -t $TOOL
cp BUILD/$BOARD/$TOOL/mbed-os-example-client.bin $BOARD-$TOOL-esp-wifi-v4.bin

BOARD=NUCLEO_F429ZI
mbed compile -m $BOARD -t $TOOL
cp ./BUILD/$BOARD/$TOOL/mbed-os-example-client.bin $BOARD-$TOOL-esp-wifi-v4.bin

echo WIFI - ODIN for UBLOX_EVK_ODIN_W2
cp configs/wifi_odin_v4.json ./mbed_app.json
patch_wifi
BOARD=UBLOX_EVK_ODIN_W2
mbed compile -m $BOARD -t $TOOL
cp ./BUILD/$BOARD/$TOOL/mbed-os-example-client.bin $BOARD-$TOOL-wifi-v4.bin

echo 6-Lowpan builds
cp configs/mesh_6lowpan.json ./mbed_app.json
BOARD=K64F
mbed compile -m $BOARD -t $TOOL
cp BUILD/$BOARD/$TOOL/mbed-os-example-client.bin $BOARD-$TOOL-6lowpan.bin

BOARD=NUCLEO_F429ZI
mbed compile -m $BOARD -t $TOOL
cp ./BUILD/$BOARD/$TOOL/mbed-os-example-client.bin $BOARD-$TOOL-6lowpan.bin

echo 6-Lowpan Sub-1 GHz builds
cp configs/mesh_6lowpan_subg.json ./mbed_app.json
BOARD=NUCLEO_F429ZI
mbed compile -m $BOARD -t $TOOL
cp ./BUILD/$BOARD/$TOOL/mbed-os-example-client.bin $BOARD-$TOOL-6lowpan-subg.bin

echo Thread builds
cp configs/mesh_thread.json ./mbed_app.json
BOARD=K64F
mbed compile -m $BOARD -t $TOOL
cp BUILD/$BOARD/$TOOL/mbed-os-example-client.bin $BOARD-$TOOL-Thread.bin

BOARD=NUCLEO_F429ZI
mbed compile -m $BOARD -t $TOOL
cp ./BUILD/$BOARD/$TOOL/mbed-os-example-client.bin $BOARD-$TOOL-Thread.bin

echo WiFi-X-Nucleo
cp configs/wifi_idw01m1_v4.json mbed_app.json
patch_wifi
BOARD=NUCLEO_L476RG
mbed compile -m $BOARD -t $TOOL
cp ./BUILD/$BOARD/$TOOL/mbed-os-example-client.bin $BOARD-$TOOL-WifiXNucleo.bin

echo Realtek RTL8195AM WiFi
BOARD=REALTEK_RTL8195AM
cp configs/wifi_rtw_v4.json mbed_app.json
patch_wifi
mbed compile -m $BOARD -t $TOOL
cp ./BUILD/$BOARD/$TOOL/mbed-os-example-client.bin $BOARD-$TOOL-Wifi.bin

echo DISCO_L475VG_IOT01A with Wi-Fi
BOARD=DISCO_L475VG_IOT01A
cp configs/wifi_ism43362.json mbed_app.json
patch_wifi
mbed compile -m $BOARD -t $TOOL
cp ./BUILD/$BOARD/$TOOL/mbed-os-example-client.bin $BOARD-$TOOL-ism43362.bin


