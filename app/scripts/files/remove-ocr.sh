OUTPUT_DIR=~/books/no-ocr/
WORKING_DIR=~/workdir/
PDF_DIR=~/books/

remove_ocr() {
  local filename=$(basename "$1" .pdf)

  echo "====="
  echo starting $1

  # setup
  rm -r "$WORKING_DIR"
  mkdir -p "$WORKING_DIR" "$OUTPUT_DIR"

  # pdf already exists
  if [ -f "$OUTPUT_DIR/$filename.pdf" ]; then
    echo "nothing to do."
    return 0
  fi

  # pdf -> jpeg -> pdf -> merge pdf
  echo pdftoppm
  pdftoppm -r 300 -jpeg "$1" "$WORKING_DIR/$filename"

  echo mogrify
  mogrify -format pdf $WORKING_DIR/*.jpg

  echo pdftk
  pdftk $WORKING_DIR/*.pdf cat output "$WORKING_DIR/$filename.pdf"

  cp "$WORKING_DIR/$filename.pdf" "$OUTPUT_DIR"
}

for file in $PDF_DIR/*; do
  remove_ocr "$file"
done
