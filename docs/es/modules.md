# Modulos de archforge

## Lista completa

| ID | Nombre | Descripcion | Fuente wiki | Paquetes |
|---|---|---|---|---|
| pacman | Package: Pacman | Configurar pacman.conf, habilitar multilib, reflector | [Pacman](https://wiki.archlinux.org/title/Pacman) [Pacman/Tips and tricks](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks) | pacman-contrib reflector |
| aur-helper | Package Management: AUR helper | Detectar o instalar un AUR helper (yay/paru) | [Recomendaciones generales](https://wiki.archlinux.org/title/General_recommendations) | base-devel git |
| systemd | System Services: systemd | Tamano de journal, timeout de apagado, timesyncd | [Systemd](https://wiki.archlinux.org/title/Systemd) | — |
| users-groups | System: Users and Groups | Agregar usuario a grupos habituales (wheel, audio, video, storage, etc.) | [Usuarios y grupos](https://wiki.archlinux.org/title/Users_and_groups) | — |
| dns | Security: DNS | Proveedor DNS con deteccion de 4 casos (6 proveedores) | [Resolucion de nombres de dominio](https://wiki.archlinux.org/title/Domain_name_resolution) [DNSSEC](https://wiki.archlinux.org/title/DNSSEC) | — |
| firewall | Security: Firewall | Perfiles nftables (desktop/server/strict) | [Nftables](https://wiki.archlinux.org/title/Nftables) [Iptables](https://wiki.archlinux.org/title/Iptables) | nftables |
| antivirus | Security: Antivirus | ClamAV con freshclam y timer de escaneo opcional | [Seguridad](https://wiki.archlinux.org/title/Security) | clamav |
| network | Networking: Network | Hostname, /etc/hosts, NetworkManager | [Configuracion de red](https://wiki.archlinux.org/title/Network_configuration) | — |
| tlp | Power: TLP | Optimizacion de bateria para laptops | [TLP](https://wiki.archlinux.org/title/TLP) [Laptop](https://wiki.archlinux.org/title/Laptop) [Laptop/HP](https://wiki.archlinux.org/title/Laptop/HP) | tlp |
| acpid | Power: ACPI events | Suspension al cerrar tapa, eventos de boton de encendido | [Gestion de energia](https://wiki.archlinux.org/title/Power_management) | acpid |
| ssd | Optimization: SSD | fstrim, noatime fstab, scheduler de I/O | [Unidad de estado solido](https://wiki.archlinux.org/title/Solid_state_drive) | — |
| performance | Optimization: Performance | swappiness, gobernador de CPU, zram | [Rendimiento](https://wiki.archlinux.org/title/Improving_performance) | zram-generator |
| sensors | Optimization: Sensors | lm_sensors, fancontrol | [Lm sensors](https://wiki.archlinux.org/title/Lm_sensors) [Control de ventiladores](https://wiki.archlinux.org/title/Fan_speed_control) | lm_sensors |
| libinput | Input: libinput | Touchpad, scroll natural, TrackPoint | [Libinput](https://wiki.archlinux.org/title/Libinput) [TrackPoint](https://wiki.archlinux.org/title/TrackPoint) [Botones del raton](https://wiki.archlinux.org/title/Mouse_buttons) | — |
| keyboard | Input: Keyboard | Keymap de consola, layout X11 via localectl | [Xorg/Teclado](https://wiki.archlinux.org/title/Xorg/Keyboard_configuration) [Consola Linux/Teclado](https://wiki.archlinux.org/title/Linux_console/Keyboard_configuration) | — |
| fonts | Console: Fonts | terminus-font, noto-fonts, ttf-liberation | [Fuentes](https://wiki.archlinux.org/title/Fonts) [Consola Linux](https://wiki.archlinux.org/title/Linux_console) [Fuentes metric-compatibles](https://wiki.archlinux.org/title/Metric-compatible_fonts) | terminus-font noto-fonts noto-fonts-emoji ttf-liberation |
| locale | Console: Locale | locale-gen, zona horaria, NTP | [Proceso de arranque de Arch](https://wiki.archlinux.org/title/Arch_boot_process) | — |
| nouveau | Graphics: Nouveau | Driver NVIDIA libre; quitar propietario si aplica | [Nouveau](https://wiki.archlinux.org/title/Nouveau) | mesa xf86-video-nouveau |
| nvidia | Graphics: NVIDIA | Driver NVIDIA propietario u open, KMS, Optimus opcional | [NVIDIA](https://wiki.archlinux.org/title/NVIDIA) [NVIDIA Optimus](https://wiki.archlinux.org/title/NVIDIA_Optimus) [GPU](https://wiki.archlinux.org/title/Graphics_processing_unit) | (paquetes segun eleccion en runtime) |
| steam | Gaming: Steam | Steam, multilib, deps Proton/Wine, GameMode/MangoHud opcional | [Steam](https://wiki.archlinux.org/title/Steam) [Steam/Solucion de problemas](https://wiki.archlinux.org/title/Steam/Troubleshooting) | steam |
| printing | Peripherals: Printing | CUPS, SANE opcional, drivers de impresora | [CUPS](https://wiki.archlinux.org/title/CUPS) [CUPS/Solucion de problemas](https://wiki.archlinux.org/title/CUPS/Troubleshooting) | cups cups-pdf |
| vmware-host | Virtualization: VMware | Host VMware Workstation Pro (AUR) | [VMware](https://wiki.archlinux.org/title/VMware) | vmware-workstation (AUR) |
