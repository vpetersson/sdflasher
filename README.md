# sdflasher
A simple script that simplifies flashing of SD cards from disk images on MacOS.

## Usage

The script will look for files in `~/Downloads`.

For instance, to flash out the image `2016-02-26-raspbian-jessie-lite.zip`, simply run:


```
$ ./sdflasher.sh 2016-02-26-raspbian-jessie-lite.zip
Printing mounted disks:

/dev/disk1 on / (hfs, local, journaled)
devfs on /dev (devfs, local, nobrowse)
map -hosts on /net (autofs, nosuid, automounted, nobrowse)
map auto_home on /home (autofs, automounted, nobrowse)
/dev/disk2s1 on /Volumes/boot (msdos, local, nodev, nosuid, noowners)


Is /dev/disk2s1 (/dev/rdisk2) your SD card? (Y/N)
Y
Unmounting /dev/disk2s1 ...
Volume boot on disk2s1 unmounted
Flashing out 2016-02-26-raspbian-jessie-lite.zip to /dev/rdisk2
+ [[ 2016-02-26-raspbian-jessie-lite.zip == *zip  ]]
+ unzip -p /Users/mvip/Downloads//2016-02-26-raspbian-jessie-lite.zip
+ dd bs=1m of=/dev/rdisk2
0+20768 records in
0+20768 records out
1361051648 bytes transferred in 125.996167 secs (10802326 bytes/sec)
+ diskutil eject /dev/disk2s1
Disk /dev/disk2s1 ejected
Done.
```
