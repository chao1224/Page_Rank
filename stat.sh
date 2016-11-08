echo "@ " $1
echo "======"
echo "Start"
pdsh -R exec -f 3 -w ^machines ssh -o ConnectTimeout=5 %h '(cat /proc/net/dev)' > tmpnet
pdsh -R exec -f 3 -w ^machines ssh -o ConnectTimeout=5 %h '(cat /proc/diskstats)' > tmpdisk
echo "------------"
echo "# VM1"
echo "## Network"
cat tmpnet | grep vm-22-1 | cut -d: -f2- | tail -2
echo "## Disk"
cat tmpdisk | grep vm-22-1 | cut -d: -f2- | tail -2
echo "# VM2"
echo "## Network"
cat tmpnet | grep vm-22-2 | cut -d: -f2- | tail -2
echo "## Disk"
cat tmpdisk | grep vm-22-2 | cut -d: -f2- | tail -2
echo "# VM3"
echo "## Network"
cat tmpnet | grep vm-22-3 | cut -d: -f2- | tail -2
echo "## Disk"
cat tmpdisk | grep vm-22-3 | cut -d: -f2- | tail -2
echo "# VM4"
echo "## Network"
cat tmpnet | grep vm-22-4 | cut -d: -f2- | tail -2
echo "## Disk"
cat tmpdisk | grep vm-22-4 | cut -d: -f2- | tail -2
echo "# VM5"
echo "## Network"
cat tmpnet | grep vm-22-5 | cut -d: -f2- | tail -2
echo "## Disk"
cat tmpdisk | grep vm-22-5 | cut -d: -f2- | tail -2
{
pdsh -R exec -f 3 -w ^machines ssh -o ConnectTimeout=5 %h '(sudo sh -c "sync; echo 3 > /proc/sys/vm/drop_caches")'
spark-submit --class "SparkPageRankWithCustomPartitionerWithCache" --properties-file=spark.conf target/scala-2.11/parta_2.11-1.0.jar web-BerkStan.txt 10
} >sparkres 2>&1 
echo "End"
echo "------------"
pdsh -R exec -f 3 -w ^machines ssh -o ConnectTimeout=5 %h '(cat /proc/net/dev)' > tmpnet
pdsh -R exec -f 3 -w ^machines ssh -o ConnectTimeout=5 %h '(cat /proc/diskstats)' > tmpdisk
echo "# VM1"
echo "## Network"
cat tmpnet | grep vm-22-1 | cut -d: -f2- | tail -2
echo "## Disk"
cat tmpdisk | grep vm-22-1 | cut -d: -f2- | tail -2
echo "# VM2"
echo "## Network"
cat tmpnet | grep vm-22-2 | cut -d: -f2- | tail -2
echo "## Disk"
cat tmpdisk | grep vm-22-2 | cut -d: -f2- | tail -2
echo "# VM3"
echo "## Network"
cat tmpnet | grep vm-22-3 | cut -d: -f2- | tail -2
echo "## Disk"
cat tmpdisk | grep vm-22-3 | cut -d: -f2- | tail -2
echo "# VM4"
echo "## Network"
cat tmpnet | grep vm-22-4 | cut -d: -f2- | tail -2
echo "## Disk"
cat tmpdisk | grep vm-22-4 | cut -d: -f2- | tail -2
echo "# VM5"
echo "## Network"
cat tmpnet | grep vm-22-5 | cut -d: -f2- | tail -2
echo "## Disk"
cat tmpdisk | grep vm-22-5 | cut -d: -f2- | tail -2

