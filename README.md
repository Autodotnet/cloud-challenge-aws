# Cloud Resume Challenge - AWS

Um projeto Cloud completo de aplicação web, um currículo online com contador de visitantes, implementado usando serviços AWS e Infrastructure as Code.

## 🎯 Sobre o Projeto

The Cloud Resume Challenge é um projeto hands-on feito para preencher lacunas de conhecimento deixadas pelas certificações de Cloud. Ele incorpora várias skills que engenherios de Cloud e DevOps usam no dia a dia. 

https://cloudresumechallenge.dev/docs/the-challenge/aws/

## 🏗️ Arquitetura

- **Frontend**: Site estático hospedado no S3 com CloudFront
- **Backend**: API Gateway + Lambda Functions (Python)
- **Banco de Dados**: DynamoDB
- **Infrastructure as Code**: Terraform
- **CI/CD**: Automatização de deploy (em construção)

  ![446302384-cedea404-911f-431d-bae7-fd61f69e3abd](https://github.com/user-attachments/assets/00de3710-1146-4aa5-b940-22ea34fe3e2f)


## 🚀 Tecnologias Utilizadas

- **AWS Services**: S3, CloudFront, API Gateway, Lambda, DynamoDB, ACM (AWS Certificate Manager)
- **Languages**: Python, JavaScript, HTML, CSS
- **Infrastructure**: Terraform
- **Version Control**: Git
- **DNS**: Cloudflare
- **SSO**: IAM Identity Center


## 📁 Estrutura do Projeto

```
├── frontend/           # Código do site estático
│   ├── index.html     # Página principal
│   ├── assets/        # Imagens e recursos
│   └── scripts/       # JavaScript
├── backend/           # Funções Lambda
│   ├── lambda_get.py  # Buscar contador
│   └── lambda_update_item.py # Atualizar contador
└── terraform/         # Infrastructure as Code
    ├── backend-api/   # API e Lambda
    └── frontend/      # S3 e CloudFront
```

## 🛠️ Como Executar

### Pré-requisitos
- AWS CLI configurado
- Terraform instalado
- Conta AWS ativa

### Deploy da Infraestrutura

1. **Backend (API + Database)**:
```bash
cd terraform/backend-api
terraform init
terraform plan
terraform apply
```

2. **Frontend (S3 + CloudFront)**:
```bash
cd terraform/frontend
terraform init
terraform plan
terraform apply
```

## 🌐 Demo

O site está disponível em: [umamicloudchallenge.org](https://www.umamicloudchallenge.org)

## 📊 Funcionalidades

- ✅ Currículo online responsivo
- ✅ Contador de visitantes em tempo real
- ✅ API REST para gerenciar dados
- ✅ Infrastructure as Code
- ✅ HTTPS e domínio customizado

## 👨‍💻 Autor

**Allan Zanella**
- 📧 Email: allan_zan@hotmail.com
- 💼 LinkedIn: [allan-zanella](https://www.linkedin.com/in/allan-zanella)
- 🏆 Certificações: AWS Solutions Architect Associate, AWS Cloud Practitioner
