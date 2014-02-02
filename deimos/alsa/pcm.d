/**
 * \file include/pcm.h
 * \brief Application interface library for the ALSA driver
 * \author Jaroslav Kysela <perex@perex.cz>
 * \author Abramo Bagnara <abramo@alsa-project.org>
 * \author Takashi Iwai <tiwai@suse.de>
 * \date 1998-2001
 *
 * Application interface library for the ALSA driver.
 * See the \ref pcm page for more details.
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

module deimos.alsa.pcm;

import deimos.alsa;


extern(C):
nothrow:

//version(linux){} else
//struct pollfd;

/**
 *  \defgroup PCM PCM Interface
 *  See the \ref pcm page for more details.
 *  \{
 */

/** dlsym version for interface entry callback */
//#define SND_PCM_DLSYM_VERSION       _dlsym_pcm_001

/** PCM generic info container */
struct snd_pcm_info_t;

/** PCM hardware configuration space container
 *
 *  snd_pcm_hw_params_t is an opaque structure which contains a set of possible
 *  PCM hardware configurations. For example, a given instance might include a
 *  range of buffer sizes, a range of period sizes, and a set of several sample
 *  formats. Some subset of all possible combinations these sets may be valid,
 *  but not necessarily any combination will be valid.
 *
 *  When a parameter is set or restricted using a snd_pcm_hw_params_set*
 *  function, all of the other ranges will be updated to exclude as many
 *  impossible configurations as possible. Attempting to set a parameter
 *  outside of its acceptable range will result in the function failing
 *  and an error code being returned.
 */
struct snd_pcm_hw_params_t;

/** PCM software configuration container */
struct snd_pcm_sw_params_t;
/** PCM status container */
struct snd_pcm_status_t;
/** PCM access types mask */
struct snd_pcm_access_mask_t;
/** PCM formats mask */
struct snd_pcm_format_mask_t;
/** PCM subformats mask */
struct snd_pcm_subformat_mask_t;

/** PCM class */
enum snd_pcm_class_t {
    /** standard device */

    SND_PCM_CLASS_GENERIC = 0,
    /** multichannel device */
    SND_PCM_CLASS_MULTI,
    /** software modem device */
    SND_PCM_CLASS_MODEM,
    /** digitizer device */
    SND_PCM_CLASS_DIGITIZER,
    SND_PCM_CLASS_LAST = SND_PCM_CLASS_DIGITIZER
}

/** PCM subclass */
enum snd_pcm_subclass_t {
    /** subdevices are mixed together */
    SND_PCM_SUBCLASS_GENERIC_MIX = 0,
    /** multichannel subdevices are mixed together */
    SND_PCM_SUBCLASS_MULTI_MIX,
    SND_PCM_SUBCLASS_LAST = SND_PCM_SUBCLASS_MULTI_MIX
}

/** PCM stream (direction) */
enum snd_pcm_stream_t {
    /** Playback stream */
    SND_PCM_STREAM_PLAYBACK = 0,
    /** Capture stream */
    SND_PCM_STREAM_CAPTURE,
    SND_PCM_STREAM_LAST = SND_PCM_STREAM_CAPTURE
}

/** PCM access type */
enum snd_pcm_access_t {
    /** mmap access with simple interleaved channels */
    SND_PCM_ACCESS_MMAP_INTERLEAVED = 0,
    /** mmap access with simple non interleaved channels */
    SND_PCM_ACCESS_MMAP_NONINTERLEAVED,
    /** mmap access with complex placement */
    SND_PCM_ACCESS_MMAP_COMPLEX,
    /** snd_pcm_readi/snd_pcm_writei access */
    SND_PCM_ACCESS_RW_INTERLEAVED,
    /** snd_pcm_readn/snd_pcm_writen access */
    SND_PCM_ACCESS_RW_NONINTERLEAVED,
    SND_PCM_ACCESS_LAST = SND_PCM_ACCESS_RW_NONINTERLEAVED
}

/** PCM sample format */
mixin("enum snd_pcm_format_t {"q{
    /** Unknown */
    SND_PCM_FORMAT_UNKNOWN = -1,
    /** Signed 8 bit */
    SND_PCM_FORMAT_S8 = 0,
    /** Unsigned 8 bit */
    SND_PCM_FORMAT_U8,
    /** Signed 16 bit Little Endian */
    SND_PCM_FORMAT_S16_LE,
    /** Signed 16 bit Big Endian */
    SND_PCM_FORMAT_S16_BE,
    /** Unsigned 16 bit Little Endian */
    SND_PCM_FORMAT_U16_LE,
    /** Unsigned 16 bit Big Endian */
    SND_PCM_FORMAT_U16_BE,
    /** Signed 24 bit Little Endian using low three bytes in 32-bit word */
    SND_PCM_FORMAT_S24_LE,
    /** Signed 24 bit Big Endian using low three bytes in 32-bit word */
    SND_PCM_FORMAT_S24_BE,
    /** Unsigned 24 bit Little Endian using low three bytes in 32-bit word */
    SND_PCM_FORMAT_U24_LE,
    /** Unsigned 24 bit Big Endian using low three bytes in 32-bit word */
    SND_PCM_FORMAT_U24_BE,
    /** Signed 32 bit Little Endian */
    SND_PCM_FORMAT_S32_LE,
    /** Signed 32 bit Big Endian */
    SND_PCM_FORMAT_S32_BE,
    /** Unsigned 32 bit Little Endian */
    SND_PCM_FORMAT_U32_LE,
    /** Unsigned 32 bit Big Endian */
    SND_PCM_FORMAT_U32_BE,
    /** Float 32 bit Little Endian, Range -1.0 to 1.0 */
    SND_PCM_FORMAT_FLOAT_LE,
    /** Float 32 bit Big Endian, Range -1.0 to 1.0 */
    SND_PCM_FORMAT_FLOAT_BE,
    /** Float 64 bit Little Endian, Range -1.0 to 1.0 */
    SND_PCM_FORMAT_FLOAT64_LE,
    /** Float 64 bit Big Endian, Range -1.0 to 1.0 */
    SND_PCM_FORMAT_FLOAT64_BE,
    /** IEC-958 Little Endian */
    SND_PCM_FORMAT_IEC958_SUBFRAME_LE,
    /** IEC-958 Big Endian */
    SND_PCM_FORMAT_IEC958_SUBFRAME_BE,
    /** Mu-Law */
    SND_PCM_FORMAT_MU_LAW,
    /** A-Law */
    SND_PCM_FORMAT_A_LAW,
    /** Ima-ADPCM */
    SND_PCM_FORMAT_IMA_ADPCM,
    /** MPEG */
    SND_PCM_FORMAT_MPEG,
    /** GSM */
    SND_PCM_FORMAT_GSM,
    /** Special */
    SND_PCM_FORMAT_SPECIAL = 31,
    /** Signed 24bit Little Endian in 3bytes format */
    SND_PCM_FORMAT_S24_3LE = 32,
    /** Signed 24bit Big Endian in 3bytes format */
    SND_PCM_FORMAT_S24_3BE,
    /** Unsigned 24bit Little Endian in 3bytes format */
    SND_PCM_FORMAT_U24_3LE,
    /** Unsigned 24bit Big Endian in 3bytes format */
    SND_PCM_FORMAT_U24_3BE,
    /** Signed 20bit Little Endian in 3bytes format */
    SND_PCM_FORMAT_S20_3LE,
    /** Signed 20bit Big Endian in 3bytes format */
    SND_PCM_FORMAT_S20_3BE,
    /** Unsigned 20bit Little Endian in 3bytes format */
    SND_PCM_FORMAT_U20_3LE,
    /** Unsigned 20bit Big Endian in 3bytes format */
    SND_PCM_FORMAT_U20_3BE,
    /** Signed 18bit Little Endian in 3bytes format */
    SND_PCM_FORMAT_S18_3LE,
    /** Signed 18bit Big Endian in 3bytes format */
    SND_PCM_FORMAT_S18_3BE,
    /** Unsigned 18bit Little Endian in 3bytes format */
    SND_PCM_FORMAT_U18_3LE,
    /** Unsigned 18bit Big Endian in 3bytes format */
    SND_PCM_FORMAT_U18_3BE,
    /* G.723 (ADPCM) 24 kbit/s, 8 samples in 3 bytes */
    SND_PCM_FORMAT_G723_24,
    /* G.723 (ADPCM) 24 kbit/s, 1 sample in 1 byte */
    SND_PCM_FORMAT_G723_24_1B,
    /* G.723 (ADPCM) 40 kbit/s, 8 samples in 3 bytes */
    SND_PCM_FORMAT_G723_40,
    /* G.723 (ADPCM) 40 kbit/s, 1 sample in 1 byte */
    SND_PCM_FORMAT_G723_40_1B,
    /* Direct Stream Digital (DSD) in 1-byte samples (x8) */
    SND_PCM_FORMAT_DSD_U8,
    /* Direct Stream Digital (DSD) in 2-byte samples (x16) */
    SND_PCM_FORMAT_DSD_U16_LE,
    SND_PCM_FORMAT_LAST = SND_PCM_FORMAT_DSD_U16_LE,
}
 ~ (isVersion!"LittleEndian" ?
q{
    /** Signed 16 bit CPU endian */
    SND_PCM_FORMAT_S16 = SND_PCM_FORMAT_S16_LE,
    /** Unsigned 16 bit CPU endian */
    SND_PCM_FORMAT_U16 = SND_PCM_FORMAT_U16_LE,
    /** Signed 24 bit CPU endian */
    SND_PCM_FORMAT_S24 = SND_PCM_FORMAT_S24_LE,
    /** Unsigned 24 bit CPU endian */
    SND_PCM_FORMAT_U24 = SND_PCM_FORMAT_U24_LE,
    /** Signed 32 bit CPU endian */
    SND_PCM_FORMAT_S32 = SND_PCM_FORMAT_S32_LE,
    /** Unsigned 32 bit CPU endian */
    SND_PCM_FORMAT_U32 = SND_PCM_FORMAT_U32_LE,
    /** Float 32 bit CPU endian */
    SND_PCM_FORMAT_FLOAT = SND_PCM_FORMAT_FLOAT_LE,
    /** Float 64 bit CPU endian */
    SND_PCM_FORMAT_FLOAT64 = SND_PCM_FORMAT_FLOAT64_LE,
    /** IEC-958 CPU Endian */
    SND_PCM_FORMAT_IEC958_SUBFRAME = SND_PCM_FORMAT_IEC958_SUBFRAME_LE
}
:
q{
    /** Signed 16 bit CPU endian */
    SND_PCM_FORMAT_S16 = SND_PCM_FORMAT_S16_BE,
    /** Unsigned 16 bit CPU endian */
    SND_PCM_FORMAT_U16 = SND_PCM_FORMAT_U16_BE,
    /** Signed 24 bit CPU endian */
    SND_PCM_FORMAT_S24 = SND_PCM_FORMAT_S24_BE,
    /** Unsigned 24 bit CPU endian */
    SND_PCM_FORMAT_U24 = SND_PCM_FORMAT_U24_BE,
    /** Signed 32 bit CPU endian */
    SND_PCM_FORMAT_S32 = SND_PCM_FORMAT_S32_BE,
    /** Unsigned 32 bit CPU endian */
    SND_PCM_FORMAT_U32 = SND_PCM_FORMAT_U32_BE,
    /** Float 32 bit CPU endian */
    SND_PCM_FORMAT_FLOAT = SND_PCM_FORMAT_FLOAT_BE,
    /** Float 64 bit CPU endian */
    SND_PCM_FORMAT_FLOAT64 = SND_PCM_FORMAT_FLOAT64_BE,
    /** IEC-958 CPU Endian */
    SND_PCM_FORMAT_IEC958_SUBFRAME = SND_PCM_FORMAT_IEC958_SUBFRAME_BE
}) ~ "}");    // end mixin

