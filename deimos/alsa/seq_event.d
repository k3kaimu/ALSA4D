/**
 * \file include/seq_event.h
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
module deimos.alsa.seq_event;

extern(C):
nothrow:

/**
 *  \defgroup SeqEvents Sequencer Event Definitions
 *  Sequencer Event Definitions
 *  \ingroup Sequencer
 *  \{
 */

/**
 * Sequencer event data type
 */
alias ubyte snd_seq_event_type_t;

/** Sequencer event type */
enum snd_seq_event_type {
    /** system status; event data type = #snd_seq_result_t */
    SND_SEQ_EVENT_SYSTEM = 0,
    /** returned result status; event data type = #snd_seq_result_t */
    SND_SEQ_EVENT_RESULT,

    /** note on and off with duration; event data type = #snd_seq_ev_note_t */
    SND_SEQ_EVENT_NOTE = 5,
    /** note on; event data type = #snd_seq_ev_note_t */
    SND_SEQ_EVENT_NOTEON,
    /** note off; event data type = #snd_seq_ev_note_t */
    SND_SEQ_EVENT_NOTEOFF,
    /** key pressure change (aftertouch); event data type = #snd_seq_ev_note_t */
    SND_SEQ_EVENT_KEYPRESS,
    
    /** controller; event data type = #snd_seq_ev_ctrl_t */
    SND_SEQ_EVENT_CONTROLLER = 10,
    /** program change; event data type = #snd_seq_ev_ctrl_t */
    SND_SEQ_EVENT_PGMCHANGE,
    /** channel pressure; event data type = #snd_seq_ev_ctrl_t */
    SND_SEQ_EVENT_CHANPRESS,
    /** pitchwheel; event data type = #snd_seq_ev_ctrl_t; data is from -8192 to 8191) */
    SND_SEQ_EVENT_PITCHBEND,
    /** 14 bit controller value; event data type = #snd_seq_ev_ctrl_t */
    SND_SEQ_EVENT_CONTROL14,
    /** 14 bit NRPN;  event data type = #snd_seq_ev_ctrl_t */
    SND_SEQ_EVENT_NONREGPARAM,
    /** 14 bit RPN; event data type = #snd_seq_ev_ctrl_t */
    SND_SEQ_EVENT_REGPARAM,

    /** SPP with LSB and MSB values; event data type = #snd_seq_ev_ctrl_t */
    SND_SEQ_EVENT_SONGPOS = 20,
    /** Song Select with song ID number; event data type = #snd_seq_ev_ctrl_t */
    SND_SEQ_EVENT_SONGSEL,
    /** midi time code quarter frame; event data type = #snd_seq_ev_ctrl_t */
    SND_SEQ_EVENT_QFRAME,
    /** SMF Time Signature event; event data type = #snd_seq_ev_ctrl_t */
    SND_SEQ_EVENT_TIMESIGN,
    /** SMF Key Signature event; event data type = #snd_seq_ev_ctrl_t */
    SND_SEQ_EVENT_KEYSIGN,
            
    /** MIDI Real Time Start message; event data type = #snd_seq_ev_queue_control_t */
    SND_SEQ_EVENT_START = 30,
    /** MIDI Real Time Continue message; event data type = #snd_seq_ev_queue_control_t */
    SND_SEQ_EVENT_CONTINUE,
    /** MIDI Real Time Stop message; event data type = #snd_seq_ev_queue_control_t */
    SND_SEQ_EVENT_STOP,
    /** Set tick queue position; event data type = #snd_seq_ev_queue_control_t */
    SND_SEQ_EVENT_SETPOS_TICK,
    /** Set real-time queue position; event data type = #snd_seq_ev_queue_control_t */
    SND_SEQ_EVENT_SETPOS_TIME,
    /** (SMF) Tempo event; event data type = #snd_seq_ev_queue_control_t */
    SND_SEQ_EVENT_TEMPO,
    /** MIDI Real Time Clock message; event data type = #snd_seq_ev_queue_control_t */
    SND_SEQ_EVENT_CLOCK,
    /** MIDI Real Time Tick message; event data type = #snd_seq_ev_queue_control_t */
    SND_SEQ_EVENT_TICK,
    /** Queue timer skew; event data type = #snd_seq_ev_queue_control_t */
    SND_SEQ_EVENT_QUEUE_SKEW,
    /** Sync position changed; event data type = #snd_seq_ev_queue_control_t */
    SND_SEQ_EVENT_SYNC_POS,

