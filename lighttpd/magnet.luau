-- https://github.com/drduh/config/blob/master/lighttpd/magnet.luau
-- https://redmine.lighttpd.net/projects/lighttpd/wiki/Mod_magnet
lighty.content = {{ filename = "/var/www/index.html" }}
lighty.header["Content-Type"] = "text/html"
return 200
