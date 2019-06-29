#lang pollen
◊(require racket/string css-tools)

◊(ffd "plex-mono" "fonts/IBMPlexMono-Light.ttf" #:base64 #t)
◊(ffd "plex-mono" "fonts/IBMPlexMono-LightItalic.ttf" #:font-style "italic" #:base64 #t)
◊(ffd "plex-mono" "fonts/IBMPlexMono-Bold.ttf" #:font-weight "bold" #:base64 #t)


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

label.a2, label.b2 {
    transform: rotate(180deg);
}

label {
    font-family: plex-mono;
    font-size: 16pt;
    border: solid black 0.5px;
    padding: 0.75em;
    padding-right: 1em;
}

label > fn {
  display: block;
  font-weight: bold;
  line-height: 1;
  font-size: 30pt;
}

label > ln {
  display: block;
  line-height: 1;
  font-size: 30pt;
}

label > caption {
  display: block;
  margin-top: 0.5em;
  line-height: 1.1;
}

