#/bin/bash

RTSPIN="/root/liblitmus/rtspin"
BASE_TASK="/root/liblitmus/mytools/myapp"
RELEASETS="/root/liblitmus/release_ts"
ST_TRACE="/root/ft_tools/st_trace"
ft_cat="/root/ft_tools/ftcat"
RTLAUNCH="/root/liblitmus/rt_launch"
SPIN_PIDS=""
#RAW_DATA="/root/task_sets_raw/"
RAW_DATA="/root/task_sets_raw/"
NEW_DATA="/root/experiment-scripts/task_sets_icloud_granular"
#NEW_DATA="/root/experiment-scripts/task_sets_VaryUtil/"
#NEW_DATA="/root/experiment-scripts/task_sets_VaryUtil/"
#PDist="uni-long"
#PDist="uni-moderate"
#PDist="uni-short"
PROG=$1
Dist=$2
Duration=$3
PDist=$4
declare -a NEW_SPIN_PIDS

#Util=`echo $Dist | cut -d'_' -f 2`
#Rep=`echo $Dist | cut -d'_' -f 3`
#SchedNames="GSN-EDF
#C-EDF"
SchedNames="GSN-EDF"

for sched in $SchedNames
do
  for util in 1 2 3 4
  #for util in 8.5
  #for util in 3.0 4.0 5.0 6.0 7.0 8.0 8.2
#  for util in 2.2 2.6 3.2 3.6 4.2 4.6 5.2 5.6 6.2 6.6 7 7.2
#  for util in 3.2 3.6 4.2 4.6 5.2 5.6 6.2 6.6 7.2 7.6 8
#  for util in 3.2 3.4 3.6 3.8 4.2 4.4 4.6 4.8 5.2 5.4 5.6 5.8 6.2 6.4 6.6 6.8 7.2 7.4 7.6 7.8 8 8.2 8.4
#  for util in 9.0 10.0 11.0 12.0
#   for util in 8.2 8.4 8.6 8.8
#  for util in 0.2 0.4 0.6 0.8 1.2 1.4 1.6 1.8 2.2 2.4 2.6 2.8 3.2 3.4 3.6 3.8 4.2 4.4 4.6 4.8 5.2 5.4 5.6 5.8 6.2 6.4 6.6 6.8 7.2 7.4 7.6 7.8 8
 # for util in 0.2 0.4 0.6 0.8 1 1.2 1.4 1.6 1.8 2 2.2 2.4 2.6 2.8 3 3.2 3.4 3.6 3.8 4 4.2 4.4 4.6 4.8 5 5.2 5.4 5.6 5.8 6 6.2 6.4 6.6 6.8 7 7.2 7.4 7.6 7.8 8 8.2 8.4
  #for util in 7 8
  do
    #for rep in 0 1
    for rep in 0 1 2
    do

echo "Starting ohm"
#${ST_TRACE} -s mk &
ftcat /dev/litmus/ft_cpu_trace0 SCHED_START SCHED_END > ohm_cpu0 &
ST_TRACE0_PID="$!"
echo "ftcat_cpu0 pid: ${ST_TRACE0_PID}"

ftcat /dev/litmus/ft_cpu_trace1 SCHED_START SCHED_END > ohm_cpu1 &
ST_TRACE1_PID="$!"
echo "ftcat_cpu1 pid: ${ST_TRACE1_PID}"

ftcat /dev/litmus/ft_cpu_trace2 SCHED_START SCHED_END > ohm_cpu2 &
ST_TRACE2_PID="$!"
echo "ftcat_cpu2 pid: ${ST_TRACE2_PID}"

ftcat /dev/litmus/ft_cpu_trace3 SCHED_START SCHED_END > ohm_cpu3 &
ST_TRACE3_PID="$!"
echo "ftcat_cpu3 pid: ${ST_TRACE3_PID}"