    /** Tune request; event data type = none */
    SND_SEQ_EVENT_TUNE_REQUEST = 40,
    /** Reset to power-on state; event data type = none */
    SND_SEQ_EVENT_RESET,
    /** Active sensing event; event data type = none */
    SND_SEQ_EVENT_SENSING,

    /** Echo-back event; event data type = any type */
    SND_SEQ_EVENT_ECHO = 50,
    /** OSS emulation raw event; event data type = any type */
    SND_SEQ_EVENT_OSS,

    /** New client has connected; event data type = #snd_seq_addr_t */
    SND_SEQ_EVENT_CLIENT_START = 60,
    /** Client has left the system; event data type = #snd_seq_addr_t */
    SND_SEQ_EVENT_CLIENT_EXIT,
    /** Client status/info has changed; event data type = #snd_seq_addr_t */
    SND_SEQ_EVENT_CLIENT_CHANGE,
    /** New port was created; event data type = #snd_seq_addr_t */
    SND_SEQ_EVENT_PORT_START,
    /** Port was deleted from system; event data type = #snd_seq_addr_t */
    SND_SEQ_EVENT_PORT_EXIT,
    /** Port status/info has changed; event data type = #snd_seq_addr_t */
    SND_SEQ_EVENT_PORT_CHANGE,

    /** Ports connected; event data type = #snd_seq_connect_t */
    SND_SEQ_EVENT_PORT_SUBSCRIBED,
    /** Ports disconnected; event data type = #snd_seq_connect_t */
    SND_SEQ_EVENT_PORT_UNSUBSCRIBED,

    /** user-defined event; event data type = any (fixed size) */
    SND_SEQ_EVENT_USR0 = 90,
    /** user-defined event; event data type = any (fixed size) */
    SND_SEQ_EVENT_USR1,
    /** user-defined event; event data type = any (fixed size) */
    SND_SEQ_EVENT_USR2,
    /** user-defined event; event data type = any (fixed size) */
    SND_SEQ_EVENT_USR3,
    /** user-defined event; event data type = any (fixed size) */
    SND_SEQ_EVENT_USR4,
    /** user-defined event; event data type = any (fixed size) */
    SND_SEQ_EVENT_USR5,
    /** user-defined event; event data type = any (fixed size) */
    SND_SEQ_EVENT_USR6,
    /** user-defined event; event data type = any (fixed size) */
    SND_SEQ_EVENT_USR7,
    /** user-defined event; event data type = any (fixed size) */
    SND_SEQ_EVENT_USR8,
    /** user-defined event; event data type = any (fixed size) */
    SND_SEQ_EVENT_USR9,

    /** system exclusive data (variable length);  event data type = #snd_seq_ev_ext_t */
    SND_SEQ_EVENT_SYSEX = 130,
    /** error event;  event data type = #snd_seq_ev_ext_t */
    SND_SEQ_EVENT_BOUNCE,
    /** reserved for user apps;  event data type = #snd_seq_ev_ext_t */
    SND_SEQ_EVENT_USR_VAR0 = 135,
    /** reserved for user apps; event data type = #snd_seq_ev_ext_t */
    SND_SEQ_EVENT_USR_VAR1,
    /** reserved for user apps; event data type = #snd_seq_ev_ext_t */
    SND_SEQ_EVENT_USR_VAR2,
    /** reserved for user apps; event data type = #snd_seq_ev_ext_t */
    SND_SEQ_EVENT_USR_VAR3,
    /** reserved for user apps; event data type = #snd_seq_ev_ext_t */
    SND_SEQ_EVENT_USR_VAR4,

    /** NOP; ignored in any case */
    SND_SEQ_EVENT_NONE = 255
};


/** Sequencer event address */
struct snd_seq_addr_t {
    ubyte client;   /**< Client id */
    ubyte port; /**< Port id */
}

/** Connection (subscription) between ports */
struct snd_seq_connect_t {
    snd_seq_addr_t sender;  /**< sender address */
    snd_seq_addr_t dest;    /**< destination address */
}


/** Real-time data record */
struct snd_seq_real_time_t {
    uint tv_sec;        /**< seconds */
    uint tv_nsec;       /**< nanoseconds */
}

/** (MIDI) Tick-time data record */
alias uint snd_seq_tick_time_t;

/** unioned time stamp */
union snd_seq_timestamp_t {
    snd_seq_tick_time_t tick;   /**< tick-time */
    snd_seq_real_time_t time;  /**< real-time */
}


/**
 * Event mode flags
 *
 * NOTE: only 8 bits available!
 */
