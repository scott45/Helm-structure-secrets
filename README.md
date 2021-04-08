# Helm-structure-secrets
Simple structure showing how to organize your helm charts, use helm secrets. 

Since you plan on using Gitlab Auto-DevOps, it’ll be using helm to deploy the app to k8s. Best way is to override the helm chart used by bundling up a chart into the project repo. 

We include a ./chart directory in the root with a chart.yaml that will be automatically detected by Auto-DevOps instead of the default one. I feel having our custom charts will enable us control how the apps are deployed in a great way.  

Good practice to handle secrets is to use the Helm Secrets plugin. (https://github.com/futuresimple/helm-secrets).

This plugin enables us to encrypt and decrypt secrets. Helm secrets uses KMS keys to achieve that

Note how I organize the the charts and environments