/** PCM sample subformat */
enum snd_pcm_subformat_t {
    /** Standard */
    SND_PCM_SUBFORMAT_STD = 0,
    SND_PCM_SUBFORMAT_LAST = SND_PCM_SUBFORMAT_STD
}

/** PCM state */
enum snd_pcm_state_t {
    /** Open */
    SND_PCM_STATE_OPEN = 0,
    /** Setup installed */ 
    SND_PCM_STATE_SETUP,
    /** Ready to start */
    SND_PCM_STATE_PREPARED,
    /** Running */
    SND_PCM_STATE_RUNNING,
    /** Stopped: underrun (playback) or overrun (capture) detected */
    SND_PCM_STATE_XRUN,
    /** Draining: running (playback) or stopped (capture) */
    SND_PCM_STATE_DRAINING,
    /** Paused */
    SND_PCM_STATE_PAUSED,
    /** Hardware is suspended */
    SND_PCM_STATE_SUSPENDED,
    /** Hardware is disconnected */
    SND_PCM_STATE_DISCONNECTED,
    SND_PCM_STATE_LAST = SND_PCM_STATE_DISCONNECTED
}

/** PCM start mode */
enum snd_pcm_start_t {
    /** Automatic start on data read/write */
    SND_PCM_START_DATA = 0,
    /** Explicit start */
    SND_PCM_START_EXPLICIT,
    SND_PCM_START_LAST = SND_PCM_START_EXPLICIT
}

/** PCM xrun mode */
enum snd_pcm_xrun_t {
    /** Xrun detection disabled */
    SND_PCM_XRUN_NONE = 0,
    /** Stop on xrun detection */
    SND_PCM_XRUN_STOP,
    SND_PCM_XRUN_LAST = SND_PCM_XRUN_STOP
}

/** PCM timestamp mode */
enum snd_pcm_tstamp_t {
    /** No timestamp */
    SND_PCM_TSTAMP_NONE = 0,
    /** Update timestamp at every hardware position update */
    SND_PCM_TSTAMP_ENABLE,
    /** Equivalent with #SND_PCM_TSTAMP_ENABLE,
     * just for compatibility with older versions
     */
    SND_PCM_TSTAMP_MMAP = SND_PCM_TSTAMP_ENABLE,
    SND_PCM_TSTAMP_LAST = SND_PCM_TSTAMP_ENABLE
}

/** Unsigned frames quantity */
alias size_t snd_pcm_uframes_t;
/** Signed frames quantity */
alias ptrdiff_t snd_pcm_sframes_t;

/** Non blocking mode (flag for open mode) \hideinitializer */
enum SND_PCM_NONBLOCK =       0x00000001;
/** Async notification (flag for open mode) \hideinitializer */
enum SND_PCM_ASYNC =          0x00000002;
/** In an abort state (internal, not allowed for open) */
enum SND_PCM_ABORT =          0x00008000;
/** Disable automatic (but not forced!) rate resamplinig */
enum SND_PCM_NO_AUTO_RESAMPLE =   0x00010000;
/** Disable automatic (but not forced!) channel conversion */
enum SND_PCM_NO_AUTO_CHANNELS =   0x00020000;
/** Disable automatic (but not forced!) format conversion */
enum SND_PCM_NO_AUTO_FORMAT =     0x00040000;
/** Disable soft volume control */
enum SND_PCM_NO_SOFTVOL =     0x00080000;

/** PCM handle */
struct snd_pcm_t;

/** PCM type */
enum snd_pcm_type_t {
    /** Kernel level PCM */
    SND_PCM_TYPE_HW = 0,
    /** Hooked PCM */
    SND_PCM_TYPE_HOOKS,
    /** One or more linked PCM with exclusive access to selected
        channels */
    SND_PCM_TYPE_MULTI,
    /** File writing plugin */
    SND_PCM_TYPE_FILE,
    /** Null endpoint PCM */
    SND_PCM_TYPE_NULL,
    /** Shared memory client PCM */
    SND_PCM_TYPE_SHM,
    /** INET client PCM (not yet implemented) */
    SND_PCM_TYPE_INET,
    /** Copying plugin */
    SND_PCM_TYPE_COPY,
    /** Linear format conversion PCM */
    SND_PCM_TYPE_LINEAR,
    /** A-Law format conversion PCM */
    SND_PCM_TYPE_ALAW,
    /** Mu-Law format conversion PCM */
    SND_PCM_TYPE_MULAW,
    /** IMA-ADPCM format conversion PCM */
    SND_PCM_TYPE_ADPCM,
    /** Rate conversion PCM */
    SND_PCM_TYPE_RATE,
    /** Attenuated static route PCM */
    SND_PCM_TYPE_ROUTE,
    /** Format adjusted PCM */
    SND_PCM_TYPE_PLUG,
    /** Sharing PCM */
    SND_PCM_TYPE_SHARE,
    /** Meter plugin */
    SND_PCM_TYPE_METER,
    /** Mixing PCM */
    SND_PCM_TYPE_MIX,
    /** Attenuated dynamic route PCM (not yet implemented) */
    SND_PCM_TYPE_DROUTE,
    /** Loopback server plugin (not yet implemented) */
    SND_PCM_TYPE_LBSERVER,
    /** Linear Integer <-> Linear Float format conversion PCM */
    SND_PCM_TYPE_LINEAR_FLOAT,
    /** LADSPA integration plugin */
    SND_PCM_TYPE_LADSPA,
    /** Direct Mixing plugin */
    SND_PCM_TYPE_DMIX,
    /** Jack Audio Connection Kit plugin */
    SND_PCM_TYPE_JACK,
    /** Direct Snooping plugin */
    SND_PCM_TYPE_DSNOOP,
    /** Direct Sharing plugin */
    SND_PCM_TYPE_DSHARE,
    /** IEC958 subframe plugin */
    SND_PCM_TYPE_IEC958,
    /** Soft volume plugin */
    SND_PCM_TYPE_SOFTVOL,
    /** External I/O plugin */
    SND_PCM_TYPE_IOPLUG,
    /** External filter plugin */
    SND_PCM_TYPE_EXTPLUG,
    /** Mmap-emulation plugin */
    SND_PCM_TYPE_MMAP_EMUL,
    SND_PCM_TYPE_LAST = SND_PCM_TYPE_MMAP_EMUL
}

