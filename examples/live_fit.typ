#{
  import "@preview/curvly:0.1.0": *

  set page(
    width:2in,
    height:2in,
    margin:.1in,
  )

  // Center design to the page
  align(center+horizon, {

    set par(spacing:0pt)
    set text(15pt, font:"Oswald")
    text-on-arc("LIVE FIT", 105pt, 43deg)

    v(-2pt) // Space USC a bit inside of the block
    text(rgb("#990000"), .7em, font:"Big Caslon")[USC]

    set text(15pt, font:"Oswald", weight:900)
    set par(spacing:8pt)

    set text(tracking: .3em)

    par[ATHLETIC]

    grid(
      columns: (auto, auto, auto),
      column-gutter: 9pt,

      text(.3em)[00],
      [DEPT],
      text(.3em)[12],
    )

    text(.3em)[LA CA USA]

  })
}
