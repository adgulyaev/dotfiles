#!/usr/bin/env bash
# Usage: disk-check.sh /dev/sdX
# Triage helper for drives with mounting or bad sector issues (NTFS-focused).
set -euo pipefail

DEV="${1:?Usage: disk-check.sh /dev/sdX}"

echo "=== SMART Health ==="
sudo smartctl -H "$DEV"

echo ""
echo "=== Pending / Uncorrectable Sectors ==="
sudo smartctl -A "$DEV" | grep -E 'Reallocated|Pending|Uncorrectable'

echo ""
echo "=== Partition Table ==="
sudo fdisk -l "$DEV"

echo ""
echo "=== Filesystem ==="
sudo blkid "${DEV}"* 2>/dev/null || true

echo ""
echo "=== Kernel I/O Errors (last 10) ==="
dmesg | grep -iE "error|reset" | grep "$(basename "$DEV")" | tail -10 || echo "(none)"

echo ""
echo "--- Repair options ---"
echo "Bad sectors detected? Image the drive FIRST (never repair directly):"
echo "  Pass 1 (fast, skip bad sectors):"
echo "    sudo ddrescue -d -r0 -T 30s $DEV /backup/drive.img /backup/drive.map"
echo "  Pass 2 (retry bad sectors):"
echo "    sudo ddrescue -d -r3      $DEV /backup/drive.img /backup/drive.map"
echo ""
echo "Then work on the image (original drive untouched):"
echo "  Partition table repair: sudo testdisk /backup/drive.img"
echo "  NTFS fix:               sudo ntfsfix /backup/drive.img"
echo "  File carving (last resort): sudo photorec /backup/drive.img"
echo ""
echo "Mount image (find start sector with: sudo fdisk -l /backup/drive.img):"
echo "  sudo mount -t ntfs-3g -o loop,offset=\$((START * 512)),ro \\"
echo "    /backup/drive.img /mnt/recovered"