/** PCM area specification */
struct snd_pcm_channel_area_t {
    /** base address of channel samples */
    void* addr;
    /** offset to first sample in bits */
    uint first;
    /** samples distance in bits */
    uint step;
}

/** PCM synchronization ID */
union snd_pcm_sync_id_t {
    /** 8-bit ID */
    ubyte[16] id;
    /** 16-bit ID */
    ushort[8] id16;
    /** 32-bit ID */
    uint[4] id32;
}

/** #SND_PCM_TYPE_METER scope handle */
struct snd_pcm_scope_t;

int snd_pcm_open(snd_pcm_t** pcm, const(char)* name, 
         snd_pcm_stream_t stream, int mode);
int snd_pcm_open_lconf(snd_pcm_t** pcm, const(char)* name, 
               snd_pcm_stream_t stream, int mode,
               snd_config_t* lconf);
int snd_pcm_open_fallback(snd_pcm_t** pcm, snd_config_t* root,
              const(char)* name, const(char)* orig_name,
              snd_pcm_stream_t stream, int mode);

int snd_pcm_close(snd_pcm_t* pcm);
const(char)* snd_pcm_name(snd_pcm_t* pcm);
snd_pcm_type_t snd_pcm_type(snd_pcm_t* pcm);
snd_pcm_stream_t snd_pcm_stream(snd_pcm_t* pcm);
int snd_pcm_poll_descriptors_count(snd_pcm_t* pcm);
int snd_pcm_poll_descriptors(snd_pcm_t* pcm, pollfd* pfds, uint space);
int snd_pcm_poll_descriptors_revents(snd_pcm_t* pcm, pollfd* pfds, uint nfds, ushort* revents);
int snd_pcm_nonblock(snd_pcm_t* pcm, int nonblock);
int snd_pcm_abort(snd_pcm_t* pcm) { return snd_pcm_nonblock(pcm, 2); }
int snd_async_add_pcm_handler(snd_async_handler_t** handler, snd_pcm_t* pcm, 
                  snd_async_callback_t callback, void* private_data);
snd_pcm_t* snd_async_handler_get_pcm(snd_async_handler_t* handler);
int snd_pcm_info(snd_pcm_t* pcm, snd_pcm_info_t* info);
int snd_pcm_hw_params_current(snd_pcm_t* pcm, snd_pcm_hw_params_t* params);
int snd_pcm_hw_params(snd_pcm_t* pcm, snd_pcm_hw_params_t* params);
int snd_pcm_hw_free(snd_pcm_t* pcm);
int snd_pcm_sw_params_current(snd_pcm_t* pcm, snd_pcm_sw_params_t* params);
int snd_pcm_sw_params(snd_pcm_t* pcm, snd_pcm_sw_params_t* params);
int snd_pcm_prepare(snd_pcm_t* pcm);
int snd_pcm_reset(snd_pcm_t* pcm);
int snd_pcm_status(snd_pcm_t* pcm, snd_pcm_status_t* status);
int snd_pcm_start(snd_pcm_t* pcm);
int snd_pcm_drop(snd_pcm_t* pcm);
int snd_pcm_drain(snd_pcm_t* pcm);
int snd_pcm_pause(snd_pcm_t* pcm, int enable);
snd_pcm_state_t snd_pcm_state(snd_pcm_t* pcm);
int snd_pcm_hwsync(snd_pcm_t* pcm);
int snd_pcm_delay(snd_pcm_t* pcm, snd_pcm_sframes_t* delayp);
int snd_pcm_resume(snd_pcm_t* pcm);
int snd_pcm_htimestamp(snd_pcm_t* pcm, snd_pcm_uframes_t* avail, snd_htimestamp_t* tstamp);
snd_pcm_sframes_t snd_pcm_avail(snd_pcm_t* pcm);
snd_pcm_sframes_t snd_pcm_avail_update(snd_pcm_t* pcm);
int snd_pcm_avail_delay(snd_pcm_t* pcm, snd_pcm_sframes_t* availp, snd_pcm_sframes_t* delayp);
snd_pcm_sframes_t snd_pcm_rewindable(snd_pcm_t* pcm);
snd_pcm_sframes_t snd_pcm_rewind(snd_pcm_t* pcm, snd_pcm_uframes_t frames);
snd_pcm_sframes_t snd_pcm_forwardable(snd_pcm_t* pcm);
snd_pcm_sframes_t snd_pcm_forward(snd_pcm_t* pcm, snd_pcm_uframes_t frames);
snd_pcm_sframes_t snd_pcm_writei(snd_pcm_t* pcm, const(void)* buffer, snd_pcm_uframes_t size);
snd_pcm_sframes_t snd_pcm_readi(snd_pcm_t* pcm, void* buffer, snd_pcm_uframes_t size);
snd_pcm_sframes_t snd_pcm_writen(snd_pcm_t* pcm, void** bufs, snd_pcm_uframes_t size);
snd_pcm_sframes_t snd_pcm_readn(snd_pcm_t* pcm, void** bufs, snd_pcm_uframes_t size);
int snd_pcm_wait(snd_pcm_t* pcm, int timeout);

int snd_pcm_link(snd_pcm_t* pcm1, snd_pcm_t* pcm2);
int snd_pcm_unlink(snd_pcm_t* pcm);

/** channel mapping API version number */
enum SND_CHMAP_API_VERSION = ((1 << 16) | (0 << 8) | 1);

/** channel map list type */
enum snd_pcm_chmap_type {
    SND_CHMAP_TYPE_NONE = 0,/** unspecified channel position */
    SND_CHMAP_TYPE_FIXED,   /** fixed channel position */
    SND_CHMAP_TYPE_VAR, /** freely swappable channel position */
    SND_CHMAP_TYPE_PAIRED,  /** pair-wise swappable channel position */
    SND_CHMAP_TYPE_LAST = SND_CHMAP_TYPE_PAIRED, /** last entry */
}

/** channel positions */
enum snd_pcm_chmap_position {
    SND_CHMAP_UNKNOWN = 0,  /**< unspecified */
    SND_CHMAP_NA,       /**< N/A, silent */
    SND_CHMAP_MONO,     /**< mono stream */
    SND_CHMAP_FL,       /**< front left */
    SND_CHMAP_FR,       /**< front right */
    SND_CHMAP_RL,       /**< rear left */
    SND_CHMAP_RR,       /**< rear right */
    SND_CHMAP_FC,       /**< front center */
    SND_CHMAP_LFE,      /**< LFE */
    SND_CHMAP_SL,       /**< side left */
    SND_CHMAP_SR,       /**< side right */
    SND_CHMAP_RC,       /**< rear center */
    SND_CHMAP_FLC,      /**< front left center */
    SND_CHMAP_FRC,      /**< front right center */
    SND_CHMAP_RLC,      /**< rear left center */
    SND_CHMAP_RRC,      /**< rear right center */
    SND_CHMAP_FLW,      /**< front left wide */
    SND_CHMAP_FRW,      /**< front right wide */
    SND_CHMAP_FLH,      /**< front left high */
    SND_CHMAP_FCH,      /**< front center high */
    SND_CHMAP_FRH,      /**< front right high */
    SND_CHMAP_TC,       /**< top center */
    SND_CHMAP_TFL,      /**< top front left */
    SND_CHMAP_TFR,      /**< top front right */
    SND_CHMAP_TFC,      /**< top front center */
    SND_CHMAP_TRL,      /**< top rear left */
    SND_CHMAP_TRR,      /**< top rear right */
    SND_CHMAP_TRC,      /**< top rear center */
    SND_CHMAP_TFLC,     /**< top front left center */
    SND_CHMAP_TFRC,     /**< top front right center */
    SND_CHMAP_TSL,      /**< top side left */
    SND_CHMAP_TSR,      /**< top side right */
    SND_CHMAP_LLFE,     /**< left LFE */
    SND_CHMAP_RLFE,     /**< right LFE */
    SND_CHMAP_BC,       /**< bottom center */
    SND_CHMAP_BLC,      /**< bottom left center */
    SND_CHMAP_BRC,      /**< bottom right center */
    SND_CHMAP_LAST = SND_CHMAP_BRC,
}

