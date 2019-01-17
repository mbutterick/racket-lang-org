<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="format-detection" content="telephone=no">
<link rel="stylesheet" type="text/css" media="all" href="styles.css" />
<script type="text/javascript">
function toggle_div(id) {
    e = document.getElementById(id);
    if (e.style.display == 'block') {
        e.style.display = 'none';
    }
    else if (e.style.display == 'none') {
        e.style.display = 'block';
    }
}
</script>
</head>

<body>
<div class="bg"></div>
<div class="doc">
<div class="logo"><img style="width:100px" src="http://racket-lang.org/img/racket-logo.svg"></div>
◊(->html doc #:splice #t)</div>

</body>

</html>