#! /bin/bash

infile=$1
outdir=$2
tmpdir=$(mktemp -d)

indir=$(realpath $(dirname "${infile}"))
outdir=$(realpath "${outdir}")
infilebn=$(basename "${infile}")

docker run --rm -t -i \
  -v "${tmpdir}":/tmp \
  -v "${indir}":/firmware-in:ro \
  -v "${outdir}":/firmware-out \
  "ddcc/firmadyne-extractor:latest" \
  fakeroot /home/extractor/extractor/extractor.py \
  -np \
  /firmware-in/"${infilebn}" \
  /firmware-out
