## Initialize helm against the cluster
init:
	@ kubectl create serviceaccount tiller --namespace  kube-system
	@ kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
	@ helm init --service-account tiller
## [chart] [environment] Encrypt chart secrets file
encrypt:
	@ helm secrets enc charts/$(CHART)/$(ENV)/secrets.yaml

## [chart] [environment] Edit secrets file (when needing to change or add more secrets)
edit:
	@ helm secrets edit charts/$(CHART)/$(ENV)/secrets.yaml
## [chart] [environment] Preview rendered templates
template:
	@ helm template charts/$(CHART) --name "$(ENV)-$(CHART)" \
    -f charts/$(CHART)/$(ENV)/values.yaml \
    -f charts/$(CHART)/$(ENV)/secrets.yaml

## [chart] [environment] Install helm chart to k8s cluster
install:
	@ helm install charts/$(CHART) --name "$(ENV)-$(CHART)" --namespace $(NMSPACE) \
     -f charts/$(CHART)/$(ENV)/values.yaml \
     -f charts/$(CHART)/$(ENV)/secrets.yaml

## [chart] [environment] Update helm release with new changes
upgrade:
	@ helm upgrade "$(ENV)-$(CHART)" charts/$(CHART) --namespace $(CHART) \
    -f charts/$(CHART)/$(ENV)/values.yaml \
    -f charts/$(CHART)/$(ENV)/secrets.yaml

## [chart] [environment] Delete  a helm release from store and make it free for later use
delete:
	@ echo "$(ENV)-$(CHART)"
	@ helm delete --purge "$(ENV)-$(CHART)"