/** bitmask for channel position */
enum SND_CHMAP_POSITION_MASK =   0xffff;

/** bit flag indicating the channel is phase inverted */
enum SND_CHMAP_PHASE_INVERSE =     (0x01 << 16);
/** bit flag indicating the non-standard channel value */
enum SND_CHMAP_DRIVER_SPEC =       (0x02 << 16);

/** the channel map header */
//struct snd_pcm_chmap_t {
//    uint channels;  /**< number of channels */
//    uint[0] pos;    /**< channel position array */
//}

struct snd_pcm_chmap_t
{
    uint channels;

    uint[] pos() @property @system
    {
        return (&channels + 1)[0 .. channels];
    }
}
unittest{
    static assert(__traits(isPOD, snd_pcm_chmap_t));
}


/** the header of array items returned from snd_pcm_query_chmaps() */
struct snd_pcm_chmap_query_t {
    snd_pcm_chmap_type type;   /**< channel map type */
    snd_pcm_chmap_t map;        /**< available channel map */
}


snd_pcm_chmap_query_t** snd_pcm_query_chmaps(snd_pcm_t* pcm);
snd_pcm_chmap_query_t** snd_pcm_query_chmaps_from_hw(int card, int dev,
                             int subdev,
                             snd_pcm_stream_t stream);
void snd_pcm_free_chmaps(snd_pcm_chmap_query_t** maps);
snd_pcm_chmap_t* snd_pcm_get_chmap(snd_pcm_t* pcm);
int snd_pcm_set_chmap(snd_pcm_t* pcm, const(snd_pcm_chmap_t)* map);

const(char)* snd_pcm_chmap_type_name(snd_pcm_chmap_type val);
const(char)* snd_pcm_chmap_name(snd_pcm_chmap_position val);
const(char)* snd_pcm_chmap_long_name(snd_pcm_chmap_position val);
int snd_pcm_chmap_print(const(snd_pcm_chmap_t)* map, size_t maxlen, char* buf);
uint snd_pcm_chmap_from_string(const(char)* str);
snd_pcm_chmap_t* snd_pcm_chmap_parse_string(const(char)* str);

//int snd_pcm_mixer_element(snd_pcm_t* pcm, snd_mixer_t *mixer, snd_mixer_elem_t** elem);

/*
 * application helpers - these functions are implemented on top
 * of the basic API
 */

int snd_pcm_recover(snd_pcm_t* pcm, int err, int silent);
int snd_pcm_set_params(snd_pcm_t* pcm,
                       snd_pcm_format_t format,
                       snd_pcm_access_t access,
                       uint channels,
                       uint rate,
                       int soft_resample,
                       uint latency);
int snd_pcm_get_params(snd_pcm_t* pcm,
                       snd_pcm_uframes_t* buffer_size,
                       snd_pcm_uframes_t* period_size);

/** \} */

/**
 * \defgroup PCM_Info Stream Information
 * \ingroup PCM
 * See the \ref pcm page for more details.
 * \{
 */

size_t snd_pcm_info_sizeof();
/** \hideinitializer
 * \brief allocate an invalid #snd_pcm_info_t using standard alloca
 * \param ptr returned pointer
 */
//#define snd_pcm_info_alloca(ptr) __snd_alloca(ptr, snd_pcm_info)
int snd_pcm_info_malloc(snd_pcm_info_t** ptr);
void snd_pcm_info_free(snd_pcm_info_t* obj);
void snd_pcm_info_copy(snd_pcm_info_t* dst, const(snd_pcm_info_t)* src);
uint snd_pcm_info_get_device(const(snd_pcm_info_t)* obj);
uint snd_pcm_info_get_subdevice(const(snd_pcm_info_t)* obj);
snd_pcm_stream_t snd_pcm_info_get_stream(const(snd_pcm_info_t)* obj);
int snd_pcm_info_get_card(const(snd_pcm_info_t)* obj);
const(char)* snd_pcm_info_get_id(const(snd_pcm_info_t)* obj);
const(char)* snd_pcm_info_get_name(const(snd_pcm_info_t)* obj);
const(char)* snd_pcm_info_get_subdevice_name(const(snd_pcm_info_t)* obj);
snd_pcm_class_t snd_pcm_info_get_class(const(snd_pcm_info_t)* obj);
snd_pcm_subclass_t snd_pcm_info_get_subclass(const(snd_pcm_info_t)* obj);
uint snd_pcm_info_get_subdevices_count(const(snd_pcm_info_t)* obj);
uint snd_pcm_info_get_subdevices_avail(const(snd_pcm_info_t)* obj);
snd_pcm_sync_id_t snd_pcm_info_get_sync(const(snd_pcm_info_t)* obj);
void snd_pcm_info_set_device(snd_pcm_info_t* obj, uint val);
void snd_pcm_info_set_subdevice(snd_pcm_info_t* obj, uint val);
void snd_pcm_info_set_stream(snd_pcm_info_t* obj, snd_pcm_stream_t val);

/** \} */

/**
 * \defgroup PCM_HW_Params Hardware Parameters
 * \ingroup PCM
 * See the \ref pcm page for more details.
 * \{
 */

int snd_pcm_hw_params_any(snd_pcm_t* pcm, snd_pcm_hw_params_t* params);

int snd_pcm_hw_params_can_mmap_sample_resolution(const(snd_pcm_hw_params_t)* params);
int snd_pcm_hw_params_is_double(const(snd_pcm_hw_params_t)* params);
int snd_pcm_hw_params_is_batch(const(snd_pcm_hw_params_t)* params);
int snd_pcm_hw_params_is_block_transfer(const(snd_pcm_hw_params_t)* params);
int snd_pcm_hw_params_is_monotonic(const(snd_pcm_hw_params_t)* params);
int snd_pcm_hw_params_can_overrange(const(snd_pcm_hw_params_t)* params);
int snd_pcm_hw_params_can_pause(const(snd_pcm_hw_params_t)* params);
int snd_pcm_hw_params_can_resume(const(snd_pcm_hw_params_t)* params);
int snd_pcm_hw_params_is_half_duplex(const(snd_pcm_hw_params_t)* params);
int snd_pcm_hw_params_is_joint_duplex(const(snd_pcm_hw_params_t)* params);
int snd_pcm_hw_params_can_sync_start(const(snd_pcm_hw_params_t)* params);
int snd_pcm_hw_params_can_disable_period_wakeup(const(snd_pcm_hw_params_t)* params);
int snd_pcm_hw_params_supports_audio_wallclock_ts(const(snd_pcm_hw_params_t)* params);
int snd_pcm_hw_params_get_rate_numden(const(snd_pcm_hw_params_t)* params,
                      uint* rate_num,
                      uint* rate_den);
int snd_pcm_hw_params_get_sbits(const(snd_pcm_hw_params_t)* params);
int snd_pcm_hw_params_get_fifo_size(const(snd_pcm_hw_params_t)* params);

version(none){
struct snd_pcm_hw_strategy_t;

/* choices need to be sorted on ascending badness */
struct snd_pcm_hw_strategy_simple_choices_list_t {
    uint value;
    uint badness;
}

int snd_pcm_hw_params_strategy(snd_pcm_t* pcm, snd_pcm_hw_params_t* params,
                   const(snd_pcm_hw_strategy_t)* strategy,
                   uint badness_min,
                   uint badness_max);

void snd_pcm_hw_strategy_free(snd_pcm_hw_strategy_t* strategy);
int snd_pcm_hw_strategy_simple(snd_pcm_hw_strategy_t** strategyp,
                   uint badness_min,
                   uint badness_max);
int snd_pcm_hw_params_try_explain_failure(snd_pcm_t* pcm,
                      snd_pcm_hw_params_t* fail,
                      snd_pcm_hw_params_t* success,
                      uint depth,
                      snd_output_t* out_);

}

size_t snd_pcm_hw_params_sizeof();
/** \hideinitializer
 * \brief allocate an invalid #snd_pcm_hw_params_t using standard alloca
 * \param ptr returned pointer
 */
//#define snd_pcm_hw_params_alloca(ptr) __snd_alloca(ptr, snd_pcm_hw_params)
int snd_pcm_hw_params_malloc(snd_pcm_hw_params_t** ptr);
void snd_pcm_hw_params_free(snd_pcm_hw_params_t* obj);
void snd_pcm_hw_params_copy(snd_pcm_hw_params_t* dst, const(snd_pcm_hw_params_t)* src);

