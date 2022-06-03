service {
  id     = "prometheus"
  name   = "prometheus"	
  checks = [
    {
	    id       = "https"
	    name     = "https"
      args     = [
        "curl",
        "--cacert",
        "{{ consul.config_dir }}/ssl/prometheus-ca.pem",
        "--cert",
        "{{ consul.config_dir }}/ssl/prometheus-client.pem",
        "--key",
        "{{ consul.config_dir }}/ssl/prometheus-client-key.pem",
        "https://{{ inventory_hostname }}.{{ domain }}:{{ prometheus.port }}/api/v1/label/job/values"
      ]
      interval = "10s"
    }
  ]
}
