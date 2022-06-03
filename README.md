# Yet Another Datacenter

The idea of this project is to provide a simple way to spin up a whole "datacenter" on demand for testing and as a quick solution to play with new applications in a multi-node setup. It should be possible to use the scripts in any environment, starting with the deployment of virtual machines on a single node to a datacenter with an infinite number of bare-metal machines (*At this point I have no idea how that should work but time will tell*).

We use **ansible** to install applications on single nodes to create a complete infrastructure starting with monitoring, 2nd day operations is currently not on the agenda. Although security does not really make sense on a single node that spins up a few virtual machines it is a basic concept of this project to enable it as soon as possible to avoid later refactoring (*At least we pretend to be the masters of the universe of shiny metal that provide vital services to the whole planet making it a better place for our children*). Instead of using packages from the repositories that are provided by any distribution we take it directly from its source creating our own service definitions for systemd, initd, etc. We focus on the application and not the system that runs it. Therefore exchanging **Debian** with **Fedora** or **Alpine** should not be an issue (*...although we are currently only supporting systemd*).

Every application should be embedded into the wider context with the least amount of dependencies. We use ansible groups to determine which application should run on which machine. Hence we have to set the premise that we assume to have only a single application that runs on multiple nodes. I.e. if we install the **node-exporter** on each machine, each node will provide its data to all nodes that run prometheus (*... one is all and all is one ...*). If the application supports clustering, all nodes within the ansible group will join the cluster.


## Test Environment with Vagrant

### Requirements

Vagrant: https://www.vagrantup.com/

Vagrant libvirt provider: https://github.com/vagrant-libvirt/vagrant-libvirt

### Starting a cluster

Start a simple cluster with Prometheus, Loki and Grafana:

```bash
$ cd vagrants/cluster
$ vagrant up
```
