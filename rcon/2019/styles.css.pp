#lang pollen
◊(require racket/string css-tools)
◊(define dark-color "#000")
◊(define light-color "#eee")
◊(define max-width "1000px")
◊(define anchor-color "#cfc")
◊(define anchor-bright-color "#efe")
◊(define wide-only "@media all and (min-width:1000px)")
◊(define mobile-only "@media all and (max-width:580px)")

◊(ffd "plex-light" "IBM-Plex-Mono/IBMPlexMono-LightItalic.ttf" #:base64 #f)
◊(ffd "plex-light" "IBM-Plex-Mono/IBMPlexMono-BoldItalic.ttf" #:font-weight "bold" #:base64 #f)


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

html { font-size: 2.4vw; }
◊|wide-only| { html { font-size: 24px; } }
◊|mobile-only| { html{ font-size: 18px; } }

body {
   font-family: plex-light;
   font-feature-settings: "ss01", "ss02"; /* two-story a, g */
    background: black;
 color: ◊|light-color|;
    margin: 0 auto;
    padding: 3vw;
    width: 100%;
    max-width: ◊|max-width|;
}

p {
  margin-bottom: 1rem;
  line-height: 1.45rem;
  text-shadow:  0 0 0.5em black;
}

a {
  color: ◊|anchor-color|;
  text-decoration: none;
  transition: color 0.15s, border-bottom 0.15s;
  font-weight: bold;
    text-shadow:  0 0 1.00em #fff, 0 0 1.25em #fff;
}

a:hover {
  color: ◊|anchor-bright-color|;
  transition: color 0.15s, border-bottom 0.15s;
}

strong {
  font-weight: bolder;
}


.bg {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    /* Photo by Wil Stewart https://unsplash.com/photos/T26KCgCPsCI */
    background: black url(stars3b.jpg);
    background-size: 100% 100%;
    opacity: 0.4;
    z-index: -10;
}


.logo {
    text-align: center;
    margin: 2rem;
}

div.svg {
  margin-top: 2rem;
}

div.svg + div.svg {
  margin-top: 0rem;
}

svg {
    opacity: 0.9;
    mix-blend-mode: lighten;
}

◊(define stroker "4")

.pixel-on .top-shape {
  fill: ◊|light-color|;
  stroke-width: ◊|stroker|;
  stroke: ◊|dark-color|;
}

.pixel-on .lower-shape {
  fill: ◊|dark-color|;
  stroke-width: ◊|stroker|;
  stroke: ◊|dark-color|;
}

.pixel-on .lower-shape.layer-0 {
    fill: ◊|light-color|;
    stroke-width: ◊|stroker|;
    stroke: ◊|light-color|;
}

.bg-line {
  stroke: ◊|light-color|;
  stroke-width: 1;
}



h2 {
  display: inline-block;
  padding: 0.5rem;
  font-size: 110%;
  border-top: 1px solid white;
  border-bottom: 1px solid white;
  white-space: nowrap;
}

h2 + h2 {
  margin-left: 0.5rem;
}

h2 + p {
    margin-top: 1rem;
}


.speaker-name {
  font-size: 1.6rem;
  font-weight: 200;
  margin-right: 0.5rem;
  line-height: 1.4;
}

span.title {
  border-bottom: 0.08rem solid magenta;
}

a:hover span.title {
    border-bottom-color: cyan;
   transition: border-bottom-color 0.15s;
}

.keynote-speaker .speaker-name {
  font-size: 2.5rem;
  line-height: 1;
}

.keynote-speaker > span.title {
  border: 0;
  display: block;
  font-size: 2rem;
  margin-top: 0.5rem;
  line-height: 1.2;
}




.time {
  display: none;
  font-size: 1rem;
}


.opacity-control {
  padding: 0.5rem;
  opacity: 0;
  background: white;
}

.opacity-control:hover {
  opacity: 1;
}

.opacity-control, .opacity-control:hover {
  transition: opacity 0.25s;
}



schedule {
  display: flex;
  display: -webkit-flex;
  flex-direction: column;
  -webkit-flex-direction: column;
}

schedule > row {
  display: flex;
  display: -webkit-flex;
  flex-direction: row;
  -webkit-flex-direction: row;
  padding-top: 0.2rem;
  padding-bottom: 0.2rem;
}

schedule > row > at {
  width: 50%;
}

schedule > row + row {
  border-top: 1px solid #ccc;
}

.two-col {
  column-count: 2;
;
}

.two-col .speaker {
  margin-bottom: 0.5rem;
  -webkit-column-break-inside: avoid;
  page-break-inside: avoid;
  break-inside: avoid;
}