ftcat /dev/litmus/ft_cpu_trace4 SCHED_START SCHED_END > ohm_cpu4 &
ST_TRACE4_PID="$!"
echo "ftcat_cpu4 pid: ${ST_TRACE4_PID}"

ftcat /dev/litmus/ft_cpu_trace5 SCHED_START SCHED_END > ohm_cpu5 &
ST_TRACE5_PID="$!"
echo "ftcat_cpu5 pid: ${ST_TRACE5_PID}"

ftcat /dev/litmus/ft_cpu_trace6 SCHED_START SCHED_END > ohm_cpu6 &
ST_TRACE6_PID="$!"
echo "ftcat_cpu6 pid: ${ST_TRACE6_PID}"

ftcat /dev/litmus/ft_cpu_trace7 SCHED_START SCHED_END > ohm_cpu7 &
ST_TRACE7_PID="$!"
echo "ftcat_cpu7 pid: ${ST_TRACE7_PID}"

#ftcat /dev/litmus/ft_cpu_trace0 CXS_START CXS_END SCHED_START SCHED_END > ohm_cpu0 &
#ST_TRACE0_PID="$!"
#echo "ftcat_cpu0 pid: ${ST_TRACE0_PID}"

#ftcat /dev/litmus/ft_cpu_trace1 CXS_START CXS_END SCHED_START SCHED_END > ohm_cpu1 &
#ST_TRACE1_PID="$!"
#echo "ftcat_cpu1 pid: ${ST_TRACE1_PID}"

#ftcat /dev/litmus/ft_cpu_trace2 CXS_START CXS_END SCHED_START SCHED_END > ohm_cpu2 &
#ST_TRACE2_PID="$!"
#echo "ftcat_cpu2 pid: ${ST_TRACE2_PID}"

#ftcat /dev/litmus/ft_cpu_trace3 CXS_START CXS_END SCHED_START SCHED_END > ohm_cpu3 &
#ST_TRACE3_PID="$!"
#echo "ftcat_cpu3 pid: ${ST_TRACE3_PID}"

#ftcat /dev/litmus/ft_cpu_trace4 CXS_START CXS_END SCHED_START SCHED_END > ohm_cpu4 &
#ST_TRACE4_PID="$!"
#echo "ftcat_cpu4 pid: ${ST_TRACE4_PID}"

#ftcat /dev/litmus/ft_cpu_trace5 CXS_START CXS_END SCHED_START SCHED_END > ohm_cpu5 &
#ST_TRACE5_PID="$!"
#echo "ftcat_cpu5 pid: ${ST_TRACE5_PID}"

#ftcat /dev/litmus/ft_cpu_trace6 CXS_START CXS_END SCHED_START SCHED_END > ohm_cpu6 &
#ST_TRACE6_PID="$!"
#echo "ftcat_cpu6 pid: ${ST_TRACE6_PID}"

#ftcat /dev/litmus/ft_cpu_trace7 CXS_START CXS_END SCHED_START SCHED_END > ohm_cpu7 &
#ST_TRACE7_PID="$!"
#echo "ftcat_cpu7 pid: ${ST_TRACE7_PID}"

sleep 1

echo "Switching to $sched plugin"
echo "$sched" > /proc/litmus/active_plugin
sleep 1

#read wcet and period from the dist file
filename="$NEW_DATA""/""$Dist""_""$PDist""_""$util""_""$rep"
data=$(cat $filename)
num_tasks=$(cat $filename | wc -l)
#echo $data
#echo $num_tasks
c=0
n=0
for task in ${data[@]};
do
  let "rem= $c % 2"
  if [ "$rem" -eq 0 ]
  then
    #wcet[$n]=$task
    wcet[$n]=$(echo "scale=3; $task * 0.001" | bc)
  else
    #period[$n]=$task
    period[$n]=$(echo "scale=3; $task * 0.001" | bc)
    n=`expr $n + 1`
  fi
  c=`expr $c + 1`
