// const color
#let color_darknight = rgb("#131A28")
#let color_darkgray = rgb("333333")

// layout utility
#let justify_align(left_body, right_body) = {
  block[
    #left_body
    #box(width: 1fr)[
      #align(right)[
        #right_body
      ]
    ]
  ]
}

#let justify_align_3(left_body, mid_body, right_body) = {
  block[
    #box(width: 1fr)[
      #align(left)[
        #left_body
      ]
    ]
    #box(width: 1fr)[
      #align(center)[
        #mid_body
      ]
    ]
    #box(width: 1fr)[
      #align(right)[
        #right_body
      ]
    ]
  ]
}

#let resume(author: (:), date: "", body) = {
  set document(
    author: author.firstname + " " + author.lastname, 
    title: "resume",
  )
  
  set text(
    lang: "pt",
    size: 11pt,
    font: "Noto Sans",
    fill: color_darknight,
    fallback: false
  )

  set page(
    paper: "a4",
    margin: (left: 0.30in, right: 0.30in, top: 0.20in, bottom: 0.20in),
    footer: [
      #set text(fill: gray, size: 8pt, ligatures: false, lang: "pt")
      #justify_align_3[
        #smallcaps[#date]
      ][
        #smallcaps[
          #author.firstname
          #author.lastname
          #sym.dot.c
          #"Currículo"
        ]
      ][
        #counter(page).display()
      ]
    ],
    footer-descent: 0pt,
  )
  
  // set paragraph spacing
  show par: set block(above: 0.75em, below: 0.75em)
  set par(justify: true)

  set heading(
    numbering: none,
    outlined: false,
  )
  
  let name = {
    align(center)[
      #pad(bottom: 5pt)[
        #block[
          #set text(size: 25pt, style: "normal")
          #text(weight: "light")[#author.firstname]
          #text(weight: "light")[#author.lastname]
        ]
      ]
    ]
  }

  let contacts = {
    set box(height: 11pt)
    set text(size: 11pt)

    let linkedin_icon = box(image("icons/linkedin.svg"))
    let github_icon = box(image("icons/github.svg"))
    let email_icon = box(image("icons/email.svg"))
    let phone_icon = box(image("icons/phone.svg"))
    let separator = box(width: 5pt)
    
    align(center)[
      #block[
        #align(horizon)[
          #phone_icon
          #box[#text(author.phone)]
          #separator
          #email_icon
          #box[#link("mailto:" + author.email)[#author.email]]
          #separator
          #github_icon
          #box[#link("https://github.com/" + author.github)[#author.github]]
          #separator
          #linkedin_icon
          #box[
            #link("https://www.linkedin.com/in/" + author.linkedin)[#author.linkedin]
          ]
        ]
      ]
    ] 
  }

  name
  contacts
  body
}

// general style
#let resume_section(title) = {
  set text(
    size: 16pt,
    weight: "thin",
  )
  align(left)[
    #smallcaps[#title]
    #box(width: 1fr, line(length: 100%))
  ]
}

#let resume_item(body) = {
  set text(size: 10pt, style: "normal", weight: "light")
  set par(leading: 0.65em)
  body
}

#let resume_time(body) = {
  set text(size: 9pt, weight: "light", style: "normal")
  body
}

#let resume_degree(body) = {
  set text(size: 10pt, weight: "regular")
  smallcaps[#body]
}

#let resume_organization(body) = {
  set text(size: 12pt, style: "normal", weight: "bold")
  body
}

#let resume_position(body) = {
  set text(size: 10pt, weight: "regular", ligatures: false,)
  smallcaps[#body]
}

#let resume_category(body) = {
  set text(size: 11pt, weight: "bold")
  body
}

// sections specific components
#let education_item(organization, degree, time_frame) = {
  set block(above: 0.7em, below: 0.7em)
  set pad(top: 5pt)

  pad[
    #justify_align[ #resume_organization[#organization] ][ ]
    #justify_align[ #resume_degree[#degree] 
    ][ #resume_time[#time_frame]
    ]
  ]
}

#let work_experience_item_header(
  company,
  position,
  time_frame
) = {
  set block(above: 0.7em, below: 0.7em)
  set pad(top: 5pt)

  pad[
    #justify_align[
      #resume_organization[#company]
    ][ ]
    #justify_align[
      #resume_position[#position]
    ][
      #resume_time[#time_frame]
    ]
  ]
}

#let personal_project_item_header(
  name,
  position,
  start_time,
) = {
  set block(above: 0.7em, below: 0.7em)
  set pad(top: 5pt)
  
  pad[
    #justify_align[
      #resume_organization[#name]
    ][]
    #justify_align[
      #resume_position[#position]
    ][
      #resume_time[#start_time]
    ]
  ]
}

#let skill_item(category, items) = {
  set block(below: 0.65em)
  set pad(top: 5pt)
  
  pad[
    #grid(
      columns: (20fr, 80fr),
      gutter: 10pt,
      align(right)[
        #resume_category[#category]
      ],
      align(left)[
        #set text(size: 11pt, style: "normal", weight: "light")
        #items.join(", ")
      ],
    )
  ]
}


#let item_header(
  text,
) = {
  set block(above: 0.7em, below: 1.0em)
  set pad(top: 5pt)

  pad[ #justify_align[ #resume_organization[#text] ][ ]
  ]
}
