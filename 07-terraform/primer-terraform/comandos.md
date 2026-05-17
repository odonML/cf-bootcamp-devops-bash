```bash

# inicializa los provider y descarga lo necesario
terraform init

# test de lo que hara el apply
terraform plan

# aplica la configuraciones que ya contrui
terraform apply

# destruye lo que se aplico en las configuraciones
terraform destroy

# aplica las configuracion con las variables de entorno
erraform apply -var-file terraform.tfvars 

# prueba y guarda el resultado en un archivo .out
terraform plan -var-file terraform.tfvars -out plan.out

# aplico lo que se genero en el .out
terraform apply plan.out



```