//#if !defined(ALSA_LIBRARY_BUILD) && !defined(ALSA_PCM_OLD_HW_PARAMS_API)
static if(!isVersion!"ALSA_LIBRARY_BUILD" && !isVersion!"ALSA_PCM_OLD_HW_PARAMS_API")
{

int snd_pcm_hw_params_get_access(const(snd_pcm_hw_params_t)* params, snd_pcm_access_t* _access);
int snd_pcm_hw_params_test_access(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_access_t _access);
int snd_pcm_hw_params_set_access(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_access_t _access);
int snd_pcm_hw_params_set_access_first(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_access_t* _access);
int snd_pcm_hw_params_set_access_last(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_access_t* _access);
int snd_pcm_hw_params_set_access_mask(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_access_mask_t* mask);
int snd_pcm_hw_params_get_access_mask(snd_pcm_hw_params_t* params, snd_pcm_access_mask_t* mask);

int snd_pcm_hw_params_get_format(const(snd_pcm_hw_params_t)* params, snd_pcm_format_t* val);
int snd_pcm_hw_params_test_format(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_format_t val);
int snd_pcm_hw_params_set_format(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_format_t val);
int snd_pcm_hw_params_set_format_first(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_format_t* format);
int snd_pcm_hw_params_set_format_last(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_format_t* format);
int snd_pcm_hw_params_set_format_mask(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_format_mask_t* mask);
void snd_pcm_hw_params_get_format_mask(snd_pcm_hw_params_t* params, snd_pcm_format_mask_t* mask);

int snd_pcm_hw_params_get_subformat(const(snd_pcm_hw_params_t)* params, snd_pcm_subformat_t* subformat);
int snd_pcm_hw_params_test_subformat(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_subformat_t subformat);
int snd_pcm_hw_params_set_subformat(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_subformat_t subformat);
int snd_pcm_hw_params_set_subformat_first(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_subformat_t* subformat);
int snd_pcm_hw_params_set_subformat_last(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_subformat_t* subformat);
int snd_pcm_hw_params_set_subformat_mask(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_subformat_mask_t* mask);
void snd_pcm_hw_params_get_subformat_mask(snd_pcm_hw_params_t* params, snd_pcm_subformat_mask_t* mask);

int snd_pcm_hw_params_get_channels(const(snd_pcm_hw_params_t)* params, uint* val);
int snd_pcm_hw_params_get_channels_min(const(snd_pcm_hw_params_t)* params, uint* val);
int snd_pcm_hw_params_get_channels_max(const(snd_pcm_hw_params_t)* params, uint* val);
int snd_pcm_hw_params_test_channels(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint val);
int snd_pcm_hw_params_set_channels(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint val);
int snd_pcm_hw_params_set_channels_min(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val);
int snd_pcm_hw_params_set_channels_max(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val);
int snd_pcm_hw_params_set_channels_minmax(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* min, uint* max);
int snd_pcm_hw_params_set_channels_near(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val);
int snd_pcm_hw_params_set_channels_first(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val);
int snd_pcm_hw_params_set_channels_last(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val);

int snd_pcm_hw_params_get_rate(const(snd_pcm_hw_params_t)* params, uint* val, int* dir);
int snd_pcm_hw_params_get_rate_min(const(snd_pcm_hw_params_t)* params, uint* val, int* dir);
int snd_pcm_hw_params_get_rate_max(const(snd_pcm_hw_params_t)* params, uint* val, int* dir);
int snd_pcm_hw_params_test_rate(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint val, int dir);
int snd_pcm_hw_params_set_rate(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint val, int dir);
int snd_pcm_hw_params_set_rate_min(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);
int snd_pcm_hw_params_set_rate_max(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);
int snd_pcm_hw_params_set_rate_minmax(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* min, int* mindir, uint* max, int* maxdir);
int snd_pcm_hw_params_set_rate_near(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);
int snd_pcm_hw_params_set_rate_first(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);
int snd_pcm_hw_params_set_rate_last(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);
int snd_pcm_hw_params_set_rate_resample(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint val);
int snd_pcm_hw_params_get_rate_resample(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val);
int snd_pcm_hw_params_set_export_buffer(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint val);
int snd_pcm_hw_params_get_export_buffer(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val);
int snd_pcm_hw_params_set_period_wakeup(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint val);
int snd_pcm_hw_params_get_period_wakeup(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val);

int snd_pcm_hw_params_get_period_time(const(snd_pcm_hw_params_t)* params, uint* val, int* dir);
int snd_pcm_hw_params_get_period_time_min(const(snd_pcm_hw_params_t)* params, uint* val, int* dir);
int snd_pcm_hw_params_get_period_time_max(const(snd_pcm_hw_params_t)* params, uint* val, int* dir);
int snd_pcm_hw_params_test_period_time(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint val, int dir);
int snd_pcm_hw_params_set_period_time(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint val, int dir);
int snd_pcm_hw_params_set_period_time_min(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);
int snd_pcm_hw_params_set_period_time_max(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);
int snd_pcm_hw_params_set_period_time_minmax(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* min, int* mindir, uint* max, int* maxdir);
int snd_pcm_hw_params_set_period_time_near(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);
int snd_pcm_hw_params_set_period_time_first(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);
int snd_pcm_hw_params_set_period_time_last(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);

int snd_pcm_hw_params_get_period_size(const(snd_pcm_hw_params_t)* params, snd_pcm_uframes_t* frames, int* dir);
int snd_pcm_hw_params_get_period_size_min(const(snd_pcm_hw_params_t)* params, snd_pcm_uframes_t* frames, int* dir);
int snd_pcm_hw_params_get_period_size_max(const(snd_pcm_hw_params_t)* params, snd_pcm_uframes_t* frames, int* dir);
int snd_pcm_hw_params_test_period_size(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_uframes_t val, int dir);
int snd_pcm_hw_params_set_period_size(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_uframes_t val, int dir);
int snd_pcm_hw_params_set_period_size_min(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_uframes_t* val, int* dir);
int snd_pcm_hw_params_set_period_size_max(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_uframes_t* val, int* dir);
int snd_pcm_hw_params_set_period_size_minmax(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_uframes_t* min, int* mindir, snd_pcm_uframes_t* max, int* maxdir);
int snd_pcm_hw_params_set_period_size_near(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_uframes_t* val, int* dir);
int snd_pcm_hw_params_set_period_size_first(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_uframes_t* val, int* dir);
int snd_pcm_hw_params_set_period_size_last(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_uframes_t* val, int* dir);
int snd_pcm_hw_params_set_period_size_integer(snd_pcm_t* pcm, snd_pcm_hw_params_t* params);

int snd_pcm_hw_params_get_periods(const(snd_pcm_hw_params_t)* params, uint* val, int* dir);
int snd_pcm_hw_params_get_periods_min(const(snd_pcm_hw_params_t)* params, uint* val, int* dir);
int snd_pcm_hw_params_get_periods_max(const(snd_pcm_hw_params_t)* params, uint* val, int* dir);
int snd_pcm_hw_params_test_periods(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint val, int dir);
int snd_pcm_hw_params_set_periods(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint val, int dir);
int snd_pcm_hw_params_set_periods_min(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);
int snd_pcm_hw_params_set_periods_max(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);
int snd_pcm_hw_params_set_periods_minmax(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* min, int* mindir, uint* max, int* maxdir);
int snd_pcm_hw_params_set_periods_near(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);
int snd_pcm_hw_params_set_periods_first(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);
int snd_pcm_hw_params_set_periods_last(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);
int snd_pcm_hw_params_set_periods_integer(snd_pcm_t* pcm, snd_pcm_hw_params_t* params);

int snd_pcm_hw_params_get_buffer_time(const(snd_pcm_hw_params_t)* params, uint* val, int* dir);
int snd_pcm_hw_params_get_buffer_time_min(const(snd_pcm_hw_params_t)* params, uint* val, int* dir);
int snd_pcm_hw_params_get_buffer_time_max(const(snd_pcm_hw_params_t)* params, uint* val, int* dir);
int snd_pcm_hw_params_test_buffer_time(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint val, int dir);
int snd_pcm_hw_params_set_buffer_time(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint val, int dir);
int snd_pcm_hw_params_set_buffer_time_min(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);
int snd_pcm_hw_params_set_buffer_time_max(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);
int snd_pcm_hw_params_set_buffer_time_minmax(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* min, int* mindir, uint* max, int* maxdir);
int snd_pcm_hw_params_set_buffer_time_near(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);
int snd_pcm_hw_params_set_buffer_time_first(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);
int snd_pcm_hw_params_set_buffer_time_last(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);

int snd_pcm_hw_params_get_buffer_size(const(snd_pcm_hw_params_t)* params, snd_pcm_uframes_t* val);
int snd_pcm_hw_params_get_buffer_size_min(const(snd_pcm_hw_params_t)* params, snd_pcm_uframes_t* val);
int snd_pcm_hw_params_get_buffer_size_max(const(snd_pcm_hw_params_t)* params, snd_pcm_uframes_t* val);
int snd_pcm_hw_params_test_buffer_size(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_uframes_t val);
int snd_pcm_hw_params_set_buffer_size(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_uframes_t val);
int snd_pcm_hw_params_set_buffer_size_min(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_uframes_t* val);
int snd_pcm_hw_params_set_buffer_size_max(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_uframes_t* val);
int snd_pcm_hw_params_set_buffer_size_minmax(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_uframes_t* min, snd_pcm_uframes_t* max);
int snd_pcm_hw_params_set_buffer_size_near(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_uframes_t* val);
int snd_pcm_hw_params_set_buffer_size_first(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_uframes_t* val);
int snd_pcm_hw_params_set_buffer_size_last(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, snd_pcm_uframes_t* val);

} /* !ALSA_LIBRARY_BUILD && !ALSA_PCM_OLD_HW_PARAMS_API */

