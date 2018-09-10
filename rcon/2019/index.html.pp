#lang pollen
◊(require css-tools)
<html>
<head>
<style type="text/css">

◊(ffd/rp "libre-barcode-128" "Libre_Barcode_128/LibreBarcode128-Regular.ttf" #:base64 #t)
◊(ffd/rp "plex-light" "IBM-Plex-Mono/IBMPlexMono-LightItalic.ttf" #:base64 #t)
◊(ffd/rp "plex-dark" "IBM-Plex-Mono/IBMPlexMono-BoldItalic.ttf" #:base64 #t)

body {
    background: #777;
}


.barcode {
    font-family: "libre-barcode-128";
     font-size: 10vw;
     opacity: 0.6;
}

* {
    font-family: "plex-light";
    font-size: 5.5vw;
    color: white;
    background: inherit;
    text-align: center;
    ◊;{ss01=two story a, ss02 = two story g }
    ◊make-css-ot-features['("ss01" "ss02") '(1 1)];
    margin: 0;
    padding: 0;
}

strong {
    font-family: "plex-dark";
}

body {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}

</style>

<script type="text/javascript">

function append_barcode(el) {
    const barcode_div = document.createElement("div");
    barcode_div.append(el.innerText);
    barcode_div.classList.add("barcode");
    el.append(barcode_div);
}

function select_all() { 
    document.execCommand('selectAll', false, null); 
}

function append_barcodes() {
    Array.from(document.getElementsByClassName("barcoded")).map(append_barcode);

    const email_field = document.getElementById("email_field");
    function sync_email_field() {
        document.getElementById("email_barcode").innerText = email_field.value || "z";
    }
    email_field.addEventListener("input", sync_email_field);
    email_field.addEventListener("focus", event => {setTimeout(select_all);});
    email_field.setAttribute("size", email_field.value.length);
    sync_email_field();
}

function update_clock() {
    const reg_opens = new Date("February 1, 2019");
    const now = new Date();
    const diff = reg_opens.getTime() - now.getTime();
    const clock = document.getElementById("clock");
    clock.innerText = `in ${Math.floor(diff)}ms`;
    append_barcode(clock);
}

window.addEventListener("load", append_barcodes);
window.addEventListener("load", update_clock);
window.setInterval(update_clock, 512);

</script>

</head>

<body>
<div id="rs" class="barcoded">Racket School</div>
<div class="barcoded">+ RacketCon</div>
<div class="barcoded">= <strong>Racket Week</strong></div>
<div class="barcoded">Salt Lake City UT</div>
<div class="barcoded">8-14 July 2019</div>
<div class="barcoded">Registration opens</div>
<div id="clock" class="barcoded">in 12386797s</div>
<input id="email_field" style="border:1px solid #ccc" type="email" value="Enter email for updates">
<div id="email_barcode" class="barcode">Enter email for updates</div>
<input style="padding:0.10em 0.50em;cursor:pointer;border:2px solid white" type="button" value="Submit">

</body>
</html>