###ADO-02 – Fundamentação de Banco de Dados Relacional

Autor: Thomas Lamounier Tema do projeto: Pokémon (nome, número na Pokédex e jogos em que aparecem)

1. Banco de dados relacional

Um banco de dados relacional guarda as informações em tabelas que se ligam umas às outras (por isso "relacional").

Tabela: um conjunto de dados sobre um mesmo assunto. No meu projeto, a tabela pokemon guarda os Pokémon e a tabela jogo guarda os jogos.
Linha (registro): um item da tabela. Exemplo: a linha do Pikachu.
Coluna (atributo): uma característica que todos os itens têm. Exemplo: nome, numero_pokedex.

Exemplo da tabela pokemon:

id_pokemon	numero_pokedex	nome
1	1	Bulbasaur
2	25	Pikachu

Aqui cada linha é um Pokémon e cada coluna é uma informação sobre ele.

Diferença para um banco não relacional: no relacional, os dados ficam em tabelas com colunas definidas antes e ligadas por chaves. Em um banco não relacional , os dados ficam em documentos parecidos com JSON, e cada documento pode ter campos diferentes. Por exemplo, o Pikachu poderia ser um documento só, com a lista de jogos dentro dele:

json
{ "nome": "Pikachu", "numero": 25, "jogos": ["Red", "Yellow"] }

No relacional, essa mesma informação seria dividida em tabelas separadas.

2. Entidade, atributo e relacionamento
Entidade: algo do mundo real sobre o qual quero guardar dados. Vira uma tabela.
Atributo: uma característica da entidade. Vira uma coluna.
Relacionamento: a ligação entre duas entidades.

No meu projeto:

Entidade	Atributos
POKEMON	id_pokemon, numero_pokedex, nome
JOGO	id_jogo, nome, data_lancamento

Relacionamento: um Pokémon aparece em um ou mais jogos, e um jogo tem vários Pokémon.

3. Cardinalidade

A cardinalidade diz quantos registros de uma entidade podem se ligar a quantos da outra.

1:1 (um para um)

Um registro de A se liga a no máximo um de B, e vice-versa. Exemplo (não faz parte do meu projeto, só para ilustrar): cada Pokémon tem uma entrada na Pokédex com a descrição, e cada entrada pertence a um Pokémon.

1:N (um para muitos)

Um registro de A se liga a vários de B, mas cada B se liga a um só A. Exemplo (também só para ilustrar): uma geração tem vários jogos (a Geração 1 tem Red, Blue e Yellow), mas cada jogo pertence a uma geração. A chave estrangeira fica no lado "N", ou seja, na tabela jogo.

N:N (muitos para muitos)

Um registro de A se liga a vários de B, e um B se liga a vários de A. Exemplo (é o do meu projeto): o Pikachu aparece em vários jogos, e cada jogo tem vários Pokémon.

Por que o N:N precisa de uma tabela intermediária? Uma coluna só guarda um valor por linha. Se eu tentasse ligar as duas tabelas direto, teria que colocar vários jogos na mesma célula do Pikachu (por exemplo, "Red, Yellow"), o que quebra as regras do banco. A solução é criar uma terceira tabela, pokemon_jogo, onde cada linha é uma ligação entre um Pokémon e um jogo. Assim o N:N vira dois relacionamentos 1:N:

um Pokémon tem várias linhas em pokemon_jogo;
um jogo tem várias linhas em pokemon_jogo.
id_pokemon	id_jogo
1	1
1	2
2	1
2	2
4. Chave primária, chave estrangeira e integridade referencial
Chave primária (PK): coluna que identifica cada linha da tabela de forma única. Não pode repetir nem ficar vazia. É como o CPF de uma pessoa. Exemplo: id_pokemon na tabela pokemon.
Chave estrangeira (FK): coluna que aponta para a chave primária de outra tabela. É o "link" entre as tabelas. Exemplo: id_pokemon em pokemon_jogo aponta para pokemon.id_pokemon.
Integridade referencial: regra que garante que uma chave estrangeira só pode apontar para algo que existe. Exemplos:
não consigo cadastrar em pokemon_jogo um id_pokemon que não existe na tabela pokemon;
não consigo apagar um jogo que ainda está ligado a Pokémon (a não ser que eu configure uma regra como ON DELETE CASCADE).

Isso evita dados "soltos" e inconsistentes.

5. Normalização

O problema que ela resolve: quando a tabela mistura tudo e repete informação, aparecem erros:

Redundância: o mesmo dado escrito várias vezes (o nome "Pikachu" ou a data do jogo Red repetidos).
Anomalia de atualização: se a data do Red mudar, preciso corrigir em muitas linhas.
Anomalia de inserção: não consigo cadastrar um jogo novo sem colocar um Pokémon junto.
Anomalia de exclusão: se eu apagar o único Pokémon de um jogo, perco os dados do jogo.

