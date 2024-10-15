#import "@preview/codelst:2.0.1":sourcecode
// 版面設定
#set page(
  paper: "iso-b5",
  margin: (inside: 22mm, outside: 18mm, bottom: 22mm, top: 12mm),
  binding: left,
  columns: 1,
  numbering: "1",
  footer: locate(loc => {
    if loc.page() == 1 {} else if calc.odd(loc.page()) {
      [
        #h(1fr)
        #text(size: 6pt)[#loc.page()]
      ]
    } else {
      [
        #text(size: 6pt)[#loc.page()]
        #h(1fr)
      ]
    }
  }),
)
// 本文設定
#set text(
  lang: "jp",
  font: "Noto Serif",
  size: 9pt,
  stretch: 90%,
  tracking: 0.03em,
  cjk-latin-spacing: none,
  number-type: "lining",
  number-width: "proportional",
  top-edge: "cap-height",
  bottom-edge: "baseline",
  region: "ja",
)
#set par(
  leading: 1.4em,
  justify: true,
  linebreaks: "optimized",
  first-line-indent: 1em,
)
#show parbreak:it=>{
  v(1.4em, weak: true)
  h(1em)
  it
}
#show linebreak:it=>{
  it
  h(1em)
}
// モジュラースケール関数定義
#let modular_scale(n) = { calc.pow(2, n / 5) }
#show outline:it =>{
  set text(size: 8pt)
  set par(leading: 1.1em)
  it
}
// 目次設定
#set outline(fill: align(right, line(length: 95%, stroke: 0.01pt)))
#show outline:it=>{
  set text(font: "Noto Sans")
  set par(first-line-indent: 0em)
  it
}
#show outline.entry.where(level: 1): it => {
  v(3em, weak: true)
  set text(size: 1em * modular_scale(3), weight: "bold")
  it
  v(0.25em, weak: true)
}
#show outline.entry.where(level: 2): it => {
  set text(font: "Noto Serif", size: 1em * modular_scale(2), weight: "medium")
  it
}
#show outline.entry.where(level: 3):it=>{
  h(2em, weak: false)
  set text(font: "Noto Serif", size: 1em * modular_scale(1), weight: "regular")
  it
}
#show outline.entry.where(level: 4):it=>{
  set text(font: "Noto Serif", size: 1em * modular_scale(0), weight: "regular")
  it
}
// 見出し設定
#show heading:it=>{
  set text(font: "Noto Sans", tracking: -0.02em)
  set par(leading: 1em)
  it
}
#show heading.where(level: 1):it=>{
  pagebreak(to: "odd", weak: true)
  set text(size: 1em * modular_scale(3), weight: "medium")
  v(0.5em * modular_scale(3))
  it
  v(0.5em, weak: true)
}
#show heading.where(level: 2):it=>{
  set text(size: 1em * modular_scale(2), weight: "medium")
  v(0.5em * modular_scale(2))
  it
  v(0.5em, weak: true)
}
#show heading.where(level: 3):it=>{
  set text(size: 1em * modular_scale(1), weight: "medium")
  v(0.5em * modular_scale(1))
  it
  v(0.5em)
}
#show heading.where(level: 4):it=>{
  set text(size: 1em * modular_scale(0), weight: "regular")
  v(0.5em * modular_scale(0))
  it
  v(0.5em, weak: true)
}
#set heading(numbering: "1.1.a.")
// ドキュメントプロパティ設定
#set document(title: "2024年金大祭CASる通信学祭号IT班", author: "CASるIT班")
// ハイパーリンクの色変更
#show link:it=>{
  underline(it)
}
// figure設定
#show figure.caption:it =>{
  set text(size: 0.8em)
  set par(leading: 0.5em)
  it.body
}

#block(stroke: 0.15mm, height: 98%, width: 100%)[
  #align(center + horizon)[
    #set text(font: "Noto Serif JP")
    #set par(leading: 1.2em)
    #text(
      size: 1em * modular_scale(1),
      weight: "thin",
      tracking: -0.1em,
    )[2024年金大祭CASる通信学祭号]\
    #text(size: 1em * modular_scale(10), tracking: -0.04em)[技術雑誌]\
    #text(size: 1em * modular_scale(1))[CASるIT班]
  ]
]

#outline(title: "目次", indent: false)
#pagebreak()