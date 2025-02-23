// Positions text on the top portion of a circle.  Height increases as required
// given font and degrees.
//
// Arguments:
//   str: string to display
//   width: Total width of the containing block
//   degrees: Range of the top of the circle to place text
//   rotate-letters: rotate letters to match tangent of the circle
//   show-design-aids: Shows design aids when true
//   font-letter-spacing: Manual adjustment for letter spacing built into font
#let text-on-arc(str, width, degrees,
                 rotate-letters:true,
                 show-design-aids:false,
                 font-letter-spacing: 0pt) = context {

  if degrees == 0 {
    panic("degrees must be greater than 0 otherwise circle would be infinitely large")
  }

  // Orient angles where 0deg is left Cartesian coordinate system
  let start-angle = 90deg - degrees/2
  let end-angle = 90deg + degrees/2

  // Orient angles where 0deg is up for text rotation
  let text-start-angle = -degrees/2
  let text-end-angle = degrees/2

  let m = measure[M] // pic a good letter
  let (letter-width, cap-height) = (m.width - font-letter-spacing, m.height)

  // Adjust y for letter rotation causing part of the letter to drop below bottom of the rect
  let y-char-offset = letter-width/2*calc.sin(text-end-angle)

  // Calculate block inset for text height or width depending on how the
  // first/last letter is rotated
  let text-offset-x-height = cap-height*calc.cos(90deg+text-start-angle)
  let text-offset-x-width = (letter-width / 2)*calc.cos(text-start-angle)
  let text-offset-x = text-offset-x-height + text-offset-x-width

  // Distance between bottom+center of first character and last character
  let arch-width = width - text-offset-x * 2 // Times 2 for left and right impact

  // Calculate radius of the circle on which we will place text
  let radius = arch-width/(2*calc.sin(degrees/2))

  // Distance between baseline of first character and middle character
  let bend-height = radius - radius*calc.cos(degrees/2)

  // Shift text/circle down so that the bounding block is
  // only as high as it needs to be for the degrees specified
  let y-offset = radius * calc.sin(end-angle)

  let block-fill=none
  if show-design-aids {
    block-fill=red
  }
  let containing-block-height = y-char-offset + cap-height + bend-height


  // The container for the text
  block(fill: block-fill, width:width, height:containing-block-height, {

    if show-design-aids {
      // Center line
      place(
        top+left,
        line(start: (50%, 0pt), end: (50%, 100%), stroke: .3pt)
      )

      // Calculated circle based on width and degrees
      place(
        top + left,
        dx: -radius + width/2,
        dy: cap-height,
        circle(stroke:.1pt, radius:radius)
      )
    }


    // Convert string to array of chars (Support unicode characters)
    let chars = str.matches(regex(".")).map(m => m.text)

    let n = chars.len()
    for i in range(n) {
      let percent = .5
      if (n > 1) {
        percent = i / (n - 1)
      }

      let  pos-angle = percent * degrees + (start-angle)
      let text-angle = percent * degrees + (text-start-angle)

      let x = -radius * calc.cos(pos-angle)
      let y = -radius * calc.sin(pos-angle)

      let cur = measure(chars.at(i))
      place(
        bottom,
        dx: x+50% - (cur.width/2),
        dy: y + y-offset - y-char-offset,
        if rotate-letters {
          rotate(text-angle, origin:bottom, chars.at(i))
        } else {
          chars.at(i)
        }
      )

      if show-design-aids {
        let alignment-circle-radius=1pt
        place(
          bottom,
          dx: x+50%-alignment-circle-radius,
          dy: y + y-offset - y-char-offset+alignment-circle-radius,
          circle(radius:alignment-circle-radius, stroke:none, fill:black)
        )
      }
    }
  })
}