int snd_pcm_hw_params_get_min_align(const(snd_pcm_hw_params_t)* params, snd_pcm_uframes_t *val);

/** \} */

/**
 * \defgroup PCM_SW_Params Software Parameters
 * \ingroup PCM
 * See the \ref pcm page for more details.
 * \{
 */

size_t snd_pcm_sw_params_sizeof();
/** \hideinitializer
 * \brief allocate an invalid #snd_pcm_sw_params_t using standard alloca
 * \param ptr returned pointer
 */
//#define snd_pcm_sw_params_alloca(ptr) __snd_alloca(ptr, snd_pcm_sw_params)
int snd_pcm_sw_params_malloc(snd_pcm_sw_params_t** ptr);
void snd_pcm_sw_params_free(snd_pcm_sw_params_t* obj);
void snd_pcm_sw_params_copy(snd_pcm_sw_params_t* dst, const snd_pcm_sw_params_t* src);
int snd_pcm_sw_params_get_boundary(const snd_pcm_sw_params_t* params, snd_pcm_uframes_t* val);

//#if !defined(ALSA_LIBRARY_BUILD) && !defined(ALSA_PCM_OLD_SW_PARAMS_API)
static if(!isVersion!"ALSA_LIBRARY_BUILD" || !isVersion!"ALSA_PCM_OLD_SW_PARAMS_API")
{

int snd_pcm_sw_params_set_tstamp_mode(snd_pcm_t* pcm, snd_pcm_sw_params_t* params, snd_pcm_tstamp_t val);
int snd_pcm_sw_params_get_tstamp_mode(const(snd_pcm_sw_params_t)* params, snd_pcm_tstamp_t* val);
int snd_pcm_sw_params_set_avail_min(snd_pcm_t* pcm, snd_pcm_sw_params_t* params, snd_pcm_uframes_t val);
int snd_pcm_sw_params_get_avail_min(const(snd_pcm_sw_params_t)* params, snd_pcm_uframes_t* val);
int snd_pcm_sw_params_set_period_event(snd_pcm_t* pcm, snd_pcm_sw_params_t* params, int val);
int snd_pcm_sw_params_get_period_event(const(snd_pcm_sw_params_t)* params, int* val);
int snd_pcm_sw_params_set_start_threshold(snd_pcm_t* pcm, snd_pcm_sw_params_t* params, snd_pcm_uframes_t val);
int snd_pcm_sw_params_get_start_threshold(const(snd_pcm_sw_params_t)* paramsm, snd_pcm_uframes_t* val);
int snd_pcm_sw_params_set_stop_threshold(snd_pcm_t* pcm, snd_pcm_sw_params_t* params, snd_pcm_uframes_t val);
int snd_pcm_sw_params_get_stop_threshold(const(snd_pcm_sw_params_t)* params, snd_pcm_uframes_t* val);
int snd_pcm_sw_params_set_silence_threshold(snd_pcm_t* pcm, snd_pcm_sw_params_t* params, snd_pcm_uframes_t val);
int snd_pcm_sw_params_get_silence_threshold(const(snd_pcm_sw_params_t)* params, snd_pcm_uframes_t* val);
int snd_pcm_sw_params_set_silence_size(snd_pcm_t* pcm, snd_pcm_sw_params_t* params, snd_pcm_uframes_t val);
int snd_pcm_sw_params_get_silence_size(const(snd_pcm_sw_params_t)* params, snd_pcm_uframes_t* val);

} /* !ALSA_LIBRARY_BUILD && !ALSA_PCM_OLD_SW_PARAMS_API */

/** \} */

/* include old API */
static if(!isVersion!"ALSA_LIBRARY_BUILD")
static if(isVersion!"ALSA_PCM_OLD_HW_PARAMS_API" || isVersion!"ALSA_PCM_OLD_SW_PARAMS_API")
public import deimos.alsa.pcm_old;

/**
 * \defgroup PCM_Access Access Mask Functions
 * \ingroup PCM
 * See the \ref pcm page for more details.
 * \{
 */

size_t snd_pcm_access_mask_sizeof();
/** \hideinitializer
 * \brief allocate an empty #snd_pcm_access_mask_t using standard alloca
 * \param ptr returned pointer
 */
//#define snd_pcm_access_mask_alloca(ptr) __snd_alloca(ptr, snd_pcm_access_mask)
int snd_pcm_access_mask_malloc(snd_pcm_access_mask_t** ptr);
void snd_pcm_access_mask_free(snd_pcm_access_mask_t* obj);
void snd_pcm_access_mask_copy(snd_pcm_access_mask_t* dst, const(snd_pcm_access_mask_t)* src);
void snd_pcm_access_mask_none(snd_pcm_access_mask_t* mask);
void snd_pcm_access_mask_any(snd_pcm_access_mask_t* mask);
int snd_pcm_access_mask_test(const(snd_pcm_access_mask_t)* mask, snd_pcm_access_t val);
int snd_pcm_access_mask_empty(const(snd_pcm_access_mask_t)* mask);
void snd_pcm_access_mask_set(snd_pcm_access_mask_t* mask, snd_pcm_access_t val);
void snd_pcm_access_mask_reset(snd_pcm_access_mask_t* mask, snd_pcm_access_t val);

/** \} */

/**
 * \defgroup PCM_Format Format Mask Functions
 * \ingroup PCM
 * See the \ref pcm page for more details.
 * \{
 */

size_t snd_pcm_format_mask_sizeof();
/** \hideinitializer
 * \brief allocate an empty #snd_pcm_format_mask_t using standard alloca
 * \param ptr returned pointer
 */
//#define snd_pcm_format_mask_alloca(ptr) __snd_alloca(ptr, snd_pcm_format_mask)
int snd_pcm_format_mask_malloc(snd_pcm_format_mask_t** ptr);
void snd_pcm_format_mask_free(snd_pcm_format_mask_t* obj);
void snd_pcm_format_mask_copy(snd_pcm_format_mask_t* dst, const(snd_pcm_format_mask_t)* src);
void snd_pcm_format_mask_none(snd_pcm_format_mask_t* mask);
void snd_pcm_format_mask_any(snd_pcm_format_mask_t* mask);
int snd_pcm_format_mask_test(const(snd_pcm_format_mask_t)* mask, snd_pcm_format_t val);
int snd_pcm_format_mask_empty(const(snd_pcm_format_mask_t)* mask);
void snd_pcm_format_mask_set(snd_pcm_format_mask_t* mask, snd_pcm_format_t val);
void snd_pcm_format_mask_reset(snd_pcm_format_mask_t* mask, snd_pcm_format_t val);

/** \} */

/**
 * \defgroup PCM_SubFormat Subformat Mask Functions
 * \ingroup PCM
 * See the \ref pcm page for more details.
 * \{
 */

size_t snd_pcm_subformat_mask_sizeof();
/** \hideinitializer
 * \brief allocate an empty #snd_pcm_subformat_mask_t using standard alloca
 * \param ptr returned pointer
 */
//#define snd_pcm_subformat_mask_alloca(ptr) __snd_alloca(ptr, snd_pcm_subformat_mask)
int snd_pcm_subformat_mask_malloc(snd_pcm_subformat_mask_t** ptr);
void snd_pcm_subformat_mask_free(snd_pcm_subformat_mask_t* obj);
void snd_pcm_subformat_mask_copy(snd_pcm_subformat_mask_t* dst, const(snd_pcm_subformat_mask_t)* src);
void snd_pcm_subformat_mask_none(snd_pcm_subformat_mask_t* mask);
void snd_pcm_subformat_mask_any(snd_pcm_subformat_mask_t* mask);
int snd_pcm_subformat_mask_test(const(snd_pcm_subformat_mask_t)* mask, snd_pcm_subformat_t val);
int snd_pcm_subformat_mask_empty(const(snd_pcm_subformat_mask_t)* mask);
void snd_pcm_subformat_mask_set(snd_pcm_subformat_mask_t* mask, snd_pcm_subformat_t val);
void snd_pcm_subformat_mask_reset(snd_pcm_subformat_mask_t* mask, snd_pcm_subformat_t val);

