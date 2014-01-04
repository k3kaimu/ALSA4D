module deimos.alsa.version_;

/*
 *  version.h
 */

enum SND_LIB_MAJOR =       1 /**< major number of library version */;
enum SND_LIB_MINOR =       0 /**< minor number of library version */;
enum SND_LIB_SUBMINOR =    27 /**< subminor number of library version */;
enum SND_LIB_EXTRAVER =    1000000 /**< extra version number, used mainly for betas */;
/** library version */
enum SND_LIB_VERSION = ((SND_LIB_MAJOR<<16)|
                         (SND_LIB_MINOR<<8)|
                          SND_LIB_SUBMINOR);
/** library version (string) */
enum SND_LIB_VERSION_STR = "1.0.27.2";