// Positions text on the top portion of a circle.  Height increases as required
// given font and degrees.
//
// Arguments:
//   top-str: string to display on the top of the circle
//   bottom-str: string to display on the bottom of the circle
//   width: Total width of the containing block
//   top-degrees: Range of the top of the circle to place text
//   bottom-degrees: Range of the top of the circle to place text
//   show-design-aids: Shows design aids when true
#let text-on-circle(top-str, bottom-str, width, top-degrees, bottom-degrees,
                    circle-background:black,
                    circle-fill:none,
                    circle-margin:0pt,
                    show-design-aids:false) = context {

  let m = measure[M] // pic a good letter
  let (letter-width, cap-height) = (m.width, m.height)

  // Calculate radius of the circle on which we will place text
  let radius = (width - 2 * cap-height - 2 * circle-margin)/2

  let block-fill=none
  if show-design-aids {
    block-fill=red
  }
  let containing-block-height = 2*(radius + circle-margin + cap-height)
  let containing-block-width = width
  let containing-block-width = 2*(radius + circle-margin + cap-height)

  // The container for the text
  block(fill: block-fill, width:containing-block-width, height:containing-block-height, {

    if circle-fill != none {
      place(
        top + left,
        dx: 0pt,
        circle(fill:circle-fill, stroke:none, radius:radius + circle-margin + cap-height)
      )

      place(
        top + left,
        dx: 2*circle-margin+cap-height,
        dy: 2*circle-margin+cap-height,
        circle(fill:white, stroke:none, radius:radius - circle-margin)
      )
    }


    let top-chars = top-str.matches(regex(".")).map(m => m.text)

    // Place Top Text
    let n = top-chars.len()
    for i in range(n) {
      let percent = .5
      if (n > 1) {
        percent = i / (n - 1)
      }

      // Orient angles where 0deg is left Cartesian coordinate system
      let start-angle = 90deg - top-degrees/2

      // Orient angles where 0deg is up for text rotation
      let text-start-angle = -top-degrees/2


      let  pos-angle = percent * top-degrees + (start-angle)
      let text-angle = percent * top-degrees + (text-start-angle)

      let x = -radius * calc.cos(pos-angle)
      let y = -radius * calc.sin(pos-angle)

      let cur = measure(top-chars.at(i))
      place(
        top,
        dx: x+50% - (cur.width/2),
        dy: y + radius + circle-margin,
        rotate(text-angle, origin:bottom, top-chars.at(i))
      )

      if show-design-aids {
        let alignment-circle-radius=1pt
        place(
          top,
          dx: x+50%-alignment-circle-radius,
          dy: circle-margin + y + radius + cap-height - alignment-circle-radius/2,
          circle(radius:alignment-circle-radius, stroke:none, fill:black)
        )
      }
    }

    let bottom-chars = bottom-str.matches(regex(".")).map(m => m.text)

    // Place Bottom Text
    let n = bottom-chars.len()
    for i in range(n) {
      let percent = .5
      if (n > 1) {
        percent = i / (n - 1)
      }

      // Orient angles where 0deg is left Cartesian coordinate system
      let start-angle = 270deg + bottom-degrees/2

      // Orient angles where 0deg is up for text rotation
      let text-start-angle = bottom-degrees/2


      let  pos-angle = -percent * bottom-degrees + (start-angle)
      let text-angle = -percent * bottom-degrees + (text-start-angle)

      let x = -(radius+cap-height) * calc.cos(pos-angle)
      let y = -(radius+cap-height) * calc.sin(pos-angle)

      let cur = measure(bottom-chars.at(i))
      place(
        top,
        dx: x+50% - (cur.width/2),
        dy: y + radius + circle-margin,
        rotate(text-angle, origin:bottom, bottom-chars.at(i))
      )

      if show-design-aids {
        let alignment-circle-radius=1pt
        place(
          top,
          dx: x+50%-alignment-circle-radius,
          dy: circle-margin + y + radius + cap-height - alignment-circle-radius/2,
          circle(radius:alignment-circle-radius, stroke:none, fill:black)
        )
      }
    }

    if show-design-aids {
      // Center line
      place(
        top+left,
        line(start: (50%, 0pt), end: (50%, 100%), stroke: .3pt)
      )

      // Calculated circle based on width and degrees for top text
      place(
        top + left,
        dx: -radius + containing-block-width/2,
        dy: circle-margin + cap-height,
        circle(stroke:.1pt, radius:radius)
      )

      // Calculated circle based on width and degrees for bottom text
      place(
        top + left,
        dx: -(radius+cap-height) + containing-block-width/2,
        dy: circle-margin,
        circle(stroke:.1pt, radius:(radius+cap-height))
      )
    }
  })
}
