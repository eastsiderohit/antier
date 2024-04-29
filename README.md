# antier

1.) while creating entire infra make sure that alb.yaml.tpl, install_rmq_docker.sh.tpl, loki.yaml.tpl these 3 file should come under template folder


2.) Make sure to make folder with name scripts and then keep these files buildspec.yaml, install_jenkins.sh, install_redis_docker.sh file below is the buildspec.yaml file


3.) Make sure to make folder with name ClusterAutoScaler and then put these files cluster_role.yaml, cluster_role_bindings.yaml, deployment.yaml, role.yaml, role_binding.yaml, service_account.yaml  


4.) Make sure to make folder with name Argo then under Argo folder make a folder with name Application and place these files cluster_autoscaler.yaml, external-secrets.yaml, grafana.yaml, projects.yaml, prom.yaml
