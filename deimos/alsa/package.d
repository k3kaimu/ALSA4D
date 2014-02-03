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
              deimos.alsa.hwdep,
              deimos.alsa.input,
              deimos.alsa.mixer,
              deimos.alsa.output,
              deimos.alsa.pcm,
              deimos.alsa.rawmidi,
              deimos.alsa.seq,
              deimos.alsa.seq_event,
              deimos.alsa.seq_midi_event,
              deimos.alsa.seqmid,
              deimos.alsa.timer,
              deimos.alsa.version_;


version(linux)
{
  public import core.sys.posix.poll,
                core.sys.posix.sys.types,
                core.sys.posix.fcntl;
}
else  // for compile test
{
    struct pollfd
    {
        int     fd;
        short   events;
        short   revents;
    }

    alias int       pid_t;

    version (X86)
    {
        enum O_CREAT        = 0x40;     // octal     0100
        enum O_EXCL         = 0x80;     // octal     0200
        enum O_NOCTTY       = 0x100;    // octal     0400
        enum O_TRUNC        = 0x200;    // octal    01000

        enum O_APPEND       = 0x400;    // octal    02000
        enum O_NONBLOCK     = 0x800;    // octal    04000
        enum O_SYNC         = 0x101000; // octal 04010000
        enum O_DSYNC        = 0x1000;   // octal   010000
        enum O_RSYNC        = O_SYNC;
    }
    else version (X86_64)
    {
        enum O_CREAT        = 0x40;     // octal     0100
        enum O_EXCL         = 0x80;     // octal     0200
        enum O_NOCTTY       = 0x100;    // octal     0400
        enum O_TRUNC        = 0x200;    // octal    01000

        enum O_APPEND       = 0x400;    // octal    02000
        enum O_NONBLOCK     = 0x800;    // octal    04000
        enum O_SYNC         = 0x101000; // octal 04010000
        enum O_DSYNC        = 0x1000;   // octal   010000
        enum O_RSYNC        = O_SYNC;
    }
    else version (MIPS32)
    {
        enum O_CREAT        = 0x0100;
        enum O_EXCL         = 0x0400;
        enum O_NOCTTY       = 0x0800;
        enum O_TRUNC        = 0x0200;

        enum O_APPEND       = 0x0008;
        enum O_DSYNC        = O_SYNC;
        enum O_NONBLOCK     = 0x0080;
        enum O_RSYNC        = O_SYNC;
        enum O_SYNC         = 0x0010;
    }
    else version (PPC)
    {
        enum O_CREAT        = 0x40;     // octal     0100
        enum O_EXCL         = 0x80;     // octal     0200
        enum O_NOCTTY       = 0x100;    // octal     0400
        enum O_TRUNC        = 0x200;    // octal    01000

        enum O_APPEND       = 0x400;    // octal    02000
        enum O_NONBLOCK     = 0x800;    // octal    04000
        enum O_SYNC         = 0x101000; // octal 04010000
        enum O_DSYNC        = 0x1000;   // octal   010000
        enum O_RSYNC        = O_SYNC;
    }
    else version (PPC64)
    {
        enum O_CREAT        = 0x40;     // octal     0100
        enum O_EXCL         = 0x80;     // octal     0200
        enum O_NOCTTY       = 0x100;    // octal     0400
        enum O_TRUNC        = 0x200;    // octal    01000

        enum O_APPEND       = 0x400;    // octal    02000
        enum O_NONBLOCK     = 0x800;    // octal    04000
        enum O_SYNC         = 0x101000; // octal 04010000
        enum O_DSYNC        = 0x1000;   // octal   010000
        enum O_RSYNC        = O_SYNC;
    }
    else version (ARM)
    {
        enum O_CREAT        = 0x40;     // octal     0100
        enum O_EXCL         = 0x80;     // octal     0200
        enum O_NOCTTY       = 0x100;    // octal     0400
        enum O_TRUNC        = 0x200;    // octal    01000

        enum O_APPEND       = 0x400;    // octal    02000
        enum O_NONBLOCK     = 0x800;    // octal    04000
        enum O_SYNC         = 0x101000; // octal 04010000
        enum O_DSYNC        = 0x1000;   // octal   010000
        enum O_RSYNC        = O_SYNC;
    }
    else version (AArch64)
    {
        enum O_CREAT        = 0x40;     // octal     0100
        enum O_EXCL         = 0x80;     // octal     0200
        enum O_NOCTTY       = 0x100;    // octal     0400
        enum O_TRUNC        = 0x200;    // octal    01000

        enum O_APPEND       = 0x400;    // octal    02000
        enum O_NONBLOCK     = 0x800;    // octal    04000
        enum O_SYNC         = 0x101000; // octal 04010000
        enum O_DSYNC        = 0x1000;   // octal   010000
        enum O_RSYNC        = O_SYNC;
    }
    else
        static assert(0, "unimplemented");

    enum O_ACCMODE      = 0x3;
    enum O_RDONLY       = 0x0;
    enum O_WRONLY       = 0x1;
    enum O_RDWR         = 0x2;
}

template isVersion(string s)
{
    import std.string;
    mixin(q{version(%s) enum isVersion = true; else enum isVersion = false; }.format(s));
}
