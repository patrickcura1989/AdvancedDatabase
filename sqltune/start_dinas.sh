
STREAM_NUM=0
MAX_STREAM=4
PIDLST=""

while [ $STREAM_NUM -lt $MAX_STREAM ]; do

  # one more 
  let STREAM_NUM="STREAM_NUM+1"

  # start one more stream
  sqlplus -S sh/sh @dina.sql &

  # remember PID
  PIDLST="$! $PIDLST"

  echo "Started stream with pid=$!"

done

#
# Save PID List
#
echo $PIDLST > /tmp/dina_pids

