/*
 * Clawspeek -- minimalistic Claws Mail password recovery utility
 * Copyright (C) 2011-2013 Ricardo Mones and the Claws Mail team
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include <string.h>
#include <glib.h>
#include "passcrypt.h"

int main(int argc, char*argv[])
{
	gchar *buf;
	gint  len;

	if (argc < 2) {
		return -1;
	}
	buf = g_strnfill(1024, '\0');
	len = base64_decode(buf, &argv[1][1], strlen(argv[1]) - 1);
	passcrypt_decrypt(buf, len);
	g_print("%s -> %s\n", argv[1], buf);
	g_free(buf);
	return 0;
}

