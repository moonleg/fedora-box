#!/bin/bash

podman save -o fedora-box-1.0.tar localhost/fedora-box:1.0

gzip --best --verbose fedora-box-1.0.tar
