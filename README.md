# dejavuln-autoroot

This is a tool to root LG TVs and automatically install
[Homebrew Channel](https://github.com/webosbrew/webos-homebrew-channel).
It uses [DejaVuln](https://twitter.com/jcxdev/status/1781668313958945132),
which works on webOS 3.5 and newer.

## Instructions

1. Extract the archive to the root directory of a USB drive. (It should be
   formatted with FAT32 or NTFS.)
2. Plug the USB drive into your TV. (Make sure it's the only USB drive
   connected.)
3. Open the USB drive in the Music app and browse to
   `lol$(sh$IFS\tmp\usb\sda\sda1`.
4. Try to play `autoroot.sh).mp3`.
5. After the pop-up messages tell you rooting is complete, eject the USB
   drive.

If you have the LG Developer Mode app installed, you *must* remove it before
rebooting. **Do not** install it while your TV is rooted.

## Troubleshooting

If the script fails, you must delete `autoroot.once` from the USB drive before
it will run again.

A log file named `autoroot.log` should be created on the USB drive.

You can enable additional logging by creating a file named `autoroot.debug` in
the root directory of the USB drive.

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