A normalização organiza as tabelas para evitar isso. (Os dados abaixo são só exemplos.)

Versão não normalizada
numero_pokedex	nome_pokemon	jogos	datas_lancamento
1	Bulbasaur	Red, Yellow	1996-02-27, 1998-09-12
25	Pikachu	Red, Yellow	1996-02-27, 1998-09-12

Problemas: há vários valores na mesma célula (jogos e datas_lancamento) e as datas se repetem.

1ª Forma Normal (1FN)

Cada campo guarda um único valor (valor atômico). Fica uma linha para cada par Pokémon + jogo:

numero_pokedex	nome_pokemon	jogo	data_lancamento
1	Bulbasaur	Red	1996-02-27
1	Bulbasaur	Yellow	1998-09-12
25	Pikachu	Red	1996-02-27
25	Pikachu	Yellow	1998-09-12

A chave aqui é composta: (numero_pokedex, jogo). Ainda existe muita repetição.

2ª Forma Normal (2FN)

Já está na 1FN e nenhum atributo depende de só uma parte da chave composta. Aqui, nome_pokemon depende só de numero_pokedex, e data_lancamento depende só de jogo. Então separo em tabelas:

pokemon

numero_pokedex	nome_pokemon
1	Bulbasaur
25	Pikachu

jogo

jogo	data_lancamento
Red	1996-02-27
Yellow	1998-09-12

pokemon_jogo

numero_pokedex	jogo
1	Red
1	Yellow
25	Red
25	Yellow
3ª Forma Normal (3FN)

Já está na 2FN e nenhum atributo depende de outro atributo que não seja chave (dependência transitiva). Exemplo: se eu colocasse geracao e regiao dentro da tabela jogo, a regiao dependeria da geracao e não do jogo (Geração 1 = Kanto). Eu separaria em uma tabela geracao. No meu projeto atual não tenho esse problema, então as tabelas já respeitam a 3FN.

Resultado final no meu projeto
pokemon (id_pokemon, numero_pokedex, nome)
jogo (id_jogo, nome, data_lancamento)
pokemon_jogo (id_pokemon, id_jogo) – chave primária composta; as duas colunas também são chaves estrangeiras.

(Troquei o nome do jogo e o número da Pokédex por ids numéricos como chave primária, porque é mais simples e rápido para o banco comparar números.)

6. Tipos de dados
Tabela	Coluna	Tipo	Por quê
pokemon	id_pokemon	INT	Número inteiro, gerado automaticamente (AUTO_INCREMENT), serve de chave primária.
pokemon	numero_pokedex	INT	O número na Pokédex é inteiro e preciso ordenar por ele. Usei UNIQUE, pois não repete.
pokemon	nome	VARCHAR(50)	Texto curto de tamanho variável. NOT NULL, pois todo Pokémon tem nome.
jogo	id_jogo	INT	Mesmo motivo do id_pokemon.
jogo	nome	VARCHAR(100)	Nomes de jogos são mais longos (ex.: "Pokémon Legends: Arceus"). NOT NULL.
jogo	data_lancamento	DATE	Guarda só dia/mês/ano e permite ordenar e comparar datas.
pokemon_jogo	id_pokemon	INT	Chave estrangeira, precisa ser do mesmo tipo da chave que ela referencia.
pokemon_jogo	id_jogo	INT	Chave estrangeira, mesmo motivo.


7. MER x DER (modelo conceitual x modelo lógico)
MER (Modelo Entidade-Relacionamento) – modelo conceitual: é a visão do negócio, sem detalhe técnico. Diz quais são as entidades, os atributos e os relacionamentos. No meu projeto: existem Pokémon e Jogos, e um Pokémon aparece em vários jogos (N:N). Não fala de chave nem de tipo de dado.
DER (Diagrama Entidade-Relacionamento) – modelo lógico: é o desenho do modelo já em forma de tabelas. Mostra as tabelas, as colunas, as chaves primárias e estrangeiras e as cardinalidades. Aqui o N:N já aparece resolvido com a tabela pokemon_jogo.

Resumindo: o conceitual responde "o que eu preciso guardar?" e o lógico responde "como isso vira tabelas ligadas por chaves?".

Referências

SANTOS, Ozias Gonçalves dos. Banco de dados. São Paulo: Senac, 2026. Notas de aula.

Uso de IA:

ANTHROPIC. Claude (modelo utilizado: Claude Sonnet 5.5 extra). Ferramenta de inteligência artificial generativa. Data de uso: 5 nov. 2026. Finalidade: redação da fundamentação teórica (fiz a criação de um texto explicando a teorica do site e montei a estrutura o claude montou as tabelas a serem colocadas e reajustou os texto me esculachando falando que eu meu tinha muitos erro ortograficos e semanticos de texto então pedi para ele reescrever as partes erradas ou ruins do jeito dele) com exemplos do tema Pokémon. Arquivos impactados: docs/ado-2.md