done

echo "Setting up rtspin processes $Dist $util $rep"
for nt in `seq 1 $num_tasks`;
do
  #$PROG ${wcet[`expr $nt - 1`]} ${period[`expr $nt - 1`]} $Duration -w &
  $BASE_TASK ${wcet[`expr $nt - 1`]} ${period[`expr $nt - 1`]} $Duration &
  #$RTSPIN ${wcet[`expr $nt - 1`]} ${period[`expr $nt - 1`]} $Duration &
  #numactl --physcpubind=8-15 --membind=0 --cpunodebind=0 $PROG ${wcet[`expr $nt - 1`]} ${period[`expr $nt - 1`]} $Duration -w &
  #numactl --physcpubind=8-15 $PROG ${wcet[`expr $nt - 1`]} ${period[`expr $nt - 1`]} $Duration -w &
  SPIN_PIDS="$SPIN_PIDS $!"
  NEW_SPIN_PIDS[`expr $nt - 1`]="$!"
done
sleep 1

#echo "catting log"
#cat /dev/litmus/log > log.txt &
#LOG_PID="$!"
#sleep 1
echo "Doing release..."
$RELEASETS

echo "Waiting for rtspin processes..."
#wait ${SPIN_PIDS}

for i in "${NEW_SPIN_PIDS[@]}"
do
  wait $i
done
unset NEW_SPIN_PIDS

echo "Done wait, sleeping"
sleep 1
echo "Killing log"
kill ${LOG_PID}
sleep 1
echo "Sending SIGUSR1 to ohm_trace"
kill -USR1 ${ST_TRACE0_PID}
kill -USR1 ${ST_TRACE1_PID}
kill -USR1 ${ST_TRACE2_PID}
kill -USR1 ${ST_TRACE3_PID}
kill -USR1 ${ST_TRACE4_PID}
kill -USR1 ${ST_TRACE5_PID}
kill -USR1 ${ST_TRACE6_PID}
kill -USR1 ${ST_TRACE7_PID}
echo "Waiting for ohm_trace..."
wait ${ST_TRACE0_PID}
wait ${ST_TRACE1_PID}
wait ${ST_TRACE2_PID}
wait ${ST_TRACE3_PID}
wait ${ST_TRACE4_PID}
wait ${ST_TRACE5_PID}
wait ${ST_TRACE6_PID}
wait ${ST_TRACE7_PID}
sleep 1

mkdir -p run-data-fig2/"$PROG"/
mkdir run-data-fig2/"$PROG"/"$Dist""_""$PDist""_""$util""_""$rep"/
#cat ohm_cpu0 ohm_cpu1 ohm_cpu2 ohm_cpu3 > all_events
cat ohm_cpu0 ohm_cpu1 ohm_cpu2 ohm_cpu3 ohm_cpu4 ohm_cpu5 ohm_cpu6 ohm_cpu7> all_events
#ft2csv CXS_START all_events > cxs_out
ft2csv SCHED_START all_events > sched_out
#mv cxs_out run-data-fig2/"$PROG"/"$Dist""_""$PDist""_""$util""_""$rep"/
mv sched_out run-data-fig2/"$PROG"/"$Dist""_""$PDist""_""$util""_""$rep"/
rm ohm_cpu0
rm ohm_cpu1
rm ohm_cpu2
rm ohm_cpu3
rm ohm_cpu4
rm ohm_cpu5
rm ohm_cpu6
rm ohm_cpu7
rm all_events


#mv /dev/shm/*.bin run-data-fig2/"$PROG"/"$Dist""_""$PDist""_""$util""_""$rep"/
#mv /dev/shm/*.bin run-data-fig2/"$PROG"/"$Dist""_""$PDist""_""$util""_""$rep"/
#mv log.txt run-data/"$sched"_$rep/
sleep 1
echo "Done! Collect your logs."

    done
  done
done
echo "DONE!"

