#!/bin/bash
set -e

RELEASEPATH="$HOME/Downloads/"

SD_DISK=$(mount | grep msdos | awk {'print $1'})
DISK_NO=$(echo $SD_DISK | awk '{print substr($0,length-2,1)}')
RDISK_BASE="/dev/rdisk"
RDISK=$RDISK_BASE$DISK_NO

clear

# Make sure we're root
if [ "$(whoami)" != 'root' ]; then
  echo "This script must run as root"
  exit 1;
fi

if [ -z "$1" ]; then
  echo "No parameter passed. Exiting."
fi

# Validate all strings
for i in "$RELEASEPATH" "$SD_DISK" "$DISK_NO"; do
  if [ -z "$i" ]; then
    echo "Found empty string base string. Aborting"
    exit 1
  fi
done

echo -e "Printing mounted disks:\n"
mount

echo -e "\n\nIs $SD_DISK ($RDISK) your SD card? (Y/N)"
read CONFIRM

if [[ "$CONFIRM" == "Y" ]]; then

  echo "Unmounting $SD_DISK ..."
  diskutil unmount $SD_DISK

  cd "$RELEASEPATH"
  LATEST_VERSION="$(ls -t *$1* | head -n 1)"

  echo "Flashing out $LATEST_VERSION to $RDISK"
  set -x
  if [[ "$LATEST_VERSION" == *zip  ]]; then
    unzip -p "$RELEASEPATH/$LATEST_VERSION" | dd bs=1m of=$RDISK
  elif [[ "$LATEST_VERSION" == *gz  ]]; then
    gzip -d -c "$RELEASEPATH/$LATEST_VERSION" | dd bs=1m of=$RDISK
  elif [[ "$LATEST_VERSION" == *img  ]]; then
    dd if="$RELEASEPATH/$LATEST_VERSION" bs=1m of=$RDISK
  fi

  diskutil eject $SD_DISK
  echo "Done."

else
  echo "Aborting."
  exit 1
fi