/** \} */

/**
 * \defgroup PCM_Status Status Functions
 * \ingroup PCM
 * See the \ref pcm page for more details.
 * \{
 */

size_t snd_pcm_status_sizeof();
/** \hideinitializer
 * \brief allocate an invalid #snd_pcm_status_t using standard alloca
 * \param ptr returned pointer
 */
//#define snd_pcm_status_alloca(ptr) __snd_alloca(ptr, snd_pcm_status)
int snd_pcm_status_malloc(snd_pcm_status_t** ptr);
void snd_pcm_status_free(snd_pcm_status_t* obj);
void snd_pcm_status_copy(snd_pcm_status_t* dst, const(snd_pcm_status_t)* src);
snd_pcm_state_t snd_pcm_status_get_state(const(snd_pcm_status_t)* obj);
void snd_pcm_status_get_trigger_tstamp(const(snd_pcm_status_t)* obj, snd_timestamp_t* ptr);
void snd_pcm_status_get_trigger_htstamp(const(snd_pcm_status_t)* obj, snd_htimestamp_t* ptr);
void snd_pcm_status_get_tstamp(const(snd_pcm_status_t)* obj, snd_timestamp_t* ptr);
void snd_pcm_status_get_htstamp(const(snd_pcm_status_t)* obj, snd_htimestamp_t* ptr);
void snd_pcm_status_get_audio_htstamp(const(snd_pcm_status_t)* obj, snd_htimestamp_t* ptr);
snd_pcm_sframes_t snd_pcm_status_get_delay(const(snd_pcm_status_t)* obj);
snd_pcm_uframes_t snd_pcm_status_get_avail(const(snd_pcm_status_t)* obj);
snd_pcm_uframes_t snd_pcm_status_get_avail_max(const(snd_pcm_status_t)* obj);
snd_pcm_uframes_t snd_pcm_status_get_overrange(const(snd_pcm_status_t)* obj);

/** \} */

/**
 * \defgroup PCM_Description Description Functions
 * \ingroup PCM
 * See the \ref pcm page for more details.
 * \{
 */

const(char)* snd_pcm_type_name(snd_pcm_type_t type);
const(char)* snd_pcm_stream_name(const snd_pcm_stream_t stream);
const(char)* snd_pcm_access_name(const snd_pcm_access_t _access);
const(char)* snd_pcm_format_name(const snd_pcm_format_t format);
const(char)* snd_pcm_format_description(const snd_pcm_format_t format);
const(char)* snd_pcm_subformat_name(const snd_pcm_subformat_t subformat);
const(char)* snd_pcm_subformat_description(const snd_pcm_subformat_t subformat);
snd_pcm_format_t snd_pcm_format_value(const(char)* name);
const(char)* snd_pcm_tstamp_mode_name(const snd_pcm_tstamp_t mode);
const(char)* snd_pcm_state_name(const snd_pcm_state_t state);

/** \} */

/**
 * \defgroup PCM_Dump Debug Functions
 * \ingroup PCM
 * See the \ref pcm page for more details.
 * \{
 */

int snd_pcm_dump(snd_pcm_t* pcm, snd_output_t* out_);
int snd_pcm_dump_hw_setup(snd_pcm_t* pcm, snd_output_t* out_);
int snd_pcm_dump_sw_setup(snd_pcm_t* pcm, snd_output_t* out_);
int snd_pcm_dump_setup(snd_pcm_t* pcm, snd_output_t* out_);
int snd_pcm_hw_params_dump(snd_pcm_hw_params_t* params, snd_output_t* out_);
int snd_pcm_sw_params_dump(snd_pcm_sw_params_t* params, snd_output_t* out_);
int snd_pcm_status_dump(snd_pcm_status_t *status, snd_output_t* out_);

/** \} */

/**
 * \defgroup PCM_Direct Direct Access (MMAP) Functions
 * \ingroup PCM
 * See the \ref pcm page for more details.
 * \{
 */

int snd_pcm_mmap_begin(snd_pcm_t* pcm,
               const(snd_pcm_channel_area_t*)* areas,
               snd_pcm_uframes_t* offset,
               snd_pcm_uframes_t* frames);
snd_pcm_sframes_t snd_pcm_mmap_commit(snd_pcm_t* pcm,
                      snd_pcm_uframes_t offset,
                      snd_pcm_uframes_t frames);
snd_pcm_sframes_t snd_pcm_mmap_writei(snd_pcm_t* pcm, const(void)* buffer, snd_pcm_uframes_t size);
snd_pcm_sframes_t snd_pcm_mmap_readi(snd_pcm_t* pcm, void* buffer, snd_pcm_uframes_t size);
snd_pcm_sframes_t snd_pcm_mmap_writen(snd_pcm_t* pcm, void** bufs, snd_pcm_uframes_t size);
snd_pcm_sframes_t snd_pcm_mmap_readn(snd_pcm_t* pcm, void** bufs, snd_pcm_uframes_t size);                                                                

/** \} */

/**
 * \defgroup PCM_Helpers Helper Functions
 * \ingroup PCM
 * See the \ref pcm page for more details.
 * \{
 */

int snd_pcm_format_signed(snd_pcm_format_t format);
int snd_pcm_format_unsigned(snd_pcm_format_t format);
int snd_pcm_format_linear(snd_pcm_format_t format);
int snd_pcm_format_float(snd_pcm_format_t format);
int snd_pcm_format_little_endian(snd_pcm_format_t format);
int snd_pcm_format_big_endian(snd_pcm_format_t format);
int snd_pcm_format_cpu_endian(snd_pcm_format_t format);
int snd_pcm_format_width(snd_pcm_format_t format);          /* in bits */
int snd_pcm_format_physical_width(snd_pcm_format_t format);     /* in bits */
snd_pcm_format_t snd_pcm_build_linear_format(int width, int pwidth, int unsignd, int big_endian);
ptrdiff_t snd_pcm_format_size(snd_pcm_format_t format, size_t samples);
ubyte snd_pcm_format_silence(snd_pcm_format_t format);
ushort snd_pcm_format_silence_16(snd_pcm_format_t format);
uint snd_pcm_format_silence_32(snd_pcm_format_t format);
ulong snd_pcm_format_silence_64(snd_pcm_format_t format);
int snd_pcm_format_set_silence(snd_pcm_format_t format, void* buf, uint samples);

snd_pcm_sframes_t snd_pcm_bytes_to_frames(snd_pcm_t* pcm, ptrdiff_t bytes);
ptrdiff_t snd_pcm_frames_to_bytes(snd_pcm_t* pcm, snd_pcm_sframes_t frames);
long snd_pcm_bytes_to_samples(snd_pcm_t* pcm, ptrdiff_t bytes);
ptrdiff_t snd_pcm_samples_to_bytes(snd_pcm_t* pcm, long samples);

int snd_pcm_area_silence(const(snd_pcm_channel_area_t)* dst_channel, snd_pcm_uframes_t dst_offset,
             uint samples, snd_pcm_format_t format);
int snd_pcm_areas_silence(const(snd_pcm_channel_area_t)* dst_channels, snd_pcm_uframes_t dst_offset,
              uint channels, snd_pcm_uframes_t frames, snd_pcm_format_t format);
int snd_pcm_area_copy(const(snd_pcm_channel_area_t)* dst_channel, snd_pcm_uframes_t dst_offset,
              const(snd_pcm_channel_area_t)* src_channel, snd_pcm_uframes_t src_offset,
              uint samples, snd_pcm_format_t format);
int snd_pcm_areas_copy(const(snd_pcm_channel_area_t)* dst_channels, snd_pcm_uframes_t dst_offset,
               const(snd_pcm_channel_area_t)* src_channels, snd_pcm_uframes_t src_offset,
               uint channels, snd_pcm_uframes_t frames, snd_pcm_format_t format);

/** \} */

/**
 * \defgroup PCM_Hook Hook Extension
 * \ingroup PCM
 * See the \ref pcm page for more details.
 * \{
 */

/** type of pcm hook */
enum snd_pcm_hook_type_t {
    SND_PCM_HOOK_TYPE_HW_PARAMS = 0,
    SND_PCM_HOOK_TYPE_HW_FREE,
    SND_PCM_HOOK_TYPE_CLOSE,
    SND_PCM_HOOK_TYPE_LAST = SND_PCM_HOOK_TYPE_CLOSE
}

