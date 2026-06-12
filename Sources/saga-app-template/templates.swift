import Foundation
import HTML
import Saga
import SagaPathKit
import SagaSwimRenderer

func baseHtml(
  title pageTitle: String,
  description: String? = nil,
  @NodeBuilder children: () -> NodeConvertible
) -> Node {
  html(lang: "en-US") {
    head {
      meta(charset: "utf-8")
      meta(content: "width=device-width, initial-scale=1", name: "viewport")
      title { pageTitle }
      link(href: Saga.hashed("/static/style.css"), rel: "stylesheet")
      link(href: "/static/assets/app-icon.png", rel: "icon", type: "image/png")
      link(href: "/static/assets/app-icon.png", rel: "apple-touch-icon")
      if let desc = description {
        meta(content: desc, name: "description")
        meta(content: "summary_large_image", name: "twitter:card")
        meta(content: pageTitle, customAttributes: ["property": "og:title"])
        meta(content: desc, customAttributes: ["property": "og:description"])
        meta(content: "\(SiteMetadata.url)/static/assets/app-icon.png", customAttributes: ["property": "og:image"])
      }
    }
    body {
      header(class: "site-header") {
        nav(class: "site-nav") {
          a(class: "site-title", href: "/") {
            img(alt: "PopShot", class: "nav-icon", src: "/static/assets/app-icon.png")
            SiteMetadata.name
          }
          div(class: "nav-links") {
            a(href: "#how-it-works") { "How It Works" }
            a(href: "#challenges") { "Challenges" }
            a(href: "#faq") { "FAQ" }
          }
        }
      }
      main {
        children()
      }
      footer {
        nav(class: "footer-nav") {
          div(class: "footer-brand") {
            img(alt: "PopShot", class: "footer-icon", src: "/static/assets/app-icon.png")
            span { SiteMetadata.name }
          }
          div(class: "nav-links") {
            a(href: "/privacy-policy") { "Privacy Policy" }
            a(href: "mailto:muhdhorcs@gmail.com") { "Support" }
          }
        }
        p { "© 2026 PopShot. All rights reserved." }
      }
    }
  }
}

