# K3s/K8s NFS-backed webapp deployment

This project provides scripts and Kubernetes manifests to deploy an NGINX-based web application on a K3s or compatible Kubernetes cluster, using an NFS share for persistent storage.

## Project Structure

```

├── create_kube_services.sh
├── files
│   ├── webapp_configmap.yaml
│   ├── webapp_deployment.yaml
│   ├── webapp_pv.yaml
│   ├── webapp_pvc.yaml
│   └── webapp_service.yaml
├── install_nfs.sh
└── README.md

```

## Prerequisites

- Ubuntu-based system (for NFS server)
- K3s or compatible Kubernetes cluster
- `kubectl` installed and configured

## Setup Instructions

### 1. Install and Configure NFS Server

Run the following as root on the NFS server (IP 192.168.55.240):

```sh
sudo bash install_nfs.sh
```

This will:
- Install NFS server packages
- Create `/tmp/share1` and an `index.html`
- Export the directory for the cluster node(s)

### 2. Deploy to Kubernetes

Run the following on your Kubernetes master node:

```sh
bash create_kube_services.sh
```

This will:
- Create the `webapp` namespace (if not present)
- Apply the PV, PVC, ConfigMap, Deployment, and Service resources 

### 3. Access the Web Application

The NGINX service is exposed on NodePort `31234`. You can access it at:

```
http://192.168.55.240:31234/ in web browser or test with - curl 192.168.55.240:31234
```

Author:
- Dmitri Donskoy
- Email: crooper22@gmail.com


## License

MIT License
