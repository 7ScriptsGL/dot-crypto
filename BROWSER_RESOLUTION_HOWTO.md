# Questions:

* Would a browser will be able to resolve a domain first and apply the protocol prefix then?
* How do DNS records for sub domains work if the parent domains show these records?
* Is Cloudflare DNS over HTTPs would a satisfyng solution to resolve domains instead of direct blockchain calls for all browsers?

# Browser Resolution How-to

This document describe a recommended way to resolve blockchain domain within a classical HTTP Web Browser or a Dapp Browser.

## End user features

### HTTP Website Browsing

1. Given a blockchain domain name configured to have a DNS record attached.
2. User enters a crypto domain within an address bar of a browser.
3. A browser resolves a domain and gets specified DNS records.
4. A browser requests and displays the content using DNS protocol.

### Distributed Website Browsing

1. Given a blockchain domain name configured to have a distributed network content hash
2. User enters a crypto domain within an address bar of a browser.
3. A browser resolves a domain and gets eth content hash of the domain
4. A browser retrieves a content by the hash using a related protocol

### Redirect fallback

1. Given a blockchain domain name configured to have a redirect url and IPFS hash
2. Given a browser that doesn't suppor IPFS protocol
2. User enters a crypto domain within an address bar of a browser.
3. A browser resolves a domain to a IPFS content hash that 
4. A browser retrieves a content by the hash using a related protocol

### Resolution Configuration

1. Given a user that want to change its eth provider service.
2. User goes to browser settings crypto domains section.
3. User changes ethereum node URL from default to any other.
4. User changes Registry Address for each support crypto registry.
5. User changes network for ethereum node.
6. If network is not specified explicitly, it can be retrieved from the ethereum node URL.
7. If Registry Address is not specified, it can use a default for specified network.

## Content Display Protocol

In addition to base browser content display protocol like `http`, `https` or `ftp`. Blockchain domains can also be configured
for distributed content protocol like `ipfs`. It is strongly recommended for a browser to support the following distributed protocols:

* [IPFS](https://en.wikipedia.org/wiki/InterPlanetary_File_System#:~:text=The%20InterPlanetary%20File%20System%20(IPFS,namespace%20connecting%20all%20computing%20devices.) defining `ipfs://` protocol
* [BZZ](https://swarm-guide.readthedocs.io/en/stable/architecture.html#the-bzz-protocol) defining `bzz://` protocol

A browser may support any of traditional or distributed protocols that would still make crypto domains websites displayable.

## Records related to browser resolution

All records related to browser resolution are stored within `browser.*` namespace which has two subnamespaces:

* `browser.dns.*` - for traditional DNS records
* `brwoser.dweb.*` - for distributed content records

For a detailed records reference see [IPFS Records](./RECORDS_REFERRENCE.md).

If you are looking for a way to get records associated to a domain,
see [Domain Resolution](./ARCHITECTURE.md#domain-resolution).

## Browser Resolution Algorithm

This section explains how differrent records configuration of a domain should be interpreted by the browser.

A browser can select a protocol it has a support for.
If a domain is configured for multiple protocols, it should prioritize a protocol based on `browser.preferred_protocol` record that can be set to one of the following HTML transfer protocols:

* http
* https
* bzz
* ipfs

Browsers supporting distributed content protocol should always prioritize distributed content to be displayed for domains that do not have `browser.preferred_protocol` record set to tranditional protocol. 
A domain can have a single content hash for each distributed protocol stored in `browser.dweb.<protocol>.hash`. Ex: `browser.dweb.bzz.hash` for Swarm's `bzz` protocol.

If none of dweb hash records is set, a browser should fall back to DNS resolution that is set within `browser.dns.*` namespace.
See [DNS Records](./ARCHITECTURE.md#dns-records) for more information

Generally browsers automatically add `http://` prefix for any domain in the address bar if the protocol is not specified explicitly by the user. In case of blockchain domain names inside a browser that suppose to support many protocols, it is preferred to determine a protocol only after a domain being resolved based on specified records for a domain.


<div id="legacy-records"></div>

### Legacy Records Support

Most .crypto domains as of Q3 2020 are configured using legacy record names for IPFS hash and redirect domain:

`ipfs.html.value` deprecated in favor of `browser.dweb.ipfs.hash`
`ipfs.redirect_domain` deprecated in favor of `browser.dweb.redirect_url`

A browser is strongly recommended to support those records as a fallback when corresponding replacement records are not set.
