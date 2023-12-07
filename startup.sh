#!/bin/bash

if [ -z `which docsify` ]; then
  echo '请先安装 [docsify](https://docsify.js.org)'
fi

docsify serve .