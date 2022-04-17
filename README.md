# TerseNet

For some context, read  [Adblocking, How about Nah?](https://www.eff.org/deeplinks/2019/07/adblocking-how-about-nah)

# Work in Progress

*Note: What this actually does so far* Right now (after two days of actual coding) it is sort of like a janky RST viewer that only knows about headings and paragraphs.  Not useable for anything.

I have also done some research, such as `dat`, `ipfs`, `gnunet` and `libp2p`, web assembly, etc. `ipfs` seems to be performing better now at retrieving content than it did a few years ago.

# Everything below here is just an idea -- not actually coded yet

TerseNet is a new type of lightweight, high-performance document, media and application browser suite that is *100% JavaScript free*. Pages are encoded in an encrypted, size-limited subset of restructuredtext distributed in a content-oriented (rather than server-centric) fashion. They load almost instantly from network peers.

This software prototype is written in the [Nim](https://nim-lang.org) programming language. One of the primary goals is for it to be feasible for individuals or small teams to implement some or all types of TerseNet browsers, so there should be multiple clients available, and large companies cannot control the platform, as is the case with browsers essentially incorporating a full bloated operating system that can only be implemented by large teams over the course of years.

## Ad-free

It is impossible for ads from the traditional web to display in NoScriptWeb, or for companies to track you -- because no content or links from the traditional web can be displayed by NoScriptWeb browsers.

This web browser is a relatively simple system, rather than an entire operating system-in-a-box like Chrome or Firefox. It is supported by decentralized protocols.
 
# Multiple Browser Types with Standardized Integration

TerseNet functionality is separated into three types of browsers:

1. Info browsers, for distributing text and very lightweight diagrams,
2. Media Applications browsers, which run web assembly applications that can optionally be used to display or interact with media from TerseNet sites,
3. Extended Media Applications browsers, web applications that support various extensions via a type of device driver API.

There should be multiple implementations of each type of browser. To make this practical, the required functionality is kept as sparse as possible while still remaining as flexible as necessary for each type of functionality.

## TerseNet Info

### RST (restructured text) subset
 
TerseNet Info RST supports the following features: headings (with `#`), escape with backtick, bold, italics, bullets, and links (only to other TerseNet info pages, e.g. terse://reports.frontline/aug2019austin).

## TerseNet Media Applications

## TerseNet Extended Applications
 
 
## Attachments
 
All non-markdown content (except for one small image) is loaded *only* upon demand by the user.
 
Media and applications can be attached to pages, but have restrictions.  No more than 10KB of images will be loaded by default.

Other than that small image, media must be launched explicitly from the Media tab.  Zero bytes will be loaded, processed, or transmitted without prompting by the user.

### Media attachments

Pages may attach images or videos.  Their descriptions appear on the Media Tab.  Users must switch tabs and click the individual media item before any loading or processing is done.  Images and media may not be loaded from traditional web sources outside of NoScriptWeb  protocols.

### Application attachments

Applications may be attached to pages.  They appear on the Applications tab and are not downloaded or executed unless explicitly launched by the user.

Attached applications are written in web assembly with some basic I/O abilities which include:

* A [simple UI API](https://github.com/simple2d/simple2d)

* A communications API that connects applications with NoScriptWeb's p2p backbone

* Carefully controlled payment prompts that integrate popular cryptocurrencies.  Available cryptocurrencies currently include: Bitcoin, Ethereum, and Bitcoin Cash.

## P2P Search

All markdown content is automatically added to a full-text search system.  This search capability is powered by the peers in the network.
