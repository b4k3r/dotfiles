#!/bin/bash

GOLANG_PKG=$(curl "https://go.dev/dl/?mode=json" | jq -r '.[0].files[].filename | select(test("go.*.linux-amd64.tar.gz"))')
