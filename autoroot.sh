#!/bin/sh

# dejavuln-autoroot
# by throwaway96
# https://github.com/throwaway96/dejavuln-autoroot
# Copyright 2024. Licensed under AGPL v3 or later. No warranties.

# Thanks to:
# - Jacob Clayden (https://jacobcx.dev/) for discovering DejaVuln
# - Bitdefender for their writeup of CVE-2023-6319
#   (https://www.bitdefender.com/blog/labs/vulnerabilities-identified-in-lg-webos/)
# - LG for being incompetent

set -e

DEBUG="${DEBUG:-}"
IPK_SRC="${IPK_SRC:-/tmp/usb/sda/sda1/hbchannel-0.6.3.ipk}"

toast() {
    [ -n "${logfile}" ] && debug "toasting: '${1}'"

    title='autoroot (DejaVuln)'
    escape1="${1//\\/\\\\}"
    escape="${escape1//\"/\\\"}"
    payload="$(printf '{"sourceId":"com.webos.whatever","message":"<h3>%s</h3>%s"}' "${title}" "${escape}")"
    luna-send -w 1000 -n 1 'luna://com.webos.notification/createToast' "${payload}" >/dev/null
}

debug() {
    [ -z "${DEBUG}" ] && return

    msg="[d] ${1}"
    echo "${msg}"
    echo "${msg}" >>"${logfile}"
}

log() {
    msg="[ ] ${1}"
    echo "${msg}"
    echo "${msg}" >>"${logfile}"
}

error() {
    msg="[!] ${1}"
    echo "${msg}"
    echo "${msg}" >>"${logfile}"
    toast "<b>Error:</b> ${1}"
}

get_sdkversion() {
    luna-send -w 1000 -n 1 -q 'sdkVersion' -f 'luna://com.webos.service.tv.systemproperty/getSystemInfo' '{"keys":["sdkVersion"]}' | sed -n -e 's/^\s*"sdkVersion":\s*"\([0-9.]\+\)"\s*$/\1/p'
}

toast 'Script is running!'

umask 022

if ! tempdir="$(mktemp -d)"; then
    echo '[x] Failed to create random temporary directory; using fallback'
    tempdir="/tmp/autoroot.${$}"
    if ! mkdir -- "${tempdir}"; then
        echo "[!] Fallback temporary directory ${tempdir} already exists"
        toast "Fallback temporary directory ${tempdir} already exists"
        exit 1
    fi
fi

logfile="${tempdir}/log"

loglink='/tmp/autoroot.log'
rm -rf -- "${loglink}"
ln -s -- "${logfile}" "${loglink}"

log 'hi'

debug "temp dir: ${tempdir}"

log "date: $(date -u -- '+%Y-%m-%d %H:%M:%S UTC')"
log "id: $(id)"

webos_ver="$(get_sdkversion)"

log "webOS version: ${webos_ver}"

if [ -d '/var/luna/preferences/devmode_enabled' ]; then
    log 'devmode_enabled is already a directory; is your TV already rooted?'
else
    if [ -e '/var/luna/preferences/devmode_enabled' ]; then
        log 'devmode_enabled exists; make sure the LG Dev Mode app is not installed!'
        toast "Make sure the LG Dev Mode app isn't installed!"

    rm -f -- '/var/luna/preferences/devmode_enabled'
    else
        debug 'devmode_enabled does not exist'
    fi

    if ! mkdir -- '/var/luna/preferences/devmode_enabled'; then
        error 'Failed to create devmode_enabled directory'
        exit 1
    fi
fi

if restart appinstalld >/dev/null; then
    debug 'appinstalld restarted'
else
    log 'Failed to restart appinstalld'
fi

ipkpath="${tempdir}/hbchannel.ipk"

cp -- "${IPK_SRC}" "${ipkpath}"

instpayload="$(printf '{"id":"com.ares.defaultName","ipkUrl":"%s","subscribe":true}' "${ipkpath}")"

fifopath="${tempdir}/fifo"

mkfifo -- "${fifopath}"

log "Installing ${ipkpath}..."
toast 'Installing...'

luna-send -w 20000 -i 'luna://com.webos.appInstallService/dev/install' "${instpayload}" >"${fifopath}" &
luna_pid="${!}"

if ! result="$(fgrep -m 1 -e 'installed' -e 'failed' -e 'Unknown method' -- "${fifopath}")"; then
    rm -f -- "${fifopath}"
    error 'Install timed out'
    exit 1
fi

kill -TERM "${luna_pid}" 2>/dev/null || true
rm -f -- "${fifopath}"

case "${result}" in
    *installed*) ;;
    *"Unknown method"*)
        error 'Installation failed (devmode_enabled not recognized)'
        exit 1
    ;;
    *failed*)
        error 'Installation failed'
        exit 1
    ;;
    *)
        error 'Installation failed for unknown reason'
        exit 1
    ;;
esac

if ! /media/developer/apps/usr/palm/services/org.webosbrew.hbchannel.service/elevate-service >"${tempdir}/elevate.log"; then
    error 'Elevation failed'
    exit 1
fi

log 'Rooting complete'
toast 'Rooting complete. <h4>Do not install the LG Dev Mode app while rooted!</h4>'
