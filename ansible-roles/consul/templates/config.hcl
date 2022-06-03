#
# general (https://www.consul.io/docs/agent/config/config-files#general)
#

datacenter = "{{ consul_datacenter | default(consul.datacenter) }}"
data_dir   = "{{ consul.data_dir }}"
log_level  = "INFO"
node_name  = "{{ inventory_hostname }}"
server     = {% if consul_server %}true{% else %}false{% endif %}

client_addr = "0.0.0.0"
bind_addr  = "0.0.0.0"

advertise_addr_ipv4 = "0.0.0.0"


ports {
    http     = 8500
    https    = 8501
    grpc     = 8502
    dns      = 8600

    server   = 8300
    serf_lan = 8301
    serf_wan = 8302

    sidecar_min_port = 21000
    sidecar_max_port = 21255

    expose_min_port = 21500
    expose_max_port = 21755
}

enable_script_checks       = true
enable_local_script_checks = true

#
# encrpytion (https://www.consul.io/docs/agent/config/config-files#encryption-parameters)
#

encrypt = "{{ consul_encryption_key }}"



#
# join (https://www.consul.io/docs/agent/config/config-files#join-parameters)
#

retry_join = [{% for host in groups['consul'] %}"{{ hostvars[host].ansible_hostname }}"{% if not loop.last %},{% endif %}{% endfor %}]


{% if consul_server %}
#
#  bootstrap (https://www.consul.io/docs/agent/config/config-files#bootstrap-parameters)
#

bootstrap_expect = {{ groups['consul'] | length }}
{% endif %}



#
# ui (https://www.consul.io/docs/agent/config/config-files#ui-parameters)
#

ui_config {
    enabled  = true
}


#
# TLS (https://www.consul.io/docs/agent/config/config-files#tls-configuration-reference)
#

tls {
    https {
        ca_file         = "{{ consul.config_dir }}/ssl/ca.pem"
        cert_file       = "{{ consul.config_dir }}/ssl/cert.pem"
        key_file        = "{{ consul.config_dir }}/ssl/key.pem"
    }
    grpc {
        ca_file         = "{{ consul.config_dir }}/ssl/ca.pem"
        cert_file       = "{{ consul.config_dir }}/ssl/cert.pem"
        key_file        = "{{ consul.config_dir }}/ssl/key.pem"
    }
}

server_name = "{{ inventory_hostname }}"
