#include "sqlite3.h"
#include "crsqlite.h"
int sqlite3_spellfix_init(sqlite3*, char**, const sqlite3_api_routines*);
int sqlite3_compress_init(sqlite3*, char**, const sqlite3_api_routines*);
int sqlite3_vec_init(sqlite3*, char**, const sqlite3_api_routines*);
int sqlite3_crsqlite_init(sqlite3*, char**, const sqlite3_api_routines*);
void sqlite3_extra_init(void) {
  sqlite3_auto_extension((void (*)(void))sqlite3_spellfix_init);
  sqlite3_auto_extension((void (*)(void))sqlite3_compress_init);
  sqlite3_auto_extension((void (*)(void))sqlite3_vec_init);
  sqlite3_auto_extension((void (*)(void))sqlite3_crsqlite_init);
}
