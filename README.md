# dejavuln-autoroot

This is a tool to root LG TVs and automatically install
[Homebrew Channel](https://github.com/webosbrew/webos-homebrew-channel).
It uses [DejaVuln](https://twitter.com/jcxdev/status/1781668313958945132),
which works on webOS 3.5 and newer. This exploit will not work on TVs from
2016 or earlier. 2024 models have been patched from the start, and recent
firmware for most webOS 5+ TVs is also patched.

> [!NOTE]
> Use [CanI.RootMy.TV](https://cani.rootmy.tv/) to determine whether your
> firmware is vulnerable.

## Patch status

> [!WARNING]
> Many models are patched. Do not update your
> firmware if you want to be able to root your TV.
>
> Even if you are running patched firmware, **avoid updating**
> it if you want to be able to root your TV in the future.

The latest firmware for most webOS 5+ OTAIDs is patched.

I expect almost all webOS 4.5+ OTAIDs to be patched. However, webOS 3.5
will almost certainly never receive patched firmware, and 4.0 probably
won't either.

All release versions of webOS 9 ("webOS 24") are patched. This means 
2024 models and older TVs that have been upgraded to webOS 9 are not
currently rootable. (But they will be, at some point...)

**If you want to donate any TV boards for development, please contact me on the
[OpenLGTV Discord](https://discord.gg/hXMHAgJC5R).**

## Instructions

1. Download the latest release (*not* the files named "Source code") from the
   [Releases](https://github.com/throwaway96/dejavuln-autoroot/releases)
   page.
2. Extract the archive to the root directory of a USB drive. (It should be
   formatted with FAT32 or NTFS and only have one partition.)
3. Plug the USB drive into your TV. (Make sure it's the only USB drive
   connected.)
4. Open the USB drive in the Music (or Media Player) app and browse to
   `lol$(sh$IFS$(find$IFS/tmp`.
5. Try to play the MP3 file
   (`usb$IFS-maxdepth${IFS}3$IFS-name${IFS}autoroot.sh)).mp3`). You should
   expect to see an error message about being unable to play the MP3 whether
   or not the exploit works.
6. After the pop-up messages tell you rooting is complete, eject the USB
   drive.

If you have the LG Developer Mode app installed, you *must* remove it before
rebooting. **Do not** install it while your TV is rooted.

## Settings

You can influence the behavior of the script by creating certain files in the
root directory of the USB drive:

* `autoroot.debug` - Enables additional logging.
* `autoroot.telnet` - Makes a root shell available via telnet on port 23 when
  the script starts.
* `autoroot.leave-script` - Don't rename invalid `start-devmode.sh`.
  (You almost certainly won't need this, but it's documented here for the sake
  of completeness.)

## Troubleshooting

If the script fails, you must delete `autoroot.once` from the USB drive and/or
reboot the TV before it will run again.

A log file named `autoroot.log` should be created on the USB drive.

On webOS 8 (webOS 23), you may have to try multiple times; it seems that
restarting `appinstalld` does not reliably make it detect the existence of
`devmode_enabled`. May also apply to webOS 7.

Toasts from the script may be hidden by system messages (like the one about
the MP3 file not being recognized).

If the toast and/or log says "Rooting complete" but you don't see Homebrew
Channel, reboot the TV. Make sure Quick Start+ is disabled.

Make sure the archive is extracted such that `autoroot.sh` is in the root
directory of the USB drive.

## Support

You can find more information at [webosbrew.org](https://www.webosbrew.org/).

If you need help rooting your TV, try the
[OpenLGTV Discord](https://discord.gg/hXMHAgJC5R). Before you ask a question,
check the FAQ (#faq) to see if it is answered there! Attach your `autoroot.log`
when asking for help.

## Credits

* DejaVuln was discovered by [Jacob Clayden](https://jacobcx.dev/).
* The very similar CVE-2023-6319 was discovered by
  [Bitdefender](https://www.bitdefender.com/blog/labs/vulnerabilities-identified-in-lg-webos/).

## License

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU Affero General Public License as published by the Free
Software Foundation, either version 3 of the License, or (at your option) any
later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along
with this program. If not, see <https://www.gnu.org/licenses/>.

See `COPYING` for details.
