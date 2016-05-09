modules_enabled = {
    "roster";
    "saslauth";
    "tls";
    "private";
    "posix";
    "otr";
}

log = {
    debug       = "/var/log/prosody/prosody.log";
    error       = "/var/log/prosody/prosody.err";
}

admins                 = { "admin@example.com" }
allow_registration     = false
authentication         = "internal_plain"
daemonize              = true
c2s_require_encryption = true
s2s_require_encryption = true
s2s_secure_auth        = false
pidfile                = "/var/run/prosody/prosody.pid"

VirtualHost "example.com"
ssl = {
    key         = "/etc/pki/xmpp-key.pem";
    certificate = "/etc/pki/xmpp-cert.pem";
    dhparam     = "/etc/pki/dh.pem";
    options     = { "no_sslv2", "no_sslv3", "no_ticket", "no_compression" };
    depth       = "1";
    curve       = "secp384r1";
    protocols   = "tlsv1_2";
    ciphers     = "kECDH:HIGH:!MEDIUM:!LOW:!NULL:!DSS:!AES128-SHA:!AES128-SHA256:!CAMELLIA128-SHA:!eNULL:!aNULL@STRENGTH";
}
