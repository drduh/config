-- https://github.com/drduh/config/blob/master/prosody.cfg.lua
modules_enabled = {
    "roster";
    "saslauth";
    "tls";
    "private";
    "posix";
    "dialback";
}
log = {
    debug       = "/var/log/prosody/prosody.log";
    error       = "/var/log/prosody/prosody.err";
}
admins                 = { "admin@example.com" }
allow_registration     = false
authentication         = "internal_hashed"
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
    depth       = "1";
    protocols   = "tlsv1_2";
    ciphers     = "EECDH+ECDSA+AESGCM:EECDH+aRSA+AESGCM:EECDH+ECDSA+SHA384:EECDH+ECDSA+SHA256:EECDH+aRSA+SHA384:EECDH+aRSA+SHA256:!LOW:!3DES:!MD5:!EXP:!PSK:!SRP:!DSS:!RC4";
}
