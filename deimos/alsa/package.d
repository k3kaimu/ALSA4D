/**
 * \file include/asoundlib.h
 * \brief Application interface library for the ALSA driver
 * \author Jaroslav Kysela <perex@perex.cz>
 * \author Abramo Bagnara <abramo@alsa-project.org>
 * \author Takashi Iwai <tiwai@suse.de>
 * \date 1998-2001
 *
 * Application interface library for the ALSA driver
 */
/*
 *   This library is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Lesser General Public License as
 *   published by the Free Software Foundation; either version 2.1 of
 *   the License, or (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Lesser General Public License for more details.
 *
 *   You should have received a copy of the GNU Lesser General Public
 *   License along with this library; if not, write to the Free Software
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 *
 */

module deimos.alsa;

//#include <unistd.h>
//#include <stdio.h>
//#include <stdlib.h>
//#include <sys/types.h>
//#include <string.h>
//#include <fcntl.h>
//#include <assert.h>
//#include <endian.h>
//#include <sys/poll.h>
//#include <errno.h>
//#include <stdarg.h>

public import deimos.alsa.asoundef,
              deimos.alsa.conf,
              deimos.alsa.control,
              deimos.alsa.error,
              deimos.alsa.global,
              deimos.alsa.input,
              deimos.alsa.mixer,
              deimos.alsa.output,
              deimos.alsa.pcm,
              deimos.alsa.rawmidi,
              deimos.alsa.timer,
              deimos.alsa.version_;


version(linux)
{
  public import core.sys.posix.poll,
                core.sys.posix.sys.types;
}
else  // for compile test
{
  struct pollfd;
  struct pid_t{};
}

template isVersion(string s)
{
    import std.string;
    mixin(q{version(%s) enum isVersion = true; else enum isVersion = false; }.format(s));
}
