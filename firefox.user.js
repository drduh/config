// https://github.com/drduh/config/blob/main/firefox.user.js
//user_pref("browser.newtabpage.enabled", false);  // blank new tab page
//user_pref("browser.privatebrowsing.autostart", true);  // private browsing mode only; may break sites
//user_pref("browser.quitShortcut.disabled", true);  // disable control-q to quit
//user_pref("browser.safebrowsing.malware.enabled", false);  // disable safebrowsing
//user_pref("browser.safebrowsing.phishing.enabled", false);  // disable safebrowsing
//user_pref("browser.startup.homepage_override.buildID", "20181001000000");
//user_pref("browser.startup.page", 0);  // 0: blank; 1: home; 2: last visited; 3: resume last
//user_pref("browser.uidensity", 1);  // reduce UI empty space
//user_pref("browser.urlbar.autoFill", false);
//user_pref("browser.urlbar.maxRichResults", 0);
//user_pref("browser.urlbar.suggest.bookmark", false);
//user_pref("browser.urlbar.suggest.engines", false);
//user_pref("browser.urlbar.suggest.history", false);
//user_pref("browser.urlbar.suggest.openpage", false);
//user_pref("device.sensors.enabled", false);  // disable device sensors
//user_pref("dom.enable_performance", false);  // disable DOM timing; may break sites
//user_pref("dom.security.https_only_mode", true);
//user_pref("extensions.blocklist.enabled", false);  // disable extension blacklisting (includes revocations)
//user_pref("extensions.systemAddon.update.enabled", false);
//user_pref("extensions.systemAddon.update.url", "");
//user_pref("full-screen-api.enabled", false);  // disable fullscreen
//user_pref("gfx.downloadable_fonts.enabled", false);
//user_pref("gfx.downloadable_fonts.fallback_delay", -1);
//user_pref("gfx.font_rendering.graphite.enabled", false);
//user_pref("gfx.font_rendering.opentype_svg.enabled", false);
//user_pref("gfx.xrender.enabled", true);  // may improve performance
//user_pref("javascript.enabled", false);  // disable javascript; will break sites
//user_pref("layout.css.devPixelsPerPx", "1.5");  // increase UI size
//user_pref("layout.css.visited_links_enabled", false);
//user_pref("mathml.disabled", true);  // disable Mathematical Markup Language
//user_pref("media.ondevicechange.enabled", false);  // disable media devices change detection
//user_pref("media.video_stats.enabled", false);  // disable video statistics
//user_pref("media.webspeech.synth.enabled", false);  // disable speech synthesis
//user_pref("network.cookie.cookieBehavior", 1);  // block third-party cookies
//user_pref("network.http.referer.XOriginPolicy", 1);  // only send Referer to same domain; may break sites
//user_pref("network.http.referer.defaultPolicy", 0);  // 0: no-ref; 1: same-origin; 2: strict-origin; 3: no-downgrade; may break sites
//user_pref("network.http.referer.trimmingPolicy", 2);  // trim Refer to scheme, host, port only; may break sites
//user_pref("network.http.sendRefererHeader", 0);  // send Referer; 0: never; 1: clicks; 2: links and images; may break sites
//user_pref("network.proxy.allow_bypass", false);
//user_pref("network.proxy.socks", "127.0.0.1");
//user_pref("network.proxy.socks_port", 5555);
//user_pref("network.trr.bootstrapAddress", "9.9.9.9");
//user_pref("network.trr.custom_uri", "Quad9");
//user_pref("network.trr.mode", 2);
//user_pref("network.trr.uri", "https://dns.quad9.net:5053/dns-query");
//user_pref("permissions.memory_only", true);  // disable storing permission changes to disk
//user_pref("privacy.fingerprintingProtection.pbmode", true);
//user_pref("privacy.resistFingerprinting", true);  // enable strict fingerprinting resistance features; may break sites
//user_pref("privacy.resistFingerprinting.block_mozAddonManager", true);  // disable mozAddonManager
//user_pref("privacy.resistFingerprinting.letterboxing", true);  // letterbox window
//user_pref("privacy.sanitize.sanitizeOnShutdown", true);  // clear history on exit
//user_pref("privacy.window.maxInnerHeight", 900);
//user_pref("privacy.window.maxInnerWidth", 1600);
//user_pref("security.dialog_enable_delay", 1000);  // ms delay on dialogs
//user_pref("svg.disabled", true);  // disable SVG (Scalable Vector Graphics)
//user_pref("ui.use_standins_for_native_colors", true);  // disable exposing system colors to canvas
//user_pref("webgl.disabled", true);  // disable WebGL (Web Graphics Library)
//user_pref("webgl.enable-debug-renderer-info", false);  // do not expose graphics driver information
//user_pref("webgl.enable-webgl2", false);
user_pref("accessibility.browsewithcaret", true);
user_pref("accessibility.typeaheadfind", true);  // enable page search by typing
user_pref("accessibility.typeaheadfind.flashBar", 0);
user_pref("app.normandy.api_url", "");
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.first_run", false);
user_pref("app.shield.optoutstudies.enabled", false);  // disable studies
user_pref("app.update.suppressPrompts", true);
user_pref("breakpad.reportURL", "");  // disable crash reports
user_pref("browser.aboutConfig.showWarning", false);
user_pref("browser.bookmarks.max_backups", 0);
user_pref("browser.bookmarks.restore_default_bookmarks", false);
user_pref("browser.cache.disk.enable", false);  // disable disk cache
user_pref("browser.contentHandlers.types.0.uri", "");
user_pref("browser.ctrlTab.recentlyUsedOrder", false);  // control-tab cycles tabs
user_pref("browser.dictionaries.download.url", "");
user_pref("browser.disableResetPrompt", true);
user_pref("browser.discovery.enabled", false);  // disable extension recommendations
user_pref("browser.display.use_document_fonts", 0);  // disable web pages picking fonts
user_pref("browser.download.always_ask_before_handling_new_types", true);
user_pref("browser.download.autohideButton", false);
user_pref("browser.download.forbid_open_with", true);  // disable Open With dialog
user_pref("browser.download.manager.addToRecentDocs", false);  // disable adding to recent documents
user_pref("browser.download.useDownloadDir", false);  // always prompt for download location
user_pref("browser.formfill.enable", false);  // disable auto-completion
user_pref("browser.geolocation.warning.infoURL", "");
user_pref("browser.helperApps.deleteTempFileOnExit", true);
user_pref("browser.link.open_newwindow", 3);  // open new windows in tabs instead
user_pref("browser.link.open_newwindow.restriction", 0);
user_pref("browser.ml.chat.enabled", false);
user_pref("browser.newtabpage.activity-stream.default.sites", "");
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredCheckboxes", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("browser.newtabpage.enabled", false);  // blank new tab
user_pref("browser.newtabpage.remote", false);
user_pref("browser.pagethumbnails.capturing_disabled", true);
user_pref("browser.ping-centre.production.endpoint", "");
user_pref("browser.ping-centre.staging.endpoint", "");
user_pref("browser.places.speculativeConnect.enabled", false);
user_pref("browser.privatebrowsing.forceMediaMemoryCache", true);
user_pref("browser.safebrowsing.downloads.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.enabled", false);
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.search.update", false);
user_pref("browser.search.widget.inNavBar", true);  // move search bar to toolbar
user_pref("browser.sessionstore.interval", 30000);
user_pref("browser.sessionstore.max_tabs_undo", 0);  // disable recently closed tabs
user_pref("browser.sessionstore.privacy_level", 2);  // disable session restore
user_pref("browser.sessionstore.resume_from_crash", false);
user_pref("browser.shell.checkDefaultBrowser", false);  // disable default check
user_pref("browser.shell.shortcutFavicons", false);  // disable shortcuts favicons
user_pref("browser.startup.homepage", "about:blank");
user_pref("browser.startup.homepage_override.mstone", "ignore");  // disable welcome pages
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("browser.tabs.hoverPreview.enabled", false);
user_pref("browser.tabs.searchclipboardfor.middleclick", false);  // disable open url tab with middle click
user_pref("browser.uitour.enabled", false);  // disable UI tour
user_pref("browser.uitour.url", "");
user_pref("browser.urlbar.addons.featureGate", false);
user_pref("browser.urlbar.amp.featureGate", false);
user_pref("browser.urlbar.fakespot.featureGate", false);
user_pref("browser.urlbar.mdn.featureGate", false);
user_pref("browser.urlbar.pocket.featureGate", false);
user_pref("browser.urlbar.showSearchTerms.enabled", false);
user_pref("browser.urlbar.speculativeConnect.enabled", false);
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.urlbar.suggest.topsites", false);
user_pref("browser.urlbar.trending.featureGate", false);
user_pref("browser.urlbar.trimURLs", false);  // do not trim url prefix
user_pref("browser.urlbar.weather.featureGate", false);
user_pref("browser.urlbar.wikipedia.featureGate", false);
user_pref("browser.urlbar.yelp.featureGate", false);
user_pref("browser.xul.error_pages.expert_bad_cert", true);
user_pref("captivedetect.canonicalURL", "");  // disable captive portal helper
user_pref("clipboard.autocopy", false);  // disable automatic clipboard selection
user_pref("datareporting.healthreport.infoURL", "");
user_pref("datareporting.healthreport.service.firstRun", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("devtools.debugger.force-local", true);  // disable remote debugging
user_pref("devtools.devedition.promo.url", "");
user_pref("devtools.onboarding.telemetry.logged", true);
user_pref("devtools.screenshot.audio.enabled", false);
user_pref("devtools.theme", "dark");
user_pref("dom.disable_window_move_resize", true);
user_pref("dom.event.clipboardevents.enabled", false);  // limit clipboard API
user_pref("dom.event.contextmenu.enabled", false);  // disable web page control over right-click context
user_pref("dom.forms.autocomplete.formautofill", true);
user_pref("dom.popup_allowed_events", "click dblclick");  // limit pop-up triggers
user_pref("dom.push.enabled", false);  // disable push notifications
user_pref("dom.push.userAgentID", "");  // remove push notification subscriptions
user_pref("dom.webaudio.enabled", false);  // disable web audio
user_pref("dom.webgpu.enabled", false);  // disable GPU access
user_pref("dom.webnotifications.enabled", false);  // disable web notifications
user_pref("extensions.enabledScopes", 5);  // limit extensions to profile and application directories
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.creditCards.enabled", false);
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("extensions.postDownloadThirdPartyPrompt", false);
user_pref("extensions.webcompat-reporter.enabled", false);
user_pref("gecko.handlerService.migrated", true);
user_pref("gecko.handlerService.schemes.webcal.0.uriTemplate", "");
user_pref("general.warnOnAboutConfig", false);  // disable about:config warning
user_pref("geo.enabled", false);  // no geo-location
user_pref("geo.provider.use_corelocation", false);  // disable geo on mac
user_pref("geo.provider.use_geoclue", false);  // disable geo on linux
user_pref("gfx.webgpu.force-enabled", false);  // disable GPU access
user_pref("identity.fxaccounts.enabled", false);  // disable Firefox accounts sync
user_pref("javascript.options.asmjs", false);
user_pref("javascript.options.baselinejit", false);  // disable JS JIT; may break sites
user_pref("javascript.options.ion", false);  // disable JS Ion; may break sites
user_pref("javascript.options.jit_trustedprincipals", true);
user_pref("javascript.options.wasm", false);  // disable webassembly
user_pref("keyword.enabled", false);  // do not submit invalid URLs to search engine
user_pref("layout.spellcheckDefault", 0);  // spell-check; 0: none; 1: multi-line; 2: multi- and single-line
user_pref("media.autoplay.default", 2);  // HTML5 media - 0: allow; 1: block; 2: prompt
user_pref("media.eme.enabled", false);  // disable EME (Encryption Media Extension)
user_pref("media.gmp-provider.enabled", false);  // disable GMP (Gecko Media Plugins)
user_pref("media.memory_cache_max_size", 65536);
user_pref("media.navigator.enabled", false);  // disable media device enumeration
user_pref("media.peerconnection.enabled", false);  // disable WebRTC (Real Time Comm)
user_pref("media.peerconnection.ice.default_address_only", true);
user_pref("media.peerconnection.ice.no_host", true);
user_pref("media.peerconnection.ice.proxy_only_if_behind_proxy", true);
user_pref("network.IDN_show_punycode", true);  // reduce phishing risk
user_pref("network.auth.subresource-http-auth-allow", 1);  // disable non-secure authentication
user_pref("network.captive-portal-service.enabled", false);  // disable captive portal helper
user_pref("network.connectivity-service.enabled", false);  // disable network connectivity checks
user_pref("network.dns.blockDotOnion", true);  // reject onion domains
user_pref("network.dns.disableIPv6", true);  // disable IPv6
user_pref("network.dns.disablePrefetch", true);  // disable DNS prefetch
user_pref("network.dns.disablePrefetchFromHTTPS", true);
user_pref("network.file.disable_unc_paths", true);  // disable Uniform Naming Convention paths
user_pref("network.gio.supported-protocols", "");  // disable Gvfs/GIO
user_pref("network.http.referer.XOriginTrimmingPolicy", 2);
user_pref("network.http.referer.spoofSource", false);
user_pref("network.http.speculative-parallel-limit", 0);  // disable speculative loading
user_pref("network.httpredirection-limit", 5);  // limit HTTP redirects
user_pref("network.manage-offline-status", false);  // do not monitor OS connection state
user_pref("network.predictor.enable-prefetch", false);  // disable prefetching
user_pref("network.predictor.enabled", false);  // disable "Necko" predictive service
user_pref("network.prefetch-next", false);  // disable link prefetching
user_pref("network.proxy.http", "127.0.0.1");  // proxy on localhost
user_pref("network.proxy.http_port", 8118);  // privoxy on port 8118
user_pref("network.proxy.no_proxies_on", "localhost, 127.0.0.1");
user_pref("network.proxy.share_proxy_settings", true);
user_pref("network.proxy.socks_remote_dns", true);
user_pref("network.proxy.ssl", "127.0.0.1");
user_pref("network.proxy.ssl_port", 8118);  // privoxy on port 8118
user_pref("network.proxy.type", 1);  // 1: manual; 2: PAC; 4: WPAD
user_pref("pdfjs.enableScripting", false);
user_pref("permissions.manager.defaultsUrl", "");
user_pref("pref.browser.homepage.disable_button.current_page", false);
user_pref("pref.privacy.disable_button.cookie_exceptions", false);
user_pref("privacy.fingerprintingProtection", true);  // more compatible than resistFingerprinting
user_pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CSSPrefersColorScheme");  // dark mode support
user_pref("privacy.resistFingerprinting.pbmode", true);
user_pref("privacy.resistFingerprinting.target_video_res", 2160);  // default to high-res videos
user_pref("privacy.trackingprotection.enabled", true);  // https://wiki.mozilla.org/Security/Tracking_protection
user_pref("privacy.trackingprotection.introCount", 20);
user_pref("privacy.userContext.enabled", true);  // enable container tabs
user_pref("privacy.userContext.ui.enabled", true);  // enable container tabs ui
user_pref("security.OCSP.require", true);  // hard-fail on ocsp unreachable
user_pref("security.cert_pinning.enforcement_level", 2);  // strict PKP enforcement
user_pref("security.csp.reporting.enabled", false);
user_pref("security.ssl.require_safe_negotiation", true);
user_pref("security.ssl.require_safe_negotiation", true);  // require secure renegotiation
user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
user_pref("security.tls.enable_0rtt_data", false);  // disable TLS1.3 0-RTT
user_pref("security.tls.version.min", 3);  // minimum TLS 1.2
user_pref("signon.autofillForms", false);
user_pref("signon.formlessCapture.enabled", false);
user_pref("signon.management.page.breach-alerts.enabled", false);
user_pref("signon.rememberSignons", false);  // disable saving passwords
user_pref("startup.homepage_override_url", "");
user_pref("startup.homepage_welcome_url", "");
user_pref("startup.homepage_welcome_url.additional", "");
user_pref("toolkit.coverage.endpoint.base", "");
user_pref("toolkit.coverage.opt-out", true);  // disable telemetry coverage
user_pref("toolkit.crashreporter.infoURL", "");
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.coverage.opt-out", true);  // disable telemetry coverage
user_pref("toolkit.telemetry.enabled", false);  // disable telemetry
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.infoURL", "");
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.previousBuildID", "");
user_pref("toolkit.telemetry.prompted", 2);
user_pref("toolkit.telemetry.rejected", true);
user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.unified", false);  // disable telemetry
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("toolkit.winRegisterApplicationRestart", false);  // disable session restore
user_pref("ui.key.menuAccessKey", 0);  // disable Alt key for menu
user_pref("ui.systemUsesDarkTheme", 1);
