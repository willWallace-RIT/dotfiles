#!/bin/sh
#
# revised from z3bra - (c) wtfpl 2014 by Will Gardner

clock() {
	date '+%Y-%m-%d %H:%M'
}

battery() {
	BATC=/sys/class/power_supply/BAT0/capacity
	BATS=/sys/class/power_supply/BAT0/status
	
	test "`cat $BATS`" = "Charging" && echo -n '+' || echo -n '-' 
	sed -n p $BATC
}
zubats() {	
	BATC=/sys/class/power_supply/BAT0/capacity
	cat $BATC
}

volume() {
	amixer get Master|sed -n '/Playback/s/.*\([0-9].[0-9]*\)%.*/\1/p'
}


cpuload() {
	LINE=`ps -eo pcpu|grep -vE '^\s*(0.0|%CPU)' |sed -n '1h;$!H;$g;s/\n/ +/gp'`
	bc <<< $LINE
}

memused() {
	read -d "\n" t f <<< `cat /proc/meminfo|grep -E 'Mem(Total|Free)'|awk '{print $2}'`
	 bc <<< "scale = 2; 100 - $f / $t * 100" | cut -d. -f1
}

network() {
	read lo int1 int2 <<< `ip link | sed -n 's/^[0-9]: \(.*\):.*$/\1/p'`
	if iwconfig $int1 >/dev/null 2>&1; then 
		wifi=$int1
		eth0=$int2
	else
		wifi=$int2
		eth0=$int1
	fi
	ip link show $eth0 |grep 'state UP' > /dev/null && int=$eth0||int=$wifi
	ping -c 1 8.8.8.8 >/dev/null 2>&1 &&
	echo "$int connected" || echo "$int disconnected"
}

groups() {
	echo "`ratpoison -c groups | cut -sd '*' -f1`/`ratpoison -c groups|wc -l`"
}


## loop of things
while :; do
	buf="%{F#FF0000FF}"
	buf="${buf} [$(groups)]    --   "
	if [ $(zubats) -lt 30 ]
       	then
		buf="${buf}%{F#FFFF0000}"
	fi
	buf="${buf} BAT: $(battery)%% "
	
	if [ $(zubats) -lt 30 ] 
	then
		buf="${buf}%{F#FF0000FF}"
	fi
	buf="${buf} CLK: $(clock) -"
	buf="${buf} NET: $(network) -"
	buf="${buf} CPU: $(cpuload)%% -"
	buf="${buf} RAM: $(memused)%% -"
	buf="${buf} VOL: $(volume)%%"
	buf="${buf}  %{F-}"
	echo $buf 
	sleep 1 # update every second
done
