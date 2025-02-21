#{
  import "@preview/curvly:0.1.0": *

  let maroon = rgb("#572526")

  set page(
    width:2in,
    height:2in,
    margin:.1in,
    fill:rgb("#eeeeee"),
  )

  set text(maroon, 15pt, font:"Baskerville", weight:900)
  place(
    center+horizon,
    text-on-circle("TEXSAS AGGIES", "OL' SARGE", 1.8in, 163deg, 99deg,
                  show-design-aids:false,
                  // circle-fill:black,
                  // circle-fill:rgb("#00529b"),
                  circle-margin:.3em)
  )

  set text(black)

  let circle = 91pt
  align(center+horizon,
    box(fill:none, clip: true, stroke: none, radius: circle/2,
        width: circle, height: circle,
        image("ol_sarge.gif", height:83pt)
    )
  )
}

