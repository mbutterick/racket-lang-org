<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">

<style type="text/css">

* {
    padding: 0;
    margin: 0;
}

.top-shape {
    fill: black;
    stroke-width: 1;
    stroke: white;
}

.lower-shape {
    fill: white;
    stroke-width: 0;
    stroke: black;    
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
    border: solid black 0.5px;
}

</style>

</head>

<body>

◊(->html doc #:splice #t)

</body>

</html>
