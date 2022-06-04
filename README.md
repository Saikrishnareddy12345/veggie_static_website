Install cert-manager in Kubernetes Cluster.

Cmd:-kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.0.1/cert-manager-legacy.yaml

=============================================================================================================
it will install cert manager packages on your k8s cluster


Kubernetes Nginx Ingress Controller LetsEncrypt
To configure Kubernetes Nginx Ingress Controller LetsEncrypt , navigate to cert manager acme ingress page, 
go to Configure Let’s Encrypt Issuer, copy the let’s encrypt issuer yml and change as shown below.

Cmd:-sudo vi letsencrypt-issuer.yml

apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
  namespace: static1
spec:
  acme:
    # The ACME server URL
    server: https://acme-v02.api.letsencrypt.org/directory
    # Email address used for ACME registration
    email: saikrish9966793136@gmail.com
    # Name of a secret used to store the ACME account private key
    privateKeySecretRef:
      name: letsencrypt-prod
    # Enable the HTTP-01 challenge provider
    solvers:
    - http01:
        ingress:
          class: nginx



====================================================================================================================
Creating Nginx Ingress Let’s Encrypt TLS Certificate

Cmd:-sudo vi letsencrypt-cert.yml

apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: static1.saikrish.xyz
  namespace: static1
spec:
  secretName: static1.saikrish.xyz-tls
  issuerRef:
    name: letsencrypt-prod
    kind: ClusterIssuer
  commonName: static1.saikrish.xyz
  dnsNames:
  - static1.saikrish.xyz
=======================================================================================================================
Now, You should edit the ingress Object.

Cmd:-kubectl get certificates static1.saikrish.xyz
Cmd:-kubectl get secrets static1.saikrish.xyz-tls
Cmd:-kubectl edit ingress static-ingress

# Please edit the object below. Lines beginning with a '#' will be ignored,
# and an empty file will abort the edit. If an error occurs while saving this file will be
# reopened with the relevant failures.
#
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"extensions/v1beta1","kind":"Ingress","metadata":{"annotations":{},"name":"static-ingress","namespace":"static1"},"spec":{"rules":[{"host":"static1.saikrish.xyz","http":{"paths":[{"backend":{"serviceName":"static-svc","servicePort":80},"path":null}]}}]}}
  creationTimestamp: "2022-06-04T13:38:52Z"
  generation: 2
  name: static-ingress
  namespace: static1
  resourceVersion: "22537"
  selfLink: /apis/extensions/v1beta1/namespaces/static1/ingresses/static-ingress
  uid: a42c915d-32a1-4cbc-8b58-dc9c122b802b
spec:
  rules:
  - host: static1.saikrish.xyz
    http:
      paths:
      - backend:
          serviceName: static-svc
          servicePort: 80
        pathType: ImplementationSpecific
  tls:
  - hosts:
    - static1.saikrish.xyz
    secretName: static1.saikrish.xyz-tls
status:
  loadBalancer:
    ingress:
    - hostname: aa0830932f93442efb12c4dfe233ac5d-2c3a1c89b2e83d67.elb.ap-south-1.amazonaws.com


============================================================================================================================

