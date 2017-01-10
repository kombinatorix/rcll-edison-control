#!/bin/bash
#session started with tmuxinator via: timuxinator edisons
session=edisons

#Assigments of the different windows
window_main=${session}:0
window_cyan=${session}:1
window_magenta=${session}:2

#Assigments MPS to pane
bs=0
ds=1
cs1=2
cs2=3
rs1=4
rs2=5

#Defining the panes for CYAN
pane_c_bs=${window_cyan}.${bs}
pane_c_ds=${window_cyan}.${ds}
pane_c_cs1=${window_cyan}.${cs1}
pane_c_cs2=${window_cyan}.${cs2}
pane_c_rs1=${window_cyan}.${rs1}
pane_c_rs2=${window_cyan}.${rs2}

#Defining the panes for MAGENTA
pane_m_bs=${window_magenta}.${bs}
pane_m_ds=${window_magenta}.${ds}
pane_m_cs1=${window_magenta}.${cs1}
pane_m_cs2=${window_magenta}.${cs2}
pane_m_rs1=${window_magenta}.${rs1}
pane_m_rs2=${window_magenta}.${rs2}

ARRAY_CYAN_PANES=($pane_c_bs $pane_c_ds $pane_c_cs1 $pane_c_cs2 $pane_c_rs1 $pane_c_rs2)
ARRAY_MAGENTA_PANES=($pane_m_bs $pane_m_ds $pane_m_cs1 $pane_m_cs2 $pane_m_rs1 $pane_m_rs2)
ARRAY_ALL_PANES=(${ARRAY_CYAN_PANES[@]} ${ARRAY_MAGENTA_PANES[@]})

#echo ${ARRAY_ALL_PANES[@]} #printing all elements in this Array

ARRAY_CYAN_NAMES=('mps_c_bs' 'mps_c_ds' 'mps_c_cs1' 'mps_c_cs2' 'mps_c_rs1' 'mps_c_rs2')
ARRAY_MAGENTA_NAMES=('mps_m_bs' 'mps_m_ds' 'mps_m_cs1' 'mps_m_cs2' 'mps_m_rs1' 'mps_m_rs2')
ARRAY_ALL_NAMES=(${ARRAY_CYAN_NAMES[@]} ${ARRAY_MAGENTA_NAMES[@]})

#Parsing 

while [[ $# -gt 1 ]]
do
	key="$1"

	case $key in
		-a|--all)
			ALL='true'
			ALL_COMMAND="$2"
			;;
		-m|--mps)
			MPS="$2"
			MPS_COMMAND="$3"
			shift # past argument
			shift
			;;
		-c|--color)
			COLOR="$2"
			COLOR_COMMAND="$3"
			shift # past argument
			shift # past argument
			;;
		-h|--help)
			HILFE='true'
			echo HELP
			;;
		*)
			# unknown option
			;;
	esac
	shift # past argument or value
done


case $ALL in
	true)
		
		printf "\nThe following command will be send to all MPS.\n" 
		printf "\e[35m --- Command: \"${COLOR_COMMAND}\"\e[37m\n\n"
		for i in `seq 0 11`
		do
			tmux send-keys -t "${ARRAY_ALL_PANES[$i]}" "${COLOR_COMMAND//:mps:/${ARRAY_ALL_NAMES[$i]}}" Enter	
		done
esac

case $MPS in
	mps-c*)
		printf "\nThe following command will be send to the MPS: ${MPS}\n"
		printf "\e[36m --- Command: ${MPS_COMMAND}\e[37m\n\n"
		eval $MPS_COMMAND
		for i in ${ARRAY_CYAN_PANES[@]}
		do
			tmux send-keys -t "$i" "${MPS_COMMAND//:mps:/$MPS}" Enter	
		done
	;;
	mps-m*)
		printf "\nThe following command will be send to the MPS: ${MPS}\n"
		printf "\e[35m --- Command: ${MPS_COMMAND}\e[37m\n\n"
		for i in ${ARRAY_CYAN_PANES[@]}
		do
			tmux send-keys -t "$i" "${MPS_COMMAND//:mps:/$MPS}" Enter	
		done
	;;
		 
esac

case $COLOR in
	c|cyan|C|Cyan|CYAN)
		printf "\nThe following command will be send to all MPS of team CYAN:\n"
		printf "\e[36m --- Command: \"${COLOR_COMMAND}\"\e[37m\n\n"
		for i in `seq 0 5`
		do
			tmux send-keys -t "${ARRAY_CYAN_PANES[$i]}" "${COLOR_COMMAND//:mps:/${ARRAY_CYAN_NAMES[$i]}}" Enter	
		done
	;;
	m|magenta|M|Magenta|MAGENTA)
		printf "\nThe following command will be send to all MPS of team MAGENTA:\n" 
		printf "\e[35m --- Command: \"${COLOR_COMMAND}\"\e[37m\n\n"
		for i in `seq 0 5`
		do
			tmux send-keys -t "${ARRAY_MAGENTA_PANES[$i]}" "${COLOR_COMMAND//:mps:/${ARRAY_MAGENTA_NAMES[$i]}}" Enter	
		done
	;;
esac
