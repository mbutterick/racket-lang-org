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
}


labels {
    display: grid;
    grid-template-columns: 0.5in 3.375in 3.375in 0.5in;
    grid-template-rows: 0.5in 2.375in 2.375in 0.5in;
    break-after: page;
    grid-template-areas: 
      "c11 c12 c13 c14"
      "c21 c22 c23 c24"
      "c31 c32 c33 c34"
      "c41 c42 c43 c44";
}

labels > label:nth-child(1) {
  grid-area: c22;
}

labels > label:nth-child(2) {
  grid-area: c23;
}

labels > label:nth-child(3) {
  grid-area: c32;
}

labels > label:nth-child(4) {
  grid-area: c33;
}

label {
    font-family: plex-mono;
    font-size: 16pt;
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

div.crop1 {
  grid-area: c12;
  border-left: 0.5pt solid black;
  border-right: 0.5pt solid black;
  position: relative;
  top: -6pt;
}

div.crop2 {
  grid-area: c13;
  border-right: 0.5pt solid black;
  position: relative;
  top: -6pt;
}

div.crop3 {
  grid-area: c42;
  border-left: 0.5pt solid black;
  border-right: 0.5pt solid black;
  position: relative;
  bottom: -6pt;
}

div.crop4 {
  grid-area: c43;
  border-right: 0.5pt solid black;
  position: relative;
  bottom: -6pt;
}

div.crop5 {
  grid-area: c21;
  border-top: 0.5pt solid black;
  border-bottom: 0.5pt solid black;
  position: relative;
  left: -6pt;
}

div.crop6 {
  grid-area: c31;
  border-bottom: 0.5pt solid black;
  position: relative;
  left: -6pt;
}

div.crop7 {
  grid-area: c24;
  border-top: 0.5pt solid black;
  border-bottom: 0.5pt solid black;
  position: relative;
  right: -6pt;
}

div.crop8 {
  grid-area: c34;
  border-bottom: 0.5pt solid black;
  position: relative;
  right: -6pt;
}