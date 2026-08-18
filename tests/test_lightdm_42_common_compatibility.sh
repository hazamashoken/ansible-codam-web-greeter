#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
fragment="$root/templates/etc/lightdm/lightdm.conf.d/99-codam-web-greeter.conf.j2"

test -f "$fragment"
grep -Fx '[Seat:*]' "$fragment"
grep -Fx 'greeter-session=nody-greeter' "$fragment"
grep -Fx 'greeter-setup-script=/usr/share/42/scripts/hook-greeter-setup.sh' "$fragment"
! grep -R -F 'path: /etc/lightdm/lightdm.conf' "$root/tasks"
grep -Fq 'brightness-default.sh' "$root/templates/usr/share/42/scripts/hook-greeter-setup.sh.j2"
grep -Fq 'path: /etc/polkit-1/localauthority/50-local.d/10-org.freedesktop.login1.pkla' "$root/tasks/setup.yml"
