// https://github.com/drduh/config/blob/master/firefox.user.js
// https://github.com/ghacksuserjs/ghacks-user.js
// https://github.com/pyllyukko/user.js
//user_pref("browser.cache.disk.capacity", 0);  // disable disk cache
//user_pref("browser.cache.disk.enable", false);  // disable disk cache
//user_pref("browser.newtab.url", "about:blank");  // blank new tab page
//user_pref("browser.newtabpage.enabled", false);  // blank new tab page
//user_pref("browser.privatebrowsing.autostart", true);  // private browsing mode only; may break sites
//user_pref("browser.safebrowsing.malware.enabled", false);  // disable safebrowsing
//user_pref("browser.safebrowsing.phishing.enabled", false);  // disable safebrowsing
//user_pref("browser.search.widget.inNavBar", true); // move search bar to toolbar
//user_pref("browser.startup.homepage", "file:///home/web/index.html");  // custom start-up page
//user_pref("browser.startup.page", 1);  // 0: blank; 1: home; 2: last visited; 3: resume last
//user_pref("browser.uidensity", 1);  // reduce UI empty space
//user_pref("browser.urlbar.suggest.bookmark", false);  // do not suggest bookmarks
//user_pref("browser.urlbar.suggest.history", false);  // do not suggest history
//user_pref("dom.enable_performance", false);  // disable DOM timing; may break sites
//user_pref("dom.serviceWorkers.enabled", false);  // disable service workers; may break sites
//user_pref("dom.storage.enabled", false);  // disable DOM storage; will break sites
//user_pref("dom.storageManager.enabled", false);  // disable storage; may break sites
//user_pref("full-screen-api.enabled", false);  // disable fullscreen
//user_pref("gfx.xrender.enabled", true);  // may improve performance
//user_pref("javascript.enabled", false);  // disable javascript; will break sites
//user_pref("javascript.options.baselinejit", false);  // disable JS JIT; may break sites
//user_pref("javascript.options.ion", false);  // disable JS Ion; may break sites
//user_pref("layers.acceleration.disabled", true);  // disable hardware acceleration; performance hit
//user_pref("layers.acceleration.force-enabled", true);  // may improve performance on *nix
//user_pref("layout.css.devPixelsPerPx", "1.5");  // increase UI size
//user_pref("media.media-capabilities.enabled", false);  // disable media capabilities; may break sites
//user_pref("network.cookie.cookieBehavior", 1);  // block third-party cookies
//user_pref("network.cookie.lifetimePolicy", 2);  // expire cookies on browser close
//user_pref("network.dns.blockDotOnion", true);  // reject .onion domains
//user_pref("network.dns.disableIPv6", true);  // disable IPv6
//user_pref("network.http.referer.XOriginTrimmingPolicy", 2);  // limit Cross Origin path; may break sites
//user_pref("network.http.referer.defaultPolicy", 0);  // 0: no-ref; 1: same-origin; 2: strict-origin; 3: no-downgrade; may break sites
//user_pref("network.http.referer.defaultPolicy.pbmode", 0);
//user_pref("network.http.referer.trimmingPolicy", 2);  // trim Refer to scheme, host, port only; may break sites
//user_pref("network.http.sendRefererHeader", 0);  // send Referer; 0: never; 1: clicks; 2: links and images; may break sites
//user_pref("network.proxy.http", "127.0.0.1");  // proxy on localhost
//user_pref("network.proxy.http_port", 8118);  // privoxy on port 8118
//user_pref("network.proxy.no_proxies_on", "localhost, 127.0.0.1");
//user_pref("network.proxy.share_proxy_settings", true);
//user_pref("network.proxy.socks", "127.0.0.1");
//user_pref("network.proxy.socks_port", 5555);  // ssh tunnel on port 5555
//user_pref("network.proxy.socks_remote_dns", true);
//user_pref("network.proxy.ssl", "127.0.0.1");
//user_pref("network.proxy.ssl_port", 8118);  // privoxy on port 8118
//user_pref("network.proxy.type", 1);  // 1: manual; 2: PAC; 4: WPAD
//user_pref("privacy.clearOnShutdown.cookies", true);
//user_pref("privacy.clearOnShutdown.history", true);
//user_pref("privacy.cpd.cookies", true);
//user_pref("privacy.cpd.history", true);
//user_pref("privacy.donottrackheader.enabled", true);  // send DNT HTTP header
//user_pref("privacy.firstparty.isolate", true);  // isolate cookies to 1P; may break sites
//user_pref("privacy.resistFingerprinting", true);  // enable anti-fingerprinting features; may break sites
//user_pref("privacy.resistFingerprinting.letterboxing", true);  // letterbox window
//user_pref("privacy.sanitize.sanitizeOnShutdown", true);  // clear history on exit
//user_pref("privacy.trackingprotection.pbmode.enabled", false);
//user_pref("privacy.window.maxInnerHeight", 720);
//user_pref("privacy.window.maxInnerWidth", 1280);
//user_pref("security.OCSP.enabled", 1);  // enable OCSP fetching for all certs
//user_pref("security.OCSP.require", true);  // force check certificate revocation
//user_pref("security.dialog_enable_delay", 1000);  // ms delay on dialogs
//user_pref("security.ssl.require_safe_negotiation", true);  // may break sites
//user_pref("security.ssl3.rsa_aes_128_sha", false);  // disable cipher; may break sites
//user_pref("security.ssl3.rsa_aes_256_sha", false);  // disable cipher; may break sites
//user_pref("security.tls.version.min", 3);  // minimum TLS 1.2; may break sites
//user_pref("security.webauth.u2f", true);  // turn on U2F
//user_pref("svg.disabled", true);  // disable SVG rendering; may break sites
user_pref("accessibility.browsewithcaret", true);
user_pref("accessibility.force_disabled", 1);  // disable accessibility services
user_pref("accessibility.typeaheadfind", true);  // enable page search by typing
user_pref("accessibility.typeaheadfind.flashBar", 0);
user_pref("app.normandy.api_url", "");
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.first_run", false);
user_pref("app.shield.optoutstudies.enabled", false);  // disable studies
user_pref("app.update.auto", false);  // disable auto update check
user_pref("app.update.service.enabled", false);
user_pref("app.update.silent", false);  // notify on all updates states
user_pref("app.update.staging.enabled", false);  // do not stage background updates
user_pref("app.update.url", "");
user_pref("beacon.enabled", false);  // disable additional analytics
user_pref("breakpad.reportURL", "");  // disable crash reports
user_pref("browser.aboutConfig.showWarning", false);
user_pref("browser.aboutHomeSnippets.updateUrl", "");
user_pref("browser.bookmarks.max_backups", 0);
user_pref("browser.bookmarks.restore_default_bookmarks", false);
user_pref("browser.cache.disk.smart_size.enabled", false);
user_pref("browser.cache.disk.smart_size.first_run", false);
user_pref("browser.cache.disk.smart_size.use_old_max", false);
user_pref("browser.cache.disk_cache_ssl", false);  // disable caching SSL pages
user_pref("browser.cache.offline.enable", false);  // disable offline cache
user_pref("browser.cache.offline.insecure.enable", false);
user_pref("browser.casting.enabled", false);  // disable SSDP
user_pref("browser.chrome.errorReporter.enabled", false);  // disable browser error reporter
user_pref("browser.chrome.errorReporter.submitUrl", "");
user_pref("browser.contentHandlers.types.0.uri", "");
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit", false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);
user_pref("browser.crashReports.unsubmittedCheck.enabled", false);
user_pref("browser.ctrlTab.recentlyUsedOrder", false);  // control-tab cycles tabs
user_pref("browser.dictionaries.download.url", "");
user_pref("browser.disableResetPrompt", true);
user_pref("browser.discovery.enabled", false);  // disable extension recommendations
user_pref("browser.display.use_document_fonts", 0);  // disable web pages picking fonts
user_pref("browser.download.autohideButton", false);
user_pref("browser.download.forbid_open_with", true);  // disable Open With dialog
user_pref("browser.download.hide_plugins_without_extensions", false);
user_pref("browser.download.manager.addToRecentDocs", false);  // disable adding recent documents
user_pref("browser.download.manager.retention", 0);  // disable download history
user_pref("browser.download.useDownloadDir", false);
user_pref("browser.fixup.alternate.enabled", false);  // disable invalid name assistance
user_pref("browser.fixup.hide_user_pass", true);
user_pref("browser.formfill.enable", false);  // disable auto-completion
user_pref("browser.geolocation.warning.infoURL", "");
user_pref("browser.helperApps.deleteTempFileOnExit", true);
user_pref("browser.library.activity-stream.enabled", false);
user_pref("browser.link.open_newwindow", 3);  // open new windows in tabs instead
user_pref("browser.link.open_newwindow.restriction", 0);
user_pref("browser.messaging-system.whatsNewPanel.enabled", false);
user_pref("browser.newtab.preload", false);  // disable new tab tile preload
user_pref("browser.newtabpage.activity-stream.asrouter.providers.snippets", "");  // disable activity stream snippets
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr", false);  // disable extension recommendations
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("browser.newtabpage.activity-stream.disableSnippets", true);
user_pref("browser.newtabpage.activity-stream.discoverystream.optOut.0", true);
user_pref("browser.newtabpage.activity-stream.enabled", false);
user_pref("browser.newtabpage.activity-stream.feed.topsites", false);
user_pref("browser.newtabpage.activity-stream.feeds.asrouterfeed", false);  // disable activity stream feed
user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);  // disable snippets
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.prerender", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
user_pref("browser.newtabpage.activity-stream.showSearch", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry.ping.endpoint", "");
user_pref("browser.newtabpage.activity-stream.tippyTop.service.endpoint", "");
user_pref("browser.newtabpage.enhanced", false);
user_pref("browser.newtabpage.remote", false);
user_pref("browser.newtabpage.storageVersion", 1);
user_pref("browser.offline-apps.notify", true);  // notify on offline app storage
user_pref("browser.onboarding.enabled", false);  // disable new profile tour
user_pref("browser.pagethumbnails.capturing_disabled", true);
user_pref("browser.pagethumbnails.storage_version", 3);
user_pref("browser.ping-centre.production.endpoint", "");
user_pref("browser.ping-centre.staging.endpoint", "");
user_pref("browser.ping-centre.telemetry", false);  // disable PingCentre telemetry
user_pref("browser.safebrowsing.appRepURL", "");
user_pref("browser.safebrowsing.downloads.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.url", "");
user_pref("browser.safebrowsing.provider.google.reportMalwareMistakeURL", "");
user_pref("browser.safebrowsing.provider.google.reportPhishMistakeURL", "");
user_pref("browser.safebrowsing.provider.google.reportURL", "");
user_pref("browser.safebrowsing.provider.google4.dataSharing.enabled", false);  // disable safebrowsing data sharing
user_pref("browser.safebrowsing.provider.google4.dataSharingURL", "");
user_pref("browser.safebrowsing.provider.google4.reportMalwareMistakeURL", "");
user_pref("browser.safebrowsing.provider.google4.reportPhishMistakeURL", "");
user_pref("browser.safebrowsing.provider.google4.reportURL", "");
user_pref("browser.search.countryCode", "US");
user_pref("browser.search.geoSpecificDefaults", false);
user_pref("browser.search.geoSpecificDefaults.url", "");
user_pref("browser.search.geoip.url", "");  // disable geo-IP assisted search
user_pref("browser.search.hiddenOneOffs", "Bing,Amazon.com,eBay,Twitter");  // disable search providers
user_pref("browser.search.region", "US");
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.search.update", false);
user_pref("browser.search.widget.inNavBar", true);
user_pref("browser.selfsupport.url", "");  // disable user rating telemetry
user_pref("browser.send_pings", false);  // disable ping attributes
user_pref("browser.send_pings.require_same_host", true);
user_pref("browser.sessionhistory.max_entries", 10);  // limit session history
user_pref("browser.sessionstore.interval", 30000);
user_pref("browser.sessionstore.max_tabs_undo", 0);  // disable recently closed tabs
user_pref("browser.sessionstore.max_windows_undo", 0);
user_pref("browser.sessionstore.privacy_level", 2);  // disable session restore
user_pref("browser.sessionstore.resume_from_crash", false);
user_pref("browser.shell.checkDefaultBrowser", false);  // disable default check
user_pref("browser.shell.shortcutFavicons", false);  // disable shortcuts favicons
user_pref("browser.ssl_override_behavior", 1);
user_pref("browser.startup.homepage_override.buildID", "20100101");
user_pref("browser.startup.homepage_override.mstone", "ignore");  // disable welcome pages
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("browser.tabs.remote.allowLinkedWebInFileUriProcess", false);
user_pref("browser.tabs.remote.autostart.2", true);
user_pref("browser.tabs.warnOnClose", false);  // close without warning
user_pref("browser.tabs.warnOnCloseOtherTabs", false);
user_pref("browser.tabs.warnOnOpen", false);
user_pref("browser.uitour.enabled", false);  // disable UI tour
user_pref("browser.uitour.url", "");
user_pref("browser.urlbar.autoFill", false);
user_pref("browser.urlbar.autoFill.typed", false);
user_pref("browser.urlbar.autocomplete.enabled", false);
user_pref("browser.urlbar.filter.javascript", true);  // hide JS in history
user_pref("browser.urlbar.maxHistoricalSearchSuggestions", 0);  // disable local search history
user_pref("browser.urlbar.oneOffSearches", false);
user_pref("browser.urlbar.placeholderName", "DuckDuckGo");
user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);  // disable suggestions
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);  // disable sponsored suggestions
user_pref("browser.urlbar.searchSuggestionsChoice", false);
user_pref("browser.urlbar.speculativeConnect.enabled", false);  // disable preloading auto-complete URLs
user_pref("browser.urlbar.suggest.openpage", false);
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.urlbar.trimURLs", false);  // disable trim HTTP off of URLs
user_pref("browser.urlbar.usepreloadedtopurls.enabled", false);  // disable pre-loaded URLs
user_pref("browser.urlbar.userMadeSearchSuggestionsChoice", true);
user_pref("browser.xul.error_pages.expert_bad_cert", true);
user_pref("camera.control.face_detection.enabled", false);  // disable webcam face detection
user_pref("canvas.capturestream.enabled", false);  // disable canvas capture stream
user_pref("captivedetect.canonicalURL", "");  // disable captive portal helper
user_pref("clipboard.autocopy", false);  // disable automatic clipboard selection
user_pref("datareporting.healthreport.infoURL", "");
user_pref("datareporting.healthreport.service.enabled", false);
user_pref("datareporting.healthreport.service.firstRun", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("device.sensors.enabled", false);  // disable device sensors
user_pref("devtools.chrome.enabled", false);  // disable tools in browser context
user_pref("devtools.debugger.force-local", true);  // disable remote debugging
user_pref("devtools.debugger.remote-enabled", false);
user_pref("devtools.devedition.promo.url", "");
user_pref("devtools.onboarding.telemetry.logged", true);
user_pref("devtools.screenshot.audio.enabled", false);
user_pref("devtools.theme", "dark");
user_pref("devtools.webide.autoinstallADBHelper", false);
user_pref("devtools.webide.autoinstallFxdtAdapters", false);
user_pref("devtools.webide.enabled", false);  // disable WebIDE
user_pref("devtools.webide.simulatorAddonsURL", "");
user_pref("dom.IntersectionObserver.enabled", false);  // disable Intersection Observer
user_pref("dom.allow_cut_copy", false);  // disable copy-to-clipboard js functionality
user_pref("dom.battery.enabled", false);  // disable battery status
user_pref("dom.caches.enabled", false);  // disable service workers cache
user_pref("dom.disable_beforeunload", true);  // disable page leave warning
user_pref("dom.disable_open_during_load", true);  // block popups
user_pref("dom.disable_window_move_resize", true);
user_pref("dom.disable_window_open_feature.close", true);  // disable web pages from removing window features
user_pref("dom.disable_window_open_feature.location", true);
user_pref("dom.disable_window_open_feature.menubar", true);
user_pref("dom.disable_window_open_feature.minimizable", true);
user_pref("dom.disable_window_open_feature.personalbar", true);
user_pref("dom.disable_window_open_feature.resizable", true);
user_pref("dom.disable_window_open_feature.status", true);
user_pref("dom.disable_window_open_feature.titlebar", true);
user_pref("dom.disable_window_open_feature.toolbar", true);
user_pref("dom.enable_resource_timing", false);  // disable resource timing
user_pref("dom.event.clipboardevents.enabled", false);  // disable notify on clipboard events
user_pref("dom.event.contextmenu.enabled", false);  // disable web page control over right-click context
user_pref("dom.event.highrestimestamp.enabled", true);  // enable DOMHighResTimeStamp
user_pref("dom.flyweb.enabled", false);  // disable local discovery
user_pref("dom.forms.autocomplete.formautofill", true);
user_pref("dom.forms.datetime", false);
user_pref("dom.gamepad.enabled", false);  // disable USB enumeration
user_pref("dom.imagecapture.enabled", false);  // disable camera image capture
user_pref("dom.ipc.plugins.flash.subprocess.crashreporter.enabled", false);
user_pref("dom.ipc.plugins.reportCrashURL", false);
user_pref("dom.mozTCPSocket.enabled", false);  // disable raw tcp sockets
user_pref("dom.netinfo.enabled", false);  // disable network information api
user_pref("dom.network.enabled", false);  // disable network information api
user_pref("dom.popup_allowed_events", "click dblclick");  // limit popup-triggering events
user_pref("dom.popup_maximum", 2);  // maximum of 2 popups from a single event
user_pref("dom.push.connection.enabled", false);  // disable push notifications
user_pref("dom.push.enabled", false);
user_pref("dom.push.serverURL", "");
user_pref("dom.push.userAgentID", "");
user_pref("dom.telephony.enabled", false);  // disable telephony API
user_pref("dom.vibrator.enabled", false);  // disable screen shake
user_pref("dom.vr.enabled", false);  // disable VR devices
user_pref("dom.w3c_pointer_events.enabled", false);  // disable PointerEvents
user_pref("dom.w3c_touch_events.enabled", 0);  // disable touch events
user_pref("dom.webaudio.enabled", false);  // disable web audio
user_pref("dom.webnotifications.enabled", false);  // disable web notifications
user_pref("dom.webnotifications.serviceworker.enabled", false);  // disable web notifications
user_pref("experiments.activeExperiment", false);
user_pref("experiments.enabled", false);
user_pref("experiments.manifest.uri", "");
user_pref("experiments.supported", false);
user_pref("extensions.autoDisableScopes", 15);
user_pref("extensions.blocklist.enabled", false);  // disable extension blacklisting
user_pref("extensions.blocklist.pingCountTotal", 4);
user_pref("extensions.blocklist.pingCountVersion", 0);
user_pref("extensions.blocklist.url", "https://blocklists.settings.services.mozilla.com/v1/blocklist/3/%20/%20/");
user_pref("extensions.enabledScopes", 1);  // lock down allowed extension directories
user_pref("extensions.formautofill.addresses.enabled", false);  // disable form auto-fill
user_pref("extensions.formautofill.available", "off");
user_pref("extensions.formautofill.creditCards.enabled", false);
user_pref("extensions.formautofill.heuristics.enabled", false);
user_pref("extensions.fxmonitor.enabled", false);  // disable Monitor
user_pref("extensions.getAddons.cache.enabled", false);  // disable add-on metadata updates
user_pref("extensions.getAddons.databaseSchema", 5);
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.pocket.enabled", false);  // disable Pocket
user_pref("extensions.screenshots.disabled", true);  // disable Screenshots
user_pref("extensions.screenshots.system-disabled", true);
user_pref("extensions.screenshots.upload-disabled", true);
user_pref("extensions.shield-recipe-client.api_url", "");
user_pref("extensions.shield-recipe-client.enabled", false);
user_pref("extensions.systemAddon.update.enabled", false);  // disable system addon updates
user_pref("extensions.systemAddon.update.url", "");
user_pref("extensions.ui.dictionary.hidden", true);
user_pref("extensions.ui.experiment.hidden", true);
user_pref("extensions.ui.locale.hidden", true);
user_pref("extensions.update.autoUpdateDefault", false);
user_pref("extensions.webcompat-reporter.enabled", false);  // disable web compatibility reporter
user_pref("extensions.webservice.discoverURL", "");
user_pref("font.blacklist.underline_offset", "");  // disable special underline handling
user_pref("gecko.handlerService.migrated", true);
user_pref("gecko.handlerService.schemes.webcal.0.uriTemplate", "");
user_pref("general.buildID.override", "20100101");
user_pref("general.warnOnAboutConfig", false);  // disable about:config warning
user_pref("geo.enabled", false);  // no geo-location
user_pref("geo.provider.ms-windows-location", false);  // disable geo on windows
user_pref("geo.provider.use_corelocation", false);  // disable geo on mac
user_pref("geo.provider.use_gpsd", false);  // disable geo on linux
user_pref("geo.wifi.logging.enabled", false);
user_pref("geo.wifi.uri", "");
user_pref("gfx.downloadable_fonts.woff2.enabled", false);
user_pref("gfx.font_rendering.graphite.enabled", false);
user_pref("gfx.font_rendering.opentype_svg.enabled", false);
user_pref("gfx.offscreencanvas.enabled", false);  // disable offscreen canvas
user_pref("identity.fxaccounts.enabled", false);  // disable Firefox accounts sync
user_pref("intl.accept_languages", "en-US, en");
user_pref("intl.charset.fallback.override", "utf-8");
user_pref("intl.locale.requested", "en-US");
user_pref("intl.regional_prefs.use_os_locales", false);  // don't use OS to determine locale
user_pref("javascript.options.asmjs", false);
user_pref("javascript.options.shared_memory", false);  // disable shared memory
user_pref("javascript.options.wasm", false);  // disable webassembly
user_pref("javascript.use_us_english_locale", true);
user_pref("keyword.enabled", false);  // do not submit invalid URLs to search engine
user_pref("layout.css.font-loading-api.enabled", false);
user_pref("layout.css.visited_links_enabled", false);  // disable CSS page history
user_pref("layout.spellcheckDefault", 2);  // spell-check; 0: none; 1: multi-line; 2: multi- and single-line
user_pref("lightweightThemes.persisted.footerURL", false);
user_pref("lightweightThemes.persisted.headerURL", false);
user_pref("lightweightThemes.update.enabled", false);  // disable themes auto updates
user_pref("loop.logDomains", false);  // disable more telemetry
user_pref("mathml.disabled", true);  // disable Mathematical Markup Language
user_pref("media.autoplay.default", 2);  // HTML5 media - 0: allow; 1: block; 2: prompt
user_pref("media.autoplay.default", 5);
user_pref("media.block-autoplay-until-in-foreground", true);  // disable auto-play in background tabs
user_pref("media.eme.apiVisible", false);  // disable DRM profiling
user_pref("media.eme.enabled", false);  // disable DRM HTML5 content
user_pref("media.getusermedia.audiocapture.enabled", false);  // disable audio capture
user_pref("media.getusermedia.browser.enabled", false);  // disable WebRTC getUserMedia
user_pref("media.getusermedia.screensharing.enabled", false);  // disable screen-sharing
user_pref("media.gmp-gmpopenh264.autoupdate", false);  // disable OpenH264 codec by Cisco
user_pref("media.gmp-gmpopenh264.enabled", false);
user_pref("media.gmp-manager.updateEnabled", false);
user_pref("media.gmp-manager.url", "data:text/plain,");
user_pref("media.gmp-manager.url.override", "data:text/plain,");
user_pref("media.gmp-provider.enabled", false);
user_pref("media.gmp-widevinecdm.autoupdate", false);
user_pref("media.gmp-widevinecdm.enabled", false);  // disable DRM HTML5 content
user_pref("media.gmp-widevinecdm.visible", false);
user_pref("media.gmp.storage.version.observed", 1);
user_pref("media.gmp.trial-create.enabled", false);
user_pref("media.navigator.enabled", false);  // disable media device enumeration
user_pref("media.navigator.video.enabled", false);
user_pref("media.ondevicechange.enabled", false);  // disable media devices change detection
user_pref("media.peerconnection.enabled", false);
user_pref("media.peerconnection.ice.default_address_only", true);
user_pref("media.peerconnection.ice.no_host", true);
user_pref("media.peerconnection.ice.proxy_only", true);
user_pref("media.peerconnection.ice.tcp", false);
user_pref("media.peerconnection.identity.enabled", false);
user_pref("media.peerconnection.identity.timeout", 1);
user_pref("media.peerconnection.turn.disable", true);
user_pref("media.peerconnection.use_document_iceservers", false);
user_pref("media.peerconnection.video.enabled", false);
user_pref("media.video_stats.enabled", false);  // disable video statistics
user_pref("media.videocontrols.picture-in-picture.video-toggle.enabled", false);
user_pref("media.webspeech.recognition.enable", false);  // disable speech recognition
user_pref("media.webspeech.synth.enabled", false);  // disable speech synthesis
user_pref("middlemouse.contentLoadURL", false);  // disable open URLs from clibpard with middle click
user_pref("network.IDN_show_punycode", true);  // reduce phishing risk
user_pref("network.allow-experiments", false);  // disable experiments
user_pref("network.auth.subresource-http-auth-allow", 1);  // disable non-secure authentication
user_pref("network.captive-portal-service.enabled", false);  // disable captive portal helper
user_pref("network.connectivity-service.enabled", false);  // disable network connectivity checks
user_pref("network.connectivity-service.enabled", false);  // don't help with captive portals
user_pref("network.cookie.leave-secure-alone", true);  // disable non-secure sites setting secure cookies
user_pref("network.cookie.thirdparty.nonsecureSessionOnly", true);
user_pref("network.cookie.thirdparty.sessionOnly", true);
user_pref("network.dns.disablePrefetch", true);  // disable DNS prefetch
user_pref("network.dns.disablePrefetchFromHTTPS", true);
user_pref("network.file.disable_unc_paths", true);  // disable Uniform Naming Convention paths
user_pref("network.ftp.enabled", false);  // disable FTP
user_pref("network.gio.supported-protocols", "");  // disable Gvfs/GIO
user_pref("network.http.altsvc.enabled", false);  // disable HTTP Alternative Services
user_pref("network.http.altsvc.oe", false);
user_pref("network.http.redirection-limit", 5);  // limit HTTP redirects
user_pref("network.http.referer.XOriginPolicy", 1);  // only send Referer to same domain
user_pref("network.http.referer.hideOnionSource", true);
user_pref("network.http.spdy.enabled", false);  // disable HTTP2
user_pref("network.http.spdy.enabled.deps", false);
user_pref("network.http.spdy.enabled.http2", false);
user_pref("network.http.spdy.websockets", false);
user_pref("network.http.speculative-parallel-limit", 0);  // disable speculative loading
user_pref("network.jar.open-unsafe-types", false);
user_pref("network.manage-offline-status", false);  // do not monitor OS connection state
user_pref("network.negotiate-auth.allow-insecure-ntlm-v1", false);  // disable NTLMv1
user_pref("network.negotiate-auth.allow-insecure-ntlm-v1-https", false);  // disable all NTLM
user_pref("network.predictor.cleaned-up", true);
user_pref("network.predictor.enable-prefetch", false);  // disable prefetching
user_pref("network.predictor.enabled", false);  // disable "Necko" predictive service
user_pref("network.prefetch-next", false);  // disable prefetching
user_pref("network.protocol-handler.expose-all", false);  // whitelist URL handlers
user_pref("network.protocol-handler.expose.about", true);
user_pref("network.protocol-handler.expose.blob", true);
user_pref("network.protocol-handler.expose.chrome", true);
user_pref("network.protocol-handler.expose.data", true);
user_pref("network.protocol-handler.expose.file", true);
user_pref("network.protocol-handler.expose.ftp", true);
user_pref("network.protocol-handler.expose.http", true);
user_pref("network.protocol-handler.expose.https", true);
user_pref("network.protocol-handler.expose.javascript", true);
user_pref("network.protocol-handler.expose.moz-extension", true);
user_pref("network.protocol-handler.external.about", false);
user_pref("network.protocol-handler.external.blob", false);
user_pref("network.protocol-handler.external.chrome", false);
user_pref("network.protocol-handler.external.data", false);
user_pref("network.protocol-handler.external.file", false);
user_pref("network.protocol-handler.external.ftp", false);
user_pref("network.protocol-handler.external.http", false);
user_pref("network.protocol-handler.external.https", false);
user_pref("network.protocol-handler.external.javascript", false);
user_pref("network.protocol-handler.external.moz-extension", false);
user_pref("network.protocol-handler.external.ms-windows-store", false);
user_pref("network.protocol-handler.warn-external-default", true);
user_pref("network.stricttransportsecurity.preloadlist", true);  // preload HSTS
user_pref("network.trr.bootstrapAddress", "");
user_pref("network.trr.mode", 0);  // disable trusted recursive resolver
user_pref("network.trr.uri", "");
user_pref("offline-apps.allow_by_default", false);
user_pref("pdfjs.disabled", true);  // disable PDF viewer
user_pref("pdfjs.enableWebGL", false);
user_pref("pdfjs.migrationVersion", 2);
user_pref("pdfjs.previousHandler.alwaysAskBeforeHandling", true);
user_pref("pdfjs.previousHandler.preferredAction", 4);
user_pref("permissions.default.camera", 2);
user_pref("permissions.default.desktop-notification", 2);
user_pref("permissions.default.geo", 2);
user_pref("permissions.default.microphone", 2);
user_pref("permissions.default.shortcuts", 2);
user_pref("permissions.default.xr", 2);
user_pref("permissions.manager.defaultsUrl", "");
user_pref("permissions.memory_only", true);  // disable storing permission changes to disk
user_pref("plugin.default.state", 0);
user_pref("plugin.defaultXpi.state", 0);
user_pref("plugin.disable_full_page_plugin_for_types", "application/pdf");
user_pref("plugin.scan.plid.all", false);  // disable plugin scan
user_pref("plugin.sessionPermissionNow.intervalInMinutes", 0);  // always ask for activation
user_pref("plugin.state.flash", 0);  // disable flash
user_pref("plugin.state.java", 0);  // disable java
user_pref("plugin.state.libgnome-shell-browser-plugin", 0);  // disable gnome shell integration
user_pref("plugins.click_to_play", true);  // require plugin activation
user_pref("pref.browser.homepage.disable_button.current_page", false);
user_pref("pref.privacy.disable_button.cookie_exceptions", false);
user_pref("privacy.clearOnShutdown.cache", true);
user_pref("privacy.clearOnShutdown.downloads", true);
user_pref("privacy.clearOnShutdown.formdata", true);
user_pref("privacy.clearOnShutdown.offlineApps", true);
user_pref("privacy.clearOnShutdown.openWindows", true);
user_pref("privacy.clearOnShutdown.sessions", true);
user_pref("privacy.clearOnShutdown.siteSettings", true);
user_pref("privacy.cpd.cache", true);
user_pref("privacy.cpd.downloads", true);
user_pref("privacy.cpd.formdata", true);
user_pref("privacy.cpd.offlineApps", true);
user_pref("privacy.cpd.sessions", true);
user_pref("privacy.history.custom", true);
user_pref("privacy.resistFingerprinting.block_mozAddonManager", true);  // disable mozAddonManager
user_pref("privacy.sanitize.pending", "[]");
user_pref("privacy.sanitize.timeSpan", 0);  // set default clear history range to all time
user_pref("privacy.trackingprotection.cryptomining.enabled", true);
user_pref("privacy.trackingprotection.enabled", true);  // https://wiki.mozilla.org/Security/Tracking_protection
user_pref("privacy.trackingprotection.fingerprinting.enabled", true);
user_pref("privacy.trackingprotection.introCount", 20);
user_pref("privacy.trackingprotection.ui.enabled", true);
user_pref("privacy.userContext.enabled", true);
user_pref("privacy.userContext.longPressBehavior", 2);  // long-press on + tab button to open container menu
user_pref("privacy.userContext.ui.enabled", true);  // enable container tabs setting
user_pref("privacy.usercontext.about_newtab_segregation.enabled", true);
user_pref("security.cert_pinning.enforcement_level", 2);  // strict pinning enforcement
user_pref("security.csp.enable", true);  // enforce Content Security Policy
user_pref("security.csp.experimentalEnabled", true);  // enable experimental CSP features
user_pref("security.data_uri.block_toplevel_data_uri_navigations", true);
user_pref("security.fileuri.strict_origin_policy", true);
user_pref("security.insecure_connection_icon.enabled", true);
user_pref("security.insecure_connection_text.enabled", true);
user_pref("security.insecure_field_warning.contextual.enabled", true);
user_pref("security.insecure_password.ui.enabled", true);  // warn on non-secure forms
user_pref("security.mixed_content.block_active_content", true);  // disable insecure content on HTTPS pages
user_pref("security.mixed_content.block_display_content", true);
user_pref("security.mixed_content.block_object_subrequest", true);
user_pref("security.pki.sha1_enforcement_level", 1);  // block SHA1 certs
user_pref("security.sri.enable", true);  // enable Subresource Integrity
user_pref("security.ssl.disable_session_identifiers", true);  // disable SSL Session IDs
user_pref("security.ssl.enable_ocsp_must_staple", true);
user_pref("security.ssl.enable_ocsp_stapling", true);
user_pref("security.ssl.errorReporting.automatic", false);  // do not report TLS errors
user_pref("security.ssl.errorReporting.enabled", false);
user_pref("security.ssl.errorReporting.url", "");
user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
user_pref("security.ssl3.dhe_dss_aes_128_sha", false);
user_pref("security.ssl3.dhe_dss_aes_256_sha", false);
user_pref("security.ssl3.dhe_dss_camellia_128_sha", false);
user_pref("security.ssl3.dhe_dss_camellia_256_sha", false);
user_pref("security.ssl3.dhe_dss_des_ede3_sha", false);
user_pref("security.ssl3.dhe_rsa_aes_128_sha", false);
user_pref("security.ssl3.dhe_rsa_aes_256_sha", false);
user_pref("security.ssl3.dhe_rsa_camellia_128_sha", false);
user_pref("security.ssl3.dhe_rsa_camellia_256_sha", false);
user_pref("security.ssl3.dhe_rsa_des_ede3_sha", false);
user_pref("security.ssl3.ecdh_ecdsa_aes_128_sha", false);
user_pref("security.ssl3.ecdh_ecdsa_aes_256_sha", false);
user_pref("security.ssl3.ecdh_ecdsa_des_ede3_sha", false);
user_pref("security.ssl3.ecdh_ecdsa_null_sha", false);
user_pref("security.ssl3.ecdh_ecdsa_rc4_128_sha", false);
user_pref("security.ssl3.ecdh_rsa_aes_128_sha", false);
user_pref("security.ssl3.ecdh_rsa_aes_256_sha", false);
user_pref("security.ssl3.ecdh_rsa_des_ede3_sha", false);
user_pref("security.ssl3.ecdh_rsa_null_sha", false);
user_pref("security.ssl3.ecdh_rsa_rc4_128_sha", false);
user_pref("security.ssl3.ecdhe_ecdsa_aes_128_gcm_sha256", true);
user_pref("security.ssl3.ecdhe_ecdsa_aes_128_sha", false);
user_pref("security.ssl3.ecdhe_ecdsa_aes_256_sha", true);
user_pref("security.ssl3.ecdhe_ecdsa_chacha20_poly1305_sha256", true);
user_pref("security.ssl3.ecdhe_ecdsa_des_ede3_sha", false);
user_pref("security.ssl3.ecdhe_ecdsa_null_sha", false);
user_pref("security.ssl3.ecdhe_ecdsa_rc4_128_sha", false);
user_pref("security.ssl3.ecdhe_rsa_aes_128_gcm_sha256", true);
user_pref("security.ssl3.ecdhe_rsa_aes_128_sha", false);
user_pref("security.ssl3.ecdhe_rsa_aes_256_sha", true);
user_pref("security.ssl3.ecdhe_rsa_chacha20_poly1305_sha256", true);
user_pref("security.ssl3.ecdhe_rsa_des_ede3_sha", false);
user_pref("security.ssl3.ecdhe_rsa_null_sha", false);
user_pref("security.ssl3.ecdhe_rsa_rc4_128_sha", false);
user_pref("security.ssl3.rsa_1024_rc4_56_sha", false);
user_pref("security.ssl3.rsa_camellia_128_sha", false);
user_pref("security.ssl3.rsa_camellia_256_sha", false);
user_pref("security.ssl3.rsa_des_ede3_sha", false);
user_pref("security.ssl3.rsa_fips_des_ede3_sha", false);
user_pref("security.ssl3.rsa_null_md5", false);
user_pref("security.ssl3.rsa_null_sha", false);
user_pref("security.ssl3.rsa_rc2_40_md5", false);
user_pref("security.ssl3.rsa_rc4_128_md5", false);
user_pref("security.ssl3.rsa_rc4_128_sha", false);
user_pref("security.ssl3.rsa_rc4_40_md5", false);
user_pref("security.ssl3.rsa_seed_sha", false);
user_pref("security.tls.enable_0rtt_data", false);  // disable TLS1.3 0-RTT
user_pref("security.tls.version.fallback-limit", 3);  // disable insecure fallback
user_pref("security.xpconnect.plugin.unrestricted", false);  // disable scripting of plugins by javascript
user_pref("services.blocklist.update_enabled", true);
user_pref("services.sync.clients.lastSync", "0");
user_pref("services.sync.declinedEngines", "");
user_pref("services.sync.globalScore", 0);
user_pref("services.sync.nextSync", 0);
user_pref("services.sync.tabs.lastSync", "0");
user_pref("shield.savant.enabled", false);
user_pref("shumway.disabled", true);  // disable Mozilla Flash
user_pref("signon.autofillForms", false);
user_pref("signon.autofillForms.http", false);
user_pref("signon.formlessCapture.enabled", false);
user_pref("signon.rememberSignons", false);  // disable saving passwords
user_pref("startup.homepage_override_url", "");
user_pref("startup.homepage_welcome_url", "");
user_pref("startup.homepage_welcome_url.additional", "");
user_pref("toolkit.cosmeticAnimations.enabled", false);  // disable animations
user_pref("toolkit.coverage.endpoint.base", "");
user_pref("toolkit.coverage.opt-out", true);  // disable telemetry coverage
user_pref("toolkit.crashreporter.infoURL", "");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.cachedClientID", "");
user_pref("toolkit.telemetry.coverage.opt-out", true);  // disable telemetry coverage
user_pref("toolkit.telemetry.enabled", false);  // disable Mozilla telemetry
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.hybridContent.enabled", false);
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
user_pref("ui.use_standins_for_native_colors", true);  // disable exposing system colors to canvas
user_pref("webchannel.allowObject.urlWhitelist", "");
user_pref("webgl.disable-extensions", true);  // disable Web Graphics Library
user_pref("webgl.disable-fail-if-major-performance-caveat", true);
user_pref("webgl.disabled", true);  // disable WebGL
user_pref("webgl.dxgl.enabled", false);
user_pref("webgl.enable-debug-renderer-info", false);  // do not expose graphics driver information
user_pref("webgl.enable-webgl2", false);
user_pref("webgl.min_capability_mode", true);
user_pref("xpinstall.signatures.required", true);  // extensions must be signed
