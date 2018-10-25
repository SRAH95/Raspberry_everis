#!/bin/bash

new_ip=$(hostname -I | awk '{print 2}')
if ! ping -q -cl google.com; then
	/etc/init.d/autoconnectnet start
fi
#if ["$new_ip" != "$(hostname -I | awk '{print 2}')"]; then
#	sudo reboot
#fi