enum SND_SEQ_TIME_STAMP_TICK =     (0<<0)  /**< timestamp in clock ticks */;
enum SND_SEQ_TIME_STAMP_REAL =     (1<<0)  /**< timestamp in real time */;
enum SND_SEQ_TIME_STAMP_MASK =     (1<<0)  /**< mask for timestamp bits */;

enum SND_SEQ_TIME_MODE_ABS =       (0<<1)  /**< absolute timestamp */;
enum SND_SEQ_TIME_MODE_REL =       (1<<1)  /**< relative to current time */;
enum SND_SEQ_TIME_MODE_MASK =      (1<<1)  /**< mask for time mode bits */;

enum SND_SEQ_EVENT_LENGTH_FIXED =  (0<<2)  /**< fixed event size */;
enum SND_SEQ_EVENT_LENGTH_VARIABLE =   (1<<2)  /**< variable event size */;
enum SND_SEQ_EVENT_LENGTH_VARUSR = (2<<2)  /**< variable event size - user memory space */;
enum SND_SEQ_EVENT_LENGTH_MASK =   (3<<2)  /**< mask for event length bits */;

enum SND_SEQ_PRIORITY_NORMAL =     (0<<4)  /**< normal priority */;
enum SND_SEQ_PRIORITY_HIGH =       (1<<4)  /**< event should be processed before others */;
enum SND_SEQ_PRIORITY_MASK =       (1<<4)  /**< mask for priority bits */;


/** Note event */
struct snd_seq_ev_note_t {
    ubyte channel;      /**< channel number */
    ubyte note;     /**< note */
    ubyte velocity;     /**< velocity */
    ubyte off_velocity; /**< note-off velocity; only for #SND_SEQ_EVENT_NOTE */
    uint duration;      /**< duration until note-off; only for #SND_SEQ_EVENT_NOTE */
}

/** Controller event */
struct snd_seq_ev_ctrl_t {
    ubyte channel;      /**< channel number */
    ubyte unused[3];    /**< reserved */
    uint param;     /**< control parameter */
    int value;       /**< control value */
}

/** generic set of bytes (12x8 bit) */
struct snd_seq_ev_raw8_t {
    ubyte d[12];        /**< 8 bit value */
}

/** generic set of integers (3x32 bit) */
struct snd_seq_ev_raw32_t {
    uint d[3];      /**< 32 bit value */
}

/** external stored data */
align(1) struct snd_seq_ev_ext_t {
    uint len;       /**< length of data */
    void *ptr;          /**< pointer to data (note: can be 64-bit) */
} /*__attribute__((packed));*/
/** external stored data */
//struct snd_seq_ev_ext_t;
//#ifdef DOC_HIDDEN
/* redefine typedef for stupid doxygen */
//typedef snd_seq_ev_ext snd_seq_ev_ext_t;
//#endif

/** Result events */
struct snd_seq_result_t {
    int event;      /**< processed event type */
    int result;     /**< status */
}

/** Queue skew values */
struct snd_seq_queue_skew_t {
    uint value; /**< skew value */
    uint base;  /**< skew base */
}

/** queue timer control */
struct snd_seq_ev_queue_control_t {
    ubyte queue;            /**< affected queue */
    ubyte unused[3];        /**< reserved */
    union Param {
        int value;       /**< affected value (e.g. tempo) */
        snd_seq_timestamp_t time;   /**< time */
        uint position;      /**< sync position */
        snd_seq_queue_skew_t skew;  /**< queue skew */
        uint d32[2];        /**< any data */
        ubyte d8[8];        /**< any data */
    } Param param;                /**< data value union */
}


/** Sequencer event */
struct snd_seq_event_t {
    snd_seq_event_type_t type;  /**< event type */
    ubyte flags;        /**< event flags */
    ubyte tag;      /**< tag */
    
    ubyte queue;        /**< schedule queue */
    snd_seq_timestamp_t time;   /**< schedule time */

    snd_seq_addr_t source;      /**< source address */
    snd_seq_addr_t dest;        /**< destination address */

    union Data {
        snd_seq_ev_note_t note;     /**< note information */
        snd_seq_ev_ctrl_t control;  /**< MIDI control information */
        snd_seq_ev_raw8_t raw8;     /**< raw8 data */
        snd_seq_ev_raw32_t raw32;   /**< raw32 data */
        snd_seq_ev_ext_t ext;       /**< external data */
        snd_seq_ev_queue_control_t queue; /**< queue control */
        snd_seq_timestamp_t time;   /**< timestamp */
        snd_seq_addr_t addr;        /**< address */
        snd_seq_connect_t connect;  /**< connect information */
        snd_seq_result_t result;    /**< operation result code */
    } Data data;             /**< event data... */
}
