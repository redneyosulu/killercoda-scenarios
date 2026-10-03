#!/bin/bash
D=/tmp/dlab-m04-03
mkdir -p "$D"
export DEBIAN_FRONTEND=noninteractive
pkg_for() { case "$1" in curl) echo curl;; ss) echo iproute2;; pkill|pgrep) echo procps;; openssl) echo openssl;; git) echo git;; python3) echo python3;; runuser) echo login;; nc) echo netcat-openbsd;; find) echo findutils;; shellcheck) echo shellcheck;; jq) echo jq;; *) echo "$1";; esac; }
miss=""
for t in curl ss pkill openssl git python3 runuser find nc shellcheck jq; do command -v "$t" >/dev/null 2>&1 || miss="$miss $(pkg_for $t)"; done
if [ -n "$miss" ]; then apt-get update -qq && apt-get install -y -qq $miss; fi
git config --global user.email "learner@example.invalid" 2>/dev/null || true
git config --global user.name "Learner" 2>/dev/null || true
git config --global init.defaultBranch main 2>/dev/null || true
mkdir -p "$D"

touch "$D/.ready" && chmod 600 "$D/.ready"
