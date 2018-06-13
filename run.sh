#!/bin/sh

if [ "$1" = "--root" ]; then
    shift
    extra="--uid 0 --gid 0"
fi

if [ "$#" = 0 ]; then
    set -- bash --login -i
fi

exec env -i LANG="$LANG" \
            USER=root \
            TERM="$TERM" \
            LOGNAME=root \
            PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
            bwrap --unshare-all --share-net \
            --bind "$(dirname "$0")" / \
            --proc /proc --dev /dev \
            $extra \
            "$@"
