#{
  import "@preview/curvly:0.1.0": *

  set page(
    width:2in,
    height:2in,
    margin:.1in,
  )

  let airforce-logo-svg = ```
    <?xml version="1.0"?>
    <svg
        xmlns="http://www.w3.org/2000/svg"
        viewBox="0 0 338.667 264.018">
      <g transform="translate(-366.124 -442.668)">
        <path clip-path="none" d="M50.009 66.692L36.33 56.749 13.512 73.325l27.784 20.189zm18.209 13.225L45.401 96.5l22.817 16.574L91.022 96.5zm-47.672-34.64h36.381l-83.651-60.783L-7.197 25.13zm38.177-5.401l6.959-21.398-116.873-84.919 19.525 40.644zM-6.056-40.342l-28.566-59.439-13.78 28.674zm106.148 97.091l-13.674 9.943 8.72 26.822 27.774-20.189zm-20.59-11.472h36.38l27.743-20.147 19.519-40.636zM187.62-66.441L70.751 18.478 77.7 39.876l90.39-65.673zm-2.791-4.666L171.05-99.781l-28.574 59.439z" fill="#00529b" transform="matrix(.940743 0 0 .940743 471.34614 589.53619)"/>
      </g>
    </svg>```.text

  set text(white, 13pt, weight:900)
  place(
    center+horizon,
    text-on-circle("UNITED STATES", "AIR FORCE", 1.8in, 117deg, 90deg,
                  show-design-aids:false,
                  circle-fill:rgb("#00529b"),
                  circle-margin:.3em)
  )

  // Stars need to be bigger, so change the font size and draw again
  set text(16pt)
  place(
    center+horizon,
    text-on-circle("★ ★              ★ ★", "", 1.91in, 220deg, 0deg,
                  circle-fill:none, // don't overwrite the previous image
                  circle-margin:.3em)
  )

  set text(black)

  let circle = 96pt
  align(center+horizon,
    box(fill:none, clip: false, stroke: none, radius: circle/2,
        width: circle, height: circle,
        image.decode(airforce-logo-svg, height:87pt)
    )
  )
}
