# Finance App

Um aplicativo moderno de gerenciamento financeiro desenvolvido com Flutter.

## Funcionalidades

- Registro de receitas e despesas
- Categorização de transações
- Interface moderna e intuitiva
- Suporte a temas claro e escuro
- Armazenamento local de dados
- Gerenciamento de estado com BLoC

## Tecnologias Utilizadas

- Flutter
- Dart
- BLoC (Business Logic Component)
- Hive (Armazenamento local)
- Freezed (Imutabilidade e serialização)
- Material Design 3

## Requisitos

- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0

## Instalação

1. Clone o repositório:
```bash
git clone https://github.com/seu-usuario/finance_app.git
```

2. Entre no diretório do projeto:
```bash
cd finance_app
```

3. Instale as dependências:
```bash
flutter pub get
```

4. Execute o projeto:
```bash
flutter run
```

## Estrutura do Projeto

```
lib/
  ├── core/
  │   └── theme/
  │       └── app_theme.dart
  ├── features/
  │   └── transactions/
  │       ├── data/
  │       │   └── repositories/
  │       │       └── transaction_repository.dart
  │       ├── domain/
  │       │   └── models/
  │       │       └── transaction.dart
  │       └── presentation/
  │           ├── bloc/
  │           │   └── transaction_bloc.dart
  │           ├── pages/
  │           │   ├── transactions_page.dart
  │           │   └── add_transaction_page.dart
  │           └── widgets/
  │               ├── transaction_list_item.dart
  │               └── add_transaction_fab.dart
  └── main.dart
```

## Arquitetura

O projeto segue os princípios da Clean Architecture e utiliza o padrão BLoC para gerenciamento de estado. A estrutura do projeto está organizada em camadas:

- **Presentation**: Contém os widgets, páginas e lógica de apresentação
- **Domain**: Contém as regras de negócio e modelos
- **Data**: Contém a implementação dos repositórios e fontes de dados

## Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Faça commit das suas alterações (`git commit -m 'Adiciona nova feature'`)
4. Faça push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request

## Licença

Este projeto está licenciado sob a licença MIT - veja o arquivo [LICENSE](LICENSE) para mais detalhes. 