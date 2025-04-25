# WordCounter

Um aplicativo simples em Elixir para contar a frequência de palavras em arquivos de texto.

## Funcionalidades

- Conta a ocorrência de cada palavra em um arquivo de texto
- Ignora diferenças entre maiúsculas e minúsculas (case insensitive)
- Remove pontuação e caracteres especiais
- Ordena as palavras por frequência de forma decrescente
- Suporte a caracteres Unicode

## Instalação

Para usar este projeto localmente, clone o repositório e instale as dependências:

```bash
git clone https://github.com/seu-usuario/word_counter.git
cd word_counter
mix deps.get
```

## Uso

Existem duas maneiras de usar este aplicativo:

### Como uma biblioteca

Você pode usar o WordCounter em seu código Elixir:

```elixir
case WordCounter.count_words("caminho/para/arquivo.txt") do
  {:error, reason} ->
    IO.puts("Erro ao ler arquivo: #{reason}")

  result ->
    Enum.each(result, fn {word, count} ->
      IO.puts("#{word}: #{count}")
    end)
end
```

### Como uma aplicação autônoma

Execute o projeto com o Mix:

```bash
mix run -e 'Main.main' -- caminho/para/arquivo.txt
```

O resultado será exibido no formato:

```
palavra1: 5
palavra2: 3
palavra3: 1
```

## Exemplos

Para um arquivo com o texto "Hello, World! Hello. world? HELLO-world.":

```
hello: 3
world: 2
```

## Testes

Para executar os testes:

```bash
mix test
```

## Licença

[Adicionar informações de licença aqui]

## Contribuição

Contribuições são bem-vindas! Por favor, sinta-se à vontade para enviar um Pull Request.

1. Fork o projeto
2. Crie sua branch (`git checkout -b feature/nova-funcionalidade`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/nova-funcionalidade`)
5. Abra um Pull Request

