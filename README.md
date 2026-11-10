# ♻️ EcoTecidos — Plataforma de Descarte Sustentável de Tecidos

**Projeto Final — Desenvolvedor Full Stack | +PraTi**

O **EcoTecidos** é uma aplicação web voltada ao descarte consciente de resíduos têxteis, conectando doadores a pontos de coleta e incentivando práticas de economia circular por meio de cashback e educação ambiental.

## 🌐 Acesse a aplicação

**Aplicação publicada:** https://ecotecidos-deploy.onrender.com

A aplicação está hospedada no Render e integra frontend React, backend Java/Spring Boot e banco de dados PostgreSQL.

## 🎯 Objetivo

Promover a destinação adequada de resíduos têxteis por meio de uma plataforma digital que facilita a localização de pontos de coleta, o registro de descartes e o acesso a conteúdos sobre sustentabilidade.

## 🚀 Funcionalidades

O projeto contempla:

- Cadastro e autenticação de usuários com JWT.
- Perfis de acesso para doadores, operadores, gerentes e administradores.
- Consulta e gerenciamento de pontos de coleta.
- Solicitações e acompanhamento de descartes de tecidos.
- Sistema de cashback vinculado aos descartes confirmados.
- Conteúdos educativos sobre sustentabilidade e economia circular.
- Gerenciamento de perfil e favoritos.
- Persistência de dados em PostgreSQL.

**Validação inicial da aplicação publicada:** foram testados com sucesso o carregamento da página inicial, a navegação, o cadastro de conta, o login, a persistência de dados após atualização e operações de cadastro ou consulta. As demais funcionalidades devem ser avaliadas individualmente.

## 🛠️ Tecnologias utilizadas

| Camada | Tecnologias |
|---|---|
| Frontend | React 19, Vite 8, JavaScript, Tailwind CSS |
| Backend | Java 21, Spring Boot 4 |
| Segurança | Spring Security, JWT |
| Banco de dados | PostgreSQL, Spring Data JPA |
| Migrações | Flyway |
| Documentação da API | OpenAPI / Swagger |
| Infraestrutura | Docker, Nginx |
| Hospedagem | Render |
| Versionamento | Git e GitHub |

## 🏗️ Arquitetura da aplicação

A aplicação utiliza uma arquitetura cliente-servidor.

```text
Usuário
   |
   v
Render — HTTPS
   |
   v
Nginx (porta 10000)
   |
   +-- / --------> React / Vite
   |
   +-- /api/v1 --> Spring Boot (porta 8080)
                         |
                         v
                   PostgreSQL
```

O Nginx entrega os arquivos estáticos do frontend e encaminha as requisições `/api/v1` para a API Spring Boot.

O backend utiliza uma arquitetura em camadas, com controllers, services, repositories, DTOs e entidades.

## 📂 Repositórios

**Frontend:**  
https://github.com/rafael-kuchla-flores/Descarte_Tecidos

**Backend:**  
https://github.com/lucastnsoares/ecotecidos-api

**Integração e deploy:**  
https://github.com/brunasdr9412/ecotecidos-deploy

O repositório de integração contém os arquivos de configuração utilizados para construir e executar frontend e backend em um único serviço.

## 🐳 Deploy com Docker

O `Dockerfile` utiliza múltiplas etapas de construção:

1. Clona os repositórios de frontend e backend.
2. Instala as dependências e compila o frontend com Node.js.
3. Compila o backend com Maven e Java 21.
4. Prepara a imagem de execução com Java e Nginx.
5. Disponibiliza a aplicação por uma única URL HTTPS no Render.

O frontend utiliza `VITE_API_URL=/api/v1`, permitindo que as chamadas à API sejam encaminhadas pelo Nginx.

### Variáveis de ambiente

As principais configurações de produção são:

```env
SPRING_PROFILES_ACTIVE=prod
SERVER_PORT=8080
DB_HOST=<database-host>
DB_PORT=5432
DB_NAME=<database-name>
DB_USER=<database-user>
DB_PASSWORD=<database-password>
TOKEN_JWT_SECRET=<secure-random-secret>
FRONTEND_URL=<public-application-url>
API_SECURITY_CORS_ALLOWED_ORIGINS=<public-application-url>
SEED_ENABLED=false
```

**Importante:** as credenciais devem ser configuradas diretamente no Render. Nunca devem ser publicadas no GitHub.

## 💻 Execução local

### Frontend

Pré-requisitos: Node.js compatível com o projeto e npm.

```bash
git clone https://github.com/rafael-kuchla-flores/Descarte_Tecidos.git
cd Descarte_Tecidos/Descarte_Tecidos
npm ci
npm run dev
```

O frontend utiliza a variável `VITE_API_URL` para definir o endereço da API. Para executar o sistema integrado localmente, configure essa variável com o endereço do backend em execução.

### Backend

Pré-requisitos: Java 21 e PostgreSQL configurado.

```bash
git clone https://github.com/lucastnsoares/ecotecidos-api.git
cd ecotecidos-api
```

Configure as variáveis de ambiente conforme o README do backend. Para executar com Maven Wrapper:

**Windows:**

```powershell
.\mvnw.cmd spring-boot:run
```

**Linux/macOS:**

```bash
./mvnw spring-boot:run
```

O backend também disponibiliza configuração com Docker Compose, documentada no próprio repositório.

## 📖 Documentação da API

O backend utiliza OpenAPI/Swagger para documentar os endpoints REST.

A disponibilidade do Swagger em produção depende da configuração `SWAGGER_ENABLED`. Consulte o README do backend para os caminhos e parâmetros de acesso.

## 🧪 Testes

Na primeira validação da aplicação publicada, foram confirmadas:

- [x] Exibição da página inicial.
- [x] Navegação entre páginas.
- [x] Cadastro de usuário.
- [x] Autenticação.
- [x] Persistência de dados após atualizar a página.
- [x] Cadastro ou consulta de informações.

Esses testes representam uma verificação funcional inicial, não uma homologação completa de todos os fluxos.

## ⚠️ Considerações sobre hospedagem

O projeto está publicado no plano gratuito do Render, sujeito a limitações de recursos e possíveis períodos de inatividade.

Arquivos armazenados somente no disco local do contêiner não possuem persistência garantida após reinicializações ou novos deploys.

Como o Dockerfile busca os repositórios externos durante a construção, novas alterações nos repositórios de origem não são automaticamente incorporadas ao serviço publicado. É necessário executar um novo build/deploy para atualizar a aplicação.

## 🌱 Impacto esperado

O EcoTecidos busca facilitar o descarte responsável de tecidos, incentivar a participação de cidadãos e parceiros e ampliar o acesso à informação sobre sustentabilidade e economia circular.

---

**Desenvolvido em equipe como projeto final do programa +PraTi.**# ecotecidos-deploy
