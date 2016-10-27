#!/bin/bash

#docker run -d dckr-webshot
docker run --rm \
-v `pwd`:/home \
-w /home \
--name=webshot \
dckr-webshot