func renderHome(context: ItemRenderingContext<PageMetadata>) -> Node {
  let siteDesc = context.item.metadata.description
    ?? "PopShot turns group travel into a live photo game. Pick challenges, snap moments together, and end every trip with a shared album worth keeping."

  let faqs: [(String, String)] = [
    (
      "What is PopShot?",
      "PopShot is a gamified travel documentation app where users complete photo challenges during a trip."
    ),
    (
      "How does it work?",
      "Create or join a trip, complete photo quests during the journey, and view all collected memories after the trip ends."
    ),
    (
      "What challenge types are there?",
      "Color Hunt asks you to photograph things matching a given color. Pose Hunt asks you to capture a trip member doing a specific pose."
    ),
    (
      "Can I join a trip with friends?",
      "Yes — create a trip or join one with a code your friend shares."
    ),
    (
      "How many people can join?",
      "Each trip supports up to 10 members."
    ),
    (
      "What is a Gamemaster?",
      "The person who creates the trip. The Gamemaster starts and ends the trip and controls when challenges begin."
    ),
    (
      "What happens when a trip ends?",
      "The Gamemaster ends the trip, and PopShot builds a shared album with photos from every member."
    ),
    (
      "Is there live interaction?",
      "Yes — the app uses real-time features so members can join together and pick quest cards as they happen."
    ),
  ]

  return baseHtml(title: context.item.title, description: siteDesc) {

    // ── Hero ──────────────────────────────────────────────────────────────
    section(class: "hero-section") {
      div(class: "hero-text") {
        div(class: "hero-badge") { "Photo quests for your travel crew" }
        h1(class: "hero-title") { "Your Trip Just Got a Quest Log" }
        p(class: "hero-sub") {
          "PopShot is the photo game you play on the road. Pick challenges, shoot moments with friends, and end every trip with a shared album worth keeping."
        }
        div(class: "hero-actions") {
          // TODO: Replace with App Store link when live
          a(class: "btn-primary", href: "#download") { "Download PopShot" }
        }
      }
      div(class: "hero-visual") {
        img(
          alt: "PopShot home screen showing an active trip with friends",
          class: "hero-screenshot",
          src: "/static/assets/screenshot-home.png"
        )
      }
    }

    // ── How It Works ──────────────────────────────────────────────────────
    section(class: "section", id: "how-it-works") {
      div(class: "section-header") {
        h2(class: "section-title") { "How It Works" }
        p(class: "section-sub") { "Three steps from blank itinerary to a full shared album." }
      }
      div(class: "steps-grid") {
        div(class: "step-card") {
          div(class: "step-number") { "1" }
          h3(class: "step-title") { "Create or Join a Trip" }
          p { "One person sets up the trip and becomes the Gamemaster. Friends join with a code. Up to 10 members per trip." }
        }
        div(class: "step-card") {
          div(class: "step-number") { "2" }
          h3(class: "step-title") { "Pick Your Quests" }
          p { "The Gamemaster kicks off challenges live. Everyone picks a quest card and starts shooting — Color Hunt, Pose Hunt, and more." }
        }
        div(class: "step-card") {
          div(class: "step-number") { "3" }
          h3(class: "step-title") { "Collect the Memories" }
          p { "When the trip ends, every photo from every member comes together in one shared album. No chasing anyone for their camera roll." }
        }
      }
    }

    // ── Challenges ────────────────────────────────────────────────────────
    section(class: "section-tinted", id: "challenges") {
      div(class: "section-header") {
        h2(class: "section-title") { "The Quests" }
        p(class: "section-sub") { "Two challenge types. Endless ways to capture a trip." }
      }
      div(class: "challenges-layout") {
        div(class: "challenge-cards") {
          div(class: "challenge-card") {
            div(class: "challenge-icon") { "🎨" }
            h3(class: "challenge-title") { "Color Hunt" }
            p { "Find and photograph things matching a given color. Sounds simple — gets competitive fast." }
          }
          div(class: "challenge-card") {
            div(class: "challenge-icon") { "📸" }
            h3(class: "challenge-title") { "Pose Hunt" }
            p { "Catch a trip member in a specific pose without them knowing. Candid chaos, every time." }
          }
        }
        div(class: "challenge-visual") {
          img(
            alt: "PopShot quest selection screen showing Color Hunt and Pose Hunt",
            class: "challenge-screenshot",
            src: "/static/assets/screenshot-challenge.png"
          )
        }
      }
    }

    // ── Group Play ────────────────────────────────────────────────────────
    section(class: "section") {
      div(class: "split-layout") {
        div(class: "split-text") {
          h2(class: "section-title" ) { "Built for the Whole Crew" }
          p {
            "Up to 10 friends in one trip. The person who creates the trip becomes the Gamemaster — they start challenges, control the pace, and end the trip to unlock the shared album."
          }
          ul(class: "feature-list") {
            li { "Real-time challenge selection for all members" }
            li { "Live quest cards — no one waits on anyone" }
            li { "Everyone shoots, everyone contributes" }
          }
        }
        div(class: "split-visual") {
          img(
            alt: "PopShot quest list screen",
            class: "group-screenshot",
            src: "/static/assets/screenshot-detail.png"
          )
        }
      }
    }

    // ── Memories ──────────────────────────────────────────────────────────
    section(class: "memories-section") {
      div(class: "memories-content") {
        div(class: "memories-icon") {
          img(alt: "PopShot", class: "memories-app-icon", src: "/static/assets/app-icon.png")
        }
        h2(class: "memories-title") { "The Album at the End" }
        p(class: "memories-sub") {
          "When the Gamemaster ends the trip, PopShot builds a shared album from every member's photos. Not a group chat dump — an actual collection of the whole trip, from every angle."
        }
      }
    }

    // ── FAQ ───────────────────────────────────────────────────────────────
    section(class: "section", id: "faq") {
      div(class: "section-header") {
        h2(class: "section-title") { "Questions" }
      }
      div(class: "faq-list") {
        faqs.map { (q, a) in
          div(class: "faq-item") {
            h3(class: "faq-q") { q }
            p(class: "faq-a") { a }
          }
        }
      }
    }

    // ── Final CTA ─────────────────────────────────────────────────────────
    section(class: "cta-section", id: "download") {
      h2(class: "cta-title") { "Ready to Quest?" }
      p(class: "cta-sub") { "Download PopShot and make your next trip one worth remembering." }
      // TODO: Replace with App Store link when live
      a(class: "btn-primary btn-large", href: "#") { "Download PopShot" }
    }

  }
}

func renderPage(context: ItemRenderingContext<PageMetadata>) -> Node {
  if context.item.metadata.template == "home" {
    return renderHome(context: context)
  }
  return baseHtml(title: context.item.title, description: context.item.metadata.description) {
    div(class: "page") {
      h1 { context.item.title }
      Node.raw(context.item.body)
    }
  }
}

func renderArticle(context: ItemRenderingContext<ArticleMetadata>) -> Node {
  baseHtml(title: context.item.title) {
    article {
      h1 { context.item.title }
      ul(class: "tags") {
        context.item.metadata.tags.map { tag in
          li {
            a(href: "/articles/tag/\(tag.slugified)/") { tag }
          }
        }
      }
      Node.raw(context.item.body)
    }
  }
}

func renderArticles(context: ItemsRenderingContext<ArticleMetadata>) -> Node {
  baseHtml(title: "Articles") {
    h1 { "Articles" }
    context.items.map { article in
      div(class: "article-card") {
        h2 {
          a(href: article.url) { article.title }
        }
        if let summary = article.metadata.summary {
          p { summary }
        }
      }
    }
  }
}

func renderTag<T>(context: PartitionedRenderingContext<T, ArticleMetadata>) -> Node {
  baseHtml(title: "Articles tagged \(context.key)") {
    h1 { "Articles tagged \(context.key)" }
    context.items.map { article in
      div(class: "article-card") {
        h2 {
          a(href: article.url) { article.title }
        }
      }
    }
  }
}
