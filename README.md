[![Build status](https://github.com/theengs/gateway-appliance/workflows/Build/badge.svg)](https://github.com/theengs/gateway-appliance/actions)
[![Check status](https://github.com/theengs/gateway-appliance/workflows/Checks/badge.svg)](https://github.com/theengs/gateway-appliance/actions)
[![GitHub license](https://img.shields.io/github/license/theengs/gateway-appliance.svg)](https://github.com/theengs/gateway-appliance/blob/development/LICENSE)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/theengs/gateway-appliance?label=Theengs%20Gateway)](https://github.com/theengs/gateway-appliance/releases)

# Theengs Gateway Appliance
[Ubuntu Core](https://ubuntu.com/core) appliance with [Theengs Gateway](https://github.com/theengs/gateway) pre-installed 

## How to install
Download the .img.xz file from the [latest release](https://github.com/theengs/gateway-appliance/releases) of this repository.

There are three files to choose from:

* theengs-gateway-core22-amd64.img.xz: for Intel NUC
* theengs-gateway-core22-pi-arm64.img.xz: for Raspberry Pi 3, 4, 400, CM4 and Zero 2 W
* theengs-gateway-core22-pi-armhf.img.xz: for Raspberry Pi 2, 3, 4, 400, CM4 and Zero 2 W

Note that the Raspberry Pi 2 only supports 32-bits, so you need the armhf image for this model. You also need a separate Bluetooth USB dongle (Bluetooth 4.0 or higher) to be able to use Theengs Gateway, because this model doesn't have a built-in Bluetooth chip.

See the instructions for [Installing Ubuntu Core 22 on a Raspberry Pi](https://ubuntu.com/core/docs/install-raspberry-pi), but use one of the images of this repository instead of the default Ubuntu Core 22 image.

## How to configure

You can show the Theengs Gateway snap's configuration with:

```shell
$ snap get -d theengs-gateway
{
        "ble": {
                "adapter": "",
                "scan-duration": 5,
                "time-between": 5
        },
        "ha": {
                "discovery": 1,
                "discovery-device-name": "TheengsGateway",
                "discovery-filter": "IBEACON GAEN MS-CDP",
                "discovery-topic": "homeassistant/sensor"
        },
        "log-level": "WARNING",
        "mqtt": {
                "host": "",
                "pass": "",
                "port": 1883,
                "pub-topic": "home/TheengsGateway/BTtoMQTT",
                "sub-topic": "home/TheengsGateway/+",
                "user": ""
        }
}
```

You need to set at least the MQTT configuration, for instance:

```shell
snap set theengs-gateway mqtt.host=MYBROKER mqtt.user=MYUSER mqtt.pass=MYPASS
```

Have a look at [Theengs Gateway's documentation](https://gateway.theengs.io/use/use.html#details-options) for the meaning of all configuration options.

Then give the snap access to Bluetooth:

```shell
snap connect theengs-gateway:bluez-client bluez:service
```

After this, restart the service:

```
snap restart theengs-gateway
```

Theengs Gateway should now run as a service. If you want it to start automatically after booting your appliance, enable the service with:

```shell
snap start --enable theengs-gateway
```

## How to build new images
If you want to build the images yourself, you can do this in one command:

```
./scripts/build-images.sh
```
