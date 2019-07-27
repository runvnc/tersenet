# NoScriptWeb

For some context, read  [Adblocking, How about Nah?](https://www.eff.org/deeplinks/2019/07/adblocking-how-about-nah)

NoScriptWeb is a new type of lightweight, high-performance web browser that is *100% JavaScript free*. Pages are encoded in an encrypted, size-limited subset of markdown distributed in a content-oriented (rather than server-centric) fashion. They load almost instantly from network peers.

## Ad-free

It is impossible for ads from the traditional web to display in NoScriptWeb, or for companies to track you -- because no content or links from the traditional web can be displayed by NoScriptWeb browsers.

This web browser is a relatively simple system, rather than an entire operating system-in-a-box like Chrome or Firefox. It is supported by decentralized (mostly p2p) protocols.
 
 ## Markdown subset
 
NoScriptWeb Markdown supports the following features: headings (with `#`), escape with backtick, bold, italics, and links (only to other NoScriptWeb pages, e.g. nsw://reports.frontline/aug2019austin).
 
 ## Attachments
 
All non-markdown content (except for one small image) are loaded *only* upon demand by the user.
 
Media and applications can be attached to pages, but have restrictions.  No more than 10KB of images will be loaded by default.

Other than that small image, media must be launched explicitly from the Media tab.  Zero bytes will be loaded, processed, or transmitted without prompting by the user.

### Media attachments

Pages may attach images or videos.  Their descriptions appear on the Media Tab.  Users must switch tabs and click the individual media item before any loading or processing is done.  Images and media may not be loaded from traditional web sources outside of NoScriptWeb approved protocols.

### Application attachments


Attached applications could be web assembly with I/O abilities such as a simple canvas-like UI.

If you can find or create a suitable and high performance p2p system (or group of systems) for enabling people to load and publish these lightweight links, you could provide a useful and viable alternative to the traditional web that would be approachable by small development teams.

## P2P Search

All markdown content is automatically added to a full-text search system.  This search capability is powered by the peers in the network.