/** PCM hook container */
struct snd_pcm_hook_t;
/** PCM hook callback function */
alias int function(snd_pcm_hook_t* hook) snd_pcm_hook_func_t;
snd_pcm_t *snd_pcm_hook_get_pcm(snd_pcm_hook_t* hook);
void* snd_pcm_hook_get_private(snd_pcm_hook_t* hook);
void snd_pcm_hook_set_private(snd_pcm_hook_t* hook, void* private_data);
int snd_pcm_hook_add(snd_pcm_hook_t** hookp, snd_pcm_t* pcm,
             snd_pcm_hook_type_t type,
             snd_pcm_hook_func_t func, void* private_data);
int snd_pcm_hook_remove(snd_pcm_hook_t* hook);

/** \} */

/**
 * \defgroup PCM_Scope Scope Plugin Extension
 * \ingroup PCM
 * See the \ref pcm page for more details.
 * \{
 */

/** #SND_PCM_TYPE_METER scope functions */
struct snd_pcm_scope_ops_t {
    /** \brief Enable and prepare it using current params
     * \param scope scope handle
     */
    int function(snd_pcm_scope_t* scope_) enable;
    /** \brief Disable
     * \param scope scope handle
     */
    void function(snd_pcm_scope_t* scope_) disable;
    /** \brief PCM has been started
     * \param scope scope handle
     */
    void function(snd_pcm_scope_t* scope_) start;
    /** \brief PCM has been stopped
     * \param scope scope handle
     */
    void function(snd_pcm_scope_t* scope_) stop;
    /** \brief New frames are present
     * \param scope scope handle
     */
    void function(snd_pcm_scope_t* scope_) update;
    /** \brief Reset status
     * \param scope scope handle
     */
    void function(snd_pcm_scope_t* scope_) reset;
    /** \brief PCM is closing
     * \param scope scope handle
     */
    void function(snd_pcm_scope_t* scope_) close;
}

snd_pcm_uframes_t snd_pcm_meter_get_bufsize(snd_pcm_t* pcm);
uint snd_pcm_meter_get_channels(snd_pcm_t* pcm);
uint snd_pcm_meter_get_rate(snd_pcm_t* pcm);
snd_pcm_uframes_t snd_pcm_meter_get_now(snd_pcm_t* pcm);
snd_pcm_uframes_t snd_pcm_meter_get_boundary(snd_pcm_t* pcm);
int snd_pcm_meter_add_scope(snd_pcm_t* pcm, snd_pcm_scope_t* scope_);
snd_pcm_scope_t* snd_pcm_meter_search_scope(snd_pcm_t* pcm, const(char)* name);
int snd_pcm_scope_malloc(snd_pcm_scope_t** ptr);
void snd_pcm_scope_set_ops(snd_pcm_scope_t* scope_,
               const(snd_pcm_scope_ops_t)* val);
void snd_pcm_scope_set_name(snd_pcm_scope_t* scope_, const(char)* val);
const(char)* snd_pcm_scope_get_name(snd_pcm_scope_t* scope_);
void* snd_pcm_scope_get_callback_private(snd_pcm_scope_t* scope_);
void snd_pcm_scope_set_callback_private(snd_pcm_scope_t* scope_, void* val);
int snd_pcm_scope_s16_open(snd_pcm_t* pcm, const(char)* name,
               snd_pcm_scope_t** scopep);
short* snd_pcm_scope_s16_get_channel_buffer(snd_pcm_scope_t* scope_,
                          uint channel);

/** \} */

/**
 * \defgroup PCM_Simple Simple setup functions
 * \ingroup PCM
 * See the \ref pcm page for more details.
 * \{
 */

/** Simple PCM latency type */
enum snd_spcm_latency_t {
    /** standard latency - for standard playback or capture
            (estimated latency in one direction 350ms) */
    SND_SPCM_LATENCY_STANDARD = 0,
    /** medium latency - software phones etc.
        (estimated latency in one direction maximally 25ms */
    SND_SPCM_LATENCY_MEDIUM,
    /** realtime latency - realtime applications (effect processors etc.)
        (estimated latency in one direction 5ms and better) */
    SND_SPCM_LATENCY_REALTIME
}

/** Simple PCM xrun type */
enum snd_spcm_xrun_type_t {
    /** driver / library will ignore all xruns, the stream runs forever */
    SND_SPCM_XRUN_IGNORE = 0,
    /** driver / library stops the stream when an xrun occurs */
    SND_SPCM_XRUN_STOP
}

/** Simple PCM duplex type */
enum snd_spcm_duplex_type_t {
    /** liberal duplex - the buffer and period sizes might not match */
    SND_SPCM_DUPLEX_LIBERAL = 0,
    /** pedantic duplex - the buffer and period sizes MUST match */
    SND_SPCM_DUPLEX_PEDANTIC
}

int snd_spcm_init(snd_pcm_t* pcm,
          uint rate,
          uint channels,
          snd_pcm_format_t format,
          snd_pcm_subformat_t subformat,
          snd_spcm_latency_t latency,
          snd_pcm_access_t _access,
          snd_spcm_xrun_type_t xrun_type);

int snd_spcm_init_duplex(snd_pcm_t* playback_pcm,
             snd_pcm_t* capture_pcm,
             uint rate,
             uint channels,
             snd_pcm_format_t format,
             snd_pcm_subformat_t subformat,
             snd_spcm_latency_t latency,
             snd_pcm_access_t _access,
             snd_spcm_xrun_type_t xrun_type,
             snd_spcm_duplex_type_t duplex_type);

int snd_spcm_init_get_params(snd_pcm_t* pcm,
                 uint* rate,
                 snd_pcm_uframes_t* buffer_size,
                 snd_pcm_uframes_t* period_size);

/** \} */

/**
 * \defgroup PCM_Deprecated Deprecated Functions
 * \ingroup PCM
 * See the \ref pcm page for more details.
 * \{
 */

/* Deprecated functions, for compatibility */
deprecated:
const(char)* snd_pcm_start_mode_name(snd_pcm_start_t mode);
const(char)* snd_pcm_xrun_mode_name(snd_pcm_xrun_t mode);
int snd_pcm_sw_params_set_start_mode(snd_pcm_t* pcm, snd_pcm_sw_params_t* params, snd_pcm_start_t val);
snd_pcm_start_t snd_pcm_sw_params_get_start_mode(const snd_pcm_sw_params_t* params);
int snd_pcm_sw_params_set_xrun_mode(snd_pcm_t* pcm, snd_pcm_sw_params_t* params, snd_pcm_xrun_t val);
snd_pcm_xrun_t snd_pcm_sw_params_get_xrun_mode(const snd_pcm_sw_params_t* params);
//#if !defined(ALSA_LIBRARY_BUILD) && !defined(ALSA_PCM_OLD_SW_PARAMS_API)
static if(!isVersion!"ALSA_LIBRARY_BUILD" && !isVersion!"ALSA_PCM_OLD_SW_PARAMS_API")
{
int snd_pcm_sw_params_set_xfer_align(snd_pcm_t* pcm, snd_pcm_sw_params_t* params, snd_pcm_uframes_t val);
int snd_pcm_sw_params_get_xfer_align(const snd_pcm_sw_params_t* params, snd_pcm_uframes_t *val);
int snd_pcm_sw_params_set_sleep_min(snd_pcm_t* pcm, snd_pcm_sw_params_t* params, uint val);
int snd_pcm_sw_params_get_sleep_min(const snd_pcm_sw_params_t* params, uint* val);
}
//#endif /* !ALSA_LIBRARY_BUILD && !ALSA_PCM_OLD_SW_PARAMS_API */
//#if !defined(ALSA_LIBRARY_BUILD) && !defined(ALSA_PCM_OLD_HW_PARAMS_API)
static if(!isVersion!"ALSA_LIBRARY_BUILD" && !isVersion!"ALSA_PCM_OLD_HW_PARAMS_API")
{
int snd_pcm_hw_params_get_tick_time(const(snd_pcm_hw_params_t)* params, uint* val, int* dir);
int snd_pcm_hw_params_get_tick_time_min(const(snd_pcm_hw_params_t)* params, uint* val, int* dir);
int snd_pcm_hw_params_get_tick_time_max(const(snd_pcm_hw_params_t)* params, uint* val, int* dir);
int snd_pcm_hw_params_test_tick_time(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint val, int dir);
int snd_pcm_hw_params_set_tick_time(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint val, int dir);
int snd_pcm_hw_params_set_tick_time_min(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);
int snd_pcm_hw_params_set_tick_time_max(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);
int snd_pcm_hw_params_set_tick_time_minmax(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint *min, int* mindir, uint* max, int *maxdir);
int snd_pcm_hw_params_set_tick_time_near(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);
int snd_pcm_hw_params_set_tick_time_first(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);
int snd_pcm_hw_params_set_tick_time_last(snd_pcm_t* pcm, snd_pcm_hw_params_t* params, uint* val, int* dir);
}
//#endif /* !ALSA_LIBRARY_BUILD && !ALSA_PCM_OLD_HW_PARAMS_API */

/** \} */
