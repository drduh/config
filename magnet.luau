lighty.content = {{ filename = "/var/www/gif/" .. math.random(0,999) .. ".gif" }}
lighty.header["Content-Type"] = "image/gif"
return 200
