#lang pollen
◊(require racket/string css-tools)

◊(ffd "plex-mono" "fonts/IBMPlexMono-Light.ttf" #:base64 #t)
◊(ffd "plex-mono" "fonts/IBMPlexMono-LightItalic.ttf" #:font-style "italic" #:base64 #t)
◊(ffd "plex-mono" "fonts/IBMPlexMono-Bold.ttf" #:font-weight "bold" #:base64 #t)
◊(ffd "barcode" "fonts/LibreBarcode128-Regular.ttf" #:base64 #t)


* {
  padding: 0;
  margin: 0;
  border: 0;
  box-sizing: border-box;
  font-weight: inherit;
  font-style: inherit;
  font-size: inherit;
  text-decoration: inherit;
  color: inherit;
}


labels {
    display: grid;
    grid-template-columns: 3.375in 3.375in ;
    grid-template-rows: 2.375in 2.375in;
    break-after: page;
}

label.invert {
    transform: rotate(180deg);
}

label {
    font-family: plex-mono;
    font-size: 16pt;
    border: solid gray 0.25px;
    padding: 0.75em;
    padding-top: 0;
    padding-right: 1em;
}

◊(define big-size 30)
◊(define big-barcode-size (/ big-size .55))

label > barcode{
  display: block;
  font-family: barcode;
  line-height: 1;
  font-size: ◊|big-barcode-size|pt;
  margin-bottom: -0.3em;
}


label > fn {
  display: block;
  font-weight: bold;
  line-height: 1;
  font-size: ◊|big-size|pt;
}

label > ln {
  display: block;
  line-height: 1;
  font-size: ◊|big-size|pt;
}

label > week {
  display: block;
  margin-top: 0.25em;
  line-height: 1.1;
}

