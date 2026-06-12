import Foundation
import Saga
import SagaParsleyMarkdownReader
import SagaSwimRenderer
import SwiftTailwind

enum SiteMetadata {
  static let url = URL(string: "http://www.example.com")!
  static let name = "Example App Landing Page"
  static let author = "Brent Deverman"
}

struct ArticleMetadata: Metadata {
  let tags: [String]
  var summary: String?
}

let tailwind = SwiftTailwind(version: "4.2.1")

func compileTailwind() async throws {
  let input = "Styles/tailwind.css"
  let output = "content/static/style.css"
  let temporaryOutput = "content/static/style.tmp.css"

  try await tailwind.run(
    input: input,
    output: temporaryOutput,
    options: .minify
  )

  let temporaryURL = URL(fileURLWithPath: temporaryOutput)
  let outputURL = URL(fileURLWithPath: output)
  let attributes = try FileManager.default.attributesOfItem(atPath: temporaryOutput)
  let fileSize = attributes[.size] as? NSNumber

  guard let fileSize, fileSize.intValue > 0 else {
    throw CocoaError(.fileWriteUnknown)
  }

  _ = try FileManager.default.replaceItemAt(outputURL, withItemAt: temporaryURL)
}

try await Saga(input: "content", output: "docs")
  .beforeRead { _ in
    try await compileTailwind()
  }
  .ignoreChanges("style.css")
  .ignoreChanges("style.tmp.css")
  .register(
    folder: "articles",
    metadata: ArticleMetadata.self,
    readers: [.parsleyMarkdownReader(
        markdownOptions: [.hardBreaks, .smartQuotes, .markdownAttributes],
        syntaxExtensions: [.autolink, .strikethrough, .table, .tasklist]
)],
    writers: [
      .itemWriter(swim(renderArticle)),
      .listWriter(swim(renderArticles)),
      .tagWriter(swim(renderTag), tags: \.metadata.tags),
    ]
  )
  .register(
    metadata: EmptyMetadata.self,
    readers: [.parsleyMarkdownReader(
    markdownOptions: [.hardBreaks, .smartQuotes, .markdownAttributes],
        syntaxExtensions: [.autolink, .strikethrough, .table, .tasklist]
        )],
    writers: [.itemWriter(swim(renderPage))]
  )
  .run()
