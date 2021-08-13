#!/bin/bash

function latest_tag () {
  curl -s https://api.github.com/repos/$1/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'
}

COMPOSE_VER=$(latest_tag 'docker/compose')
GOLANG_VER="1.16.7"
SIMPLENOTE_VER=$(latest_tag 'Automattic/simplenote-electron')
TER_VER=$(latest_tag 'hashicorp/terraform')
