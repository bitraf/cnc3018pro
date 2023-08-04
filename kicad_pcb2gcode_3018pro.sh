#!/bin/bash -xe
# Generate front+back mill + cut gcode
#
# Based on https://gist.github.com/dzervas/fb439ae2e1c94096a024ce610f8294c8

BASE_PATH=usbled/out
OUT_PATH=pcb2gcodetest

mkdir -p ${OUT_PATH}

pcb2gcode \
  --back ${BASE_PATH}/*-B_Cu.gbr \
  --front ${BASE_PATH}/*-F_Cu.gbr \
  --outline ${BASE_PATH}/*-Edge_Cuts.gbr \
  --drill ${BASE_PATH}/**.drl \
  --output-dir ${OUT_PATH} \
  --config millprojectest.cfg

  
# Strip tool changes from drill file
#
# notooldrill.ngc is the drill file without tool changes
grep -v "^T" milldrill.ngc > notooldrill.ngc

# Remove unsupported irrelevant g-code
#grep -v "^G64" front.ngc | grep -v "^M6" > fix-front.ngc
#grep -v "^G64" back.ngc | grep -v "^M6" > fix-back.ngc
# Mirror outline
#grep -v "^G64" outline.ngc | sed -e 's/X/X-/g' > fix-outline.ngc
