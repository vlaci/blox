#! /usr/bin/env nix-shell
#! nix-shell -i sh -p jq gettext
set -eu

cfg="$1"
out="$2"
version="$3"

export version

fname=$(jq -r .fetch.name ${cfg} | envsubst)
url=$(jq -r .fetch.url ${cfg} | envsubst)
name=$(jq -r .name ${cfg} | envsubst)
sha256=$(nix-prefetch-url ${url})

jq -n  \
    --arg name "$name" \
    --arg version "$version" \
    --arg fname "$fname" \
    --arg furl "$url" \
    --arg fsha256 "$sha256" \
    '{ name: $name, version: $version, fetch: { name: $fname, url: $furl, sha256: $fsha256 }}' \
    > "$out"

git commit \
    --message "pkgs/${name}: updating to '${version}'" \
    --edit \
    --verbose \
    -- \
    "$cfg" "$out"
