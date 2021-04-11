# ml-platform-challenge

## Introdução

Este repositório implementa a seguinte infraestrutura utilizando 100% Terraform.

<img src="https://i.imgur.com/9q0uZIv.png">

## Estrutura do Repositório

```
.
├── lambda_sources
│   ├── clean-data
│   │   ├── main.py
│   │   ├── README.md
│   │   └── requirements.txt
│   └── get-random-beer
│       ├── main.py
│       ├── README.md
│       └── requirements.txt
├── README.md
└── terraform
    ├── envs
    │   ├── prod
    │   │   ├── terraform.tf
    │   │   ├── terraform.tfvars
    │   │   └── variables.tf
    │   └── test
    │       ├── terraform.tf
    │       ├── terraform.tfvars
    │       └── variables.tf
    └── modules
        ├── cloudwatch
        │   ├── output.tf
        │   ├── trigger.tf
        │   └── variables.tf
        ├── firehose
        │   ├── firehose.tf
        │   ├── iam.tf
        │   └── variables.tf
        ├── glue
        │   ├── glue.tf
        │   ├── iam.tf
        │   └── variables.tf
        ├── kinesis
        │   ├── iam.tf
        │   ├── kinesis.tf
        │   ├── output.tf
        │   └── variables.tf
        ├── lambda
        │   ├── iam.tf
        │   ├── lambda.tf
        │   ├── output.tf
        │   ├── pip.sh
        │   └── variables.tf
        └── s3
            ├── s3.tf
            └── variables.tf
```
## Instruções

A estrutura do repositório aponta que foi utilizado o método `Terramod` de desenvolvimento.

Para cada recurso AWS utilizado na arquitetura (CloudWatch, Firehose, Glue, Kinesis, Lambda e S3), foi desenvolvido um módulo que permitisse a reutilização e composição destes recursos na arquitetura desejada.

Cada módulo possui sua definição de recurso Terraform com seu nome (`<nome-do-recurso-aws>.tf`), um arquivo com definições de variáveis (`variables.tf`), e, quando aplicável, arquivos de criação de acessos (`iam.tf`) e saídas (`output.tf`), estas últimas podendo ser utilizadas para compor a arquitetura.

Para a maioria dos módulos, já existiam módulos prontos que poderiam ser utilizados, mas decidi criar do zero para fixar conceitos de Terraform.

A composição da arquitetura, utilizando os módulos, está na pasta `terraform/envs/[prod|test]`. A única diferença entre prod e test está no arquivo `tfvars`, sendo o primeiro para utilização em ambiente produtivo, e a o segundo para desenvolvimento.

Para criar a arquitetura, basta acessar a pasta de produção ou teste, e executar (é necessário ter o terraform instalado) no Cloud Shell da conta AWS:

```
$ terraform init
$ terraform plan
$ terraform apply
```

Em alguns minutos a arquitetura estará funcionando.

## Funções Lambda

Adotou-se a [prática recomendada](https://github.com/ozbillwang/terraform-best-practices#tips-to-deal-with-lambda-functions) para deploy de Funções Lambda utilizando Terraform.

Para tanto, o módulo lambda utiliza um recurso `null_resource` que executa a instalação de pacotes Python que estão no `requirements.txt`, e armazena o código e dependências em estrutura de dados `archive_file`, que por sua vez é enviado ao recurso terraform de criação da função lambda, eliminando a necessidade de executar esses passos manualmente.

Portanto, tudo que precisamos para fazer o deploy das funções utilizando terraform é utilizar o módulo lambda deste repositório e colocar o código fonte da função (main.py e requirements.txt) como na pasta `lambda_sources`.

## Terraservices

O método Terramod possui suas desvantagens como demonstrado [neste vídeo](https://www.youtube.com/watch?v=wgzgVm7Sqlk), mas a maior desvantagem na minha opinião é o prejuízo em _readability_ do que está sendo construído, e de quais variáveis são utilizadas (`variables.tf` e `terraform.tfvars` ficam _muito longos_).

O próximo passo de melhoria deste repositório é a utilização do método Terraservices. Para tanto, ao invés de ter um `terraform.tf` para todos os módulos da arquitetura, a ideia seria ter uma pasta para cada componente da arquitetura (com seus respectivos arquivos `terraform.tf`, `terraform.tfvars`, e `variables.tf`), com suas conexões entre módulos realizadas utilizando Estados Terraform armazenados em um backend s3, conforme exemplificado [neste repositório](https://github.com/williamtsoi1/terraservices-example). 

Esta etapa não foi realizada pois o restante do tempo do desafio foi utilizado para a criação de um [servidor web que implementa o modelo de previsão de IBU.](https://github.com/amenegola/beer-model)

## Referências

O notebook com o treinamento do modelo se encontra [neste repositório](https://github.com/amenegola/beer-model).