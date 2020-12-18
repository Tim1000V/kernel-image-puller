# kernel-image-puller
Jupyter enterprise gateway kernel image puller with containerd support

# Installation

```bash
git clone https://github.com/Tim1000V/kernel-image-puller/ && \
cd kernel-image-puller && docker build ./ -t elyra/kernel-image-puller:2.0.1
```   
At this stage you will have a modified image of kernel-image-puller, the most convenient way to integrate it with enterprise gateway   
is to push this image on a private docker repository.

Then you have to put the following modifications in the enterprise-gateway deployment file.
```bash
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: kernel-image-puller
  namespace: enterprise-gateway
spec:
  selector:
    matchLabels:
      name: kernel-image-puller
  template:
    metadata:
      labels:
        name: kernel-image-puller
        app: enterprise-gateway
        component: kernel-image-puller
    spec:
      containers:
      - name: kernel-image-puller
        image: [private_registry]/elyra/kernel-image-puller:2.0.1
        imagePullPolicy: Always
        env:
          - name: KIP_GATEWAY_HOST
            value: "http://enterprise-gateway.enterprise-gateway:8888"
          - name: KIP_INTERVAL
            value: "300"
          - name: KIP_PULL_POLICY
            value: "IfNotPresent"
          - name: KIP_CRI_CLI
            value: "Yes"
          - name: KIP_CRI_SOCK
            value: "unix:///var/run/containerd/containerd.sock"
        volumeMounts:
          - name: containerdsock
            mountPath: "/var/run/containerd/containerd.sock"
      volumes:
      - name: containerdsock
        hostPath:
          path: /var/run/containerd/containerd.sock
 ```
