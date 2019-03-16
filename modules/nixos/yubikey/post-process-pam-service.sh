#!/bin/sh -eu

IN="$1"
OUT="$2"
USE_2FACTOR="$3"
U2F_ARGS="$4"

if [ -n "$USE_2FACTOR" ]; then
    sed -n "/^auth.*pam_u2f/{
        # add pattern space to hold space
        h
        :loop
        # print pattern space and fetch next line
        n
        # if we find pam_unix as sufficient we must change it to required
        # because this rule will go above pam_u2f in that case pam_u2f must be
        # sufficient as it will go after pam_unix
        /^auth sufficient.*pam_unix/{
                    s/auth sufficient/auth required/
                    p
                    # exchange pattern space with hold space
                    x
                    s#\(auth sufficient .*pam_u2f.so\)#\1 $U2F_ARGS#
                    bexit
        }
        # pam_unix was required, this means that there will be a followup rule
        # which is sufficient in that case pam_u2f must be required as it will
        # go before a sufficient rule
        /^auth required.*pam_unix/{
                    p
                    # exchange pattern space with hold space
                    x
                    s#auth sufficient \(.*pam_u2f.so\)#auth required \1 $U2F_ARGS#
                    bexit
        }
        # if we haven't found a pam_unix rule processing is aborted
        \$q1

        # append line to hold space with newline prepended
        H
        # exchange pattern space with hold space
        x
        # bubble the first matching rule to the bottom of the hold space
        s/\([^\n]*\)\n\([^\n]*\)\$/\2\n\1/
        # exchange pattern space with hold space
        x
        bloop
        }
        # print remaining contents
        :exit
        p" $IN > $OUT || cp $IN $OUT
else
    sed "s#\(^auth .*pam_u2f.so\)#\1 $U2F_ARGS#" $IN > $OUT
fi
