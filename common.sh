#!/bin/bash

function latest_tag () {
  curl -s https://api.github.com/repos/$1/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'
}

COMPOSE_VER=$(latest_tag 'docker/compose')
GOLANG_PKG=$(curl "https://go.dev/dl/?mode=json" | jq -r '.[0].files[].filename | select(test("go.*.linux-amd64.tar.gz"))')
TER_VER=$(latest_tag 'hashicorp/terraform')
