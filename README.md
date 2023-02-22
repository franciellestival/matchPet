</p>
<h1 align="center">
  #MatchPet APP
</h1>

<p align="center">
 <a href="#-sobre-o-projeto">Sobre</a> •
 <a href="#-funcionalidades">Funcionalidades</a> •
 <a href="#-layout">Layout</a> • 
 <a href="#-como-executar-o-projeto">Como executar</a> • 
 <a href="#-tecnologias">Tecnologias</a>
</p>


## 💻 Sobre o projeto

:cat: Este é um aplicativo desenvolvido em Flutter para ajudar a conectar pessoas que desejam adotar animais de estimação com animais que precisam de um lar.
O aplicativo permite a disponibilização e busca de animais disponíveis para adoção, bem como o contato seguro entre as partes envolvidas.
Há também a possibilidade de divulgar animais que estão desaparecidos, para o recebimento de informações;

---

## ⚙️ Funcionalidades

- [x] Cadastro e login de usuário
- [x] Cadastro de animail disponível para adoção ou dessaparecido
- [x] Visualização dos animais que estão disponíveis ou desaparecidos
  - - [x] Listagem ordenada por distância, do animal mais próximo ao mais distante ao usuário
- [x] Busca por filtro
- [x] Marcar um animal como favorito
- [x] Demonstrar interesse de adoção em um animal
  - - [x] Liberar/Recusar a liberação do número de telefone para que o usuário entre em contato
- [x] Confirmar a adoção do pet

---

## 🎨 Layout

O layout da aplicação está disponível no Figma:

<a href="https://www.figma.com/file/t2uI393RIfNGt6nvinNObT/V1">
  <img alt="MatchPet Layout" src="https://img.shields.io/badge/Acessar%20Layout%20-Figma-%2304D361">
</a>


<p align="center">

![Captura de Tela 2023-02-22 às 11 31 35](https://user-images.githubusercontent.com/66281304/220653057-73d0566d-5c42-4852-bbeb-60831eaf814e.png)

</p>

---

## 🚀 Como executar o projeto

💡 Pré-requisitos

Antes de começar, você vai precisar ter instalado em sua máquina o framework Flutter:
[Flutter](https://flutter.dev/docs/get-started/install), com [Adroid Studio](https://developer.android.com/studio).
Além disto é bom ter um editor para trabalhar com o código como [VSCode](https://code.visualstudio.com/)

#### 🎲 Rodando o aplicativo

```bash

# Clone este repositório
$ git clone git@github.com:franciellestival/matchPet.git

# Acesse a pasta do projeto no terminal/cmd
$ cd matchPet/

# Instale as dependências
$ flutter pub get

# Certifique-se de ter um emulador Android ou iOS configurado ou um dispositivo físico conectado ao seu computador

# Execute o aplicativo
$ flutter run

```

---

## 🛠 Tecnologias

As seguintes ferramentas foram usadas na construção do projeto:

#### **Aplicativo**  ([Flutter](https://flutter.dev/)  +  [Dart](https://dart.dev/))

#### **Bibliotecas** 

-   Get - Gerenciador de estado
-   Geolocator - Features de localização
-   Firebase - Features de notificação e messages in app
-   Dio - acesso a API 

---

## Organização das pastas

As pastas desse projeto foram organizadas em módulos:

Árvore de arquivos :

```
├── app
│   ├── lib
│   │   └── di
│   │   └── middlewares
│   │   └── pages
│   │   └── routes
│   │   └── services
│   ├── assets
│   ├── android
│   ├── ios
├── modules
│   ├── api_services
│   ├── extensions
│   ├── pet_profile
│   │   └── controller
│   │   └── models
│   │   └── pages
│   │   └── repository
│   │   └── services
│   │   └── widgets
│   ├── theme
│   └── user profile
│   │   └── controller
│   │   └── models
│   │   └── pages
│   │   └── repository
│   │   └── services
│   │   └── widgets
