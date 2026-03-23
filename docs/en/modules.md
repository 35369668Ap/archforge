# archforge Modules

## Complete list

| ID | Name | Description | Wiki source | Packages |
|---|---|---|---|---|
| pacman | Package: Pacman | Configure pacman.conf, enable multilib, setup reflector | [Pacman](https://wiki.archlinux.org/title/Pacman) [Pacman/Tips and tricks](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks) | pacman-contrib reflector |
| aur-helper | Package Management: AUR helper | Detect or install an AUR helper (yay/paru) | [General recommendations](https://wiki.archlinux.org/title/General_recommendations) | base-devel git |
| systemd | System Services: systemd | Journal size, shutdown timeout, timesyncd | [Systemd](https://wiki.archlinux.org/title/Systemd) | — |
| users-groups | System: Users and Groups | Add users to common system groups (wheel, audio, video, storage, etc.) | [Users and groups](https://wiki.archlinux.org/title/Users_and_groups) | — |
| dns | Security: DNS | DNS provider with 4-case detection (6 providers) | [Domain name resolution](https://wiki.archlinux.org/title/Domain_name_resolution) [DNSSEC](https://wiki.archlinux.org/title/DNSSEC) | — |
| firewall | Security: Firewall | nftables profiles (desktop/server/strict) | [Nftables](https://wiki.archlinux.org/title/Nftables) [Iptables](https://wiki.archlinux.org/title/Iptables) | nftables |
| antivirus | Security: Antivirus | ClamAV with freshclam and optional scan timer | [Security](https://wiki.archlinux.org/title/Security) | clamav |
| network | Networking: Network | Hostname, /etc/hosts, NetworkManager | [Network configuration](https://wiki.archlinux.org/title/Network_configuration) | — |
| tlp | Power: TLP | Battery optimization for laptops | [TLP](https://wiki.archlinux.org/title/TLP) [Laptop](https://wiki.archlinux.org/title/Laptop) [Laptop/HP](https://wiki.archlinux.org/title/Laptop/HP) | tlp |
| acpid | Power: ACPI events | Lid close suspend, power button events | [Power management](https://wiki.archlinux.org/title/Power_management) | acpid |
| ssd | Optimization: SSD | fstrim, noatime fstab, I/O scheduler | [Solid state drive](https://wiki.archlinux.org/title/Solid_state_drive) | — |
| performance | Optimization: Performance | swappiness, CPU governor, zram | [Improving performance](https://wiki.archlinux.org/title/Improving_performance) | zram-generator |
| sensors | Optimization: Sensors | lm_sensors, fancontrol | [Lm sensors](https://wiki.archlinux.org/title/Lm_sensors) [Fan speed control](https://wiki.archlinux.org/title/Fan_speed_control) | lm_sensors |
| libinput | Input: libinput | Touchpad, natural scroll, TrackPoint | [Libinput](https://wiki.archlinux.org/title/Libinput) [TrackPoint](https://wiki.archlinux.org/title/TrackPoint) [Mouse buttons](https://wiki.archlinux.org/title/Mouse_buttons) | — |
| keyboard | Input: Keyboard | Console keymap, X11 layout via localectl | [Xorg/Keyboard configuration](https://wiki.archlinux.org/title/Xorg/Keyboard_configuration) [Linux console/Keyboard configuration](https://wiki.archlinux.org/title/Linux_console/Keyboard_configuration) | — |
| fonts | Console: Fonts | terminus-font, noto-fonts, ttf-liberation | [Fonts](https://wiki.archlinux.org/title/Fonts) [Linux console](https://wiki.archlinux.org/title/Linux_console) [Metric-compatible fonts](https://wiki.archlinux.org/title/Metric-compatible_fonts) | terminus-font noto-fonts noto-fonts-emoji ttf-liberation |
| locale | Console: Locale | locale-gen, timezone, NTP | [Arch boot process](https://wiki.archlinux.org/title/Arch_boot_process) | — |
| nouveau | Graphics: Nouveau | Open-source NVIDIA driver; remove proprietary if present | [Nouveau](https://wiki.archlinux.org/title/Nouveau) | mesa xf86-video-nouveau |
| nvidia | Graphics: NVIDIA | Proprietary or open NVIDIA driver, KMS, optional Optimus | [NVIDIA](https://wiki.archlinux.org/title/NVIDIA) [NVIDIA Optimus](https://wiki.archlinux.org/title/NVIDIA_Optimus) [GPU](https://wiki.archlinux.org/title/Graphics_processing_unit) | (driver packages selected at runtime) |
| steam | Gaming: Steam | Steam, multilib, Proton/Wine deps, optional GameMode/MangoHud | [Steam](https://wiki.archlinux.org/title/Steam) [Steam/Troubleshooting](https://wiki.archlinux.org/title/Steam/Troubleshooting) | steam |
| printing | Peripherals: Printing | CUPS, optional SANE, printer drivers | [CUPS](https://wiki.archlinux.org/title/CUPS) [CUPS/Troubleshooting](https://wiki.archlinux.org/title/CUPS/Troubleshooting) | cups cups-pdf |
| vmware-host | Virtualization: VMware | VMware Workstation Pro host (AUR) | [VMware](https://wiki.archlinux.org/title/VMware) | vmware-workstation (AUR) |
