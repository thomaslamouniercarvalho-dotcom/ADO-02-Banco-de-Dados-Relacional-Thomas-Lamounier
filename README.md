# ADO-02-Banco-de-Dados-Relacional-Thomas-Lamounier

## Modelagem conceitual, lógica e fisica
### modelo conceitual

### modelo físico
#### Podemos observar a implementação de conceitos relacionados a tipo de dados, quantidade de caracteres, identificação das chaves primárias e estrangeiras além das restrições de integridade, tudo definido de acordo com o SGBD ecolhido.

### modelo lógico
#### no modelo lógico a preocupação é passar todo o conceito do  modelo conceitual para a versões em tabelas e seus relacionamentos definindo atributos, chaves primárias e estrangeiras.

### modelo conceitual
#### no modelo conceitual a preocupação é identificar as entidades, atributos e relacionamentos do negócio, de forma simples e sem detalhes técnicos

## MER e DER
#### o MER (Modelo Entidade-Relacionamento) é o modelo que define os conceitos de entidades, atributos e relacionamentos, e o DER (Diagrama Entidade-Relacionamento) é o diagrama que representa esses conceitos graficamente

#### * Entidade = a tabela
#### * Atributo = a coluna
#### * PK (Primary Key) = o “CPF” do registro precisa ser único
#### * FK (Forgeign Key)= o “link” que aponta para a PK de outra tabela

## relacionamentos e cardinalidade
#### os relacionamentos ligam as entidades entre si, e a cardinalidade define quantos registros de uma entidade podem se relacionar com a outra: 1:1 (um para um), 1:N (um para muitos) e N:N (muitos para muitos). Como o N:N não pode ser representado diretamente em tabelas, ele é transformado em uma tabela associativa, que recebe as chaves primárias das duas entidades como chaves estrangeiras (ex: linha_estacao, ligando linha e estacao)

### normalização
#### a normalização organiza as tabelas para eliminar redundância e evitar anomalias de inserção, atualização e exclusão. A 1FN exige valores atômicos em cada campo, a 2FN exige que nenhum atributo dependa de apenas parte da chave composta e a 3FN exige que nenhum atributo dependa de outro atributo que não seja chave

## Modelagem Física
#### * INT - números inteiros
#### * VARCHAR(X) -  texto de até x caraccteres
#### * DATE -  data
#### * PRIMARY KEY - chave primária
#### * FORGEIGN KEY - chave estrangeira
#### * NOT NULL - campo obrigatório
#### * UNIQUE - não permite registros repetidos
#### * AUTO_INCREMENT - aumenta automaticamente (1, 2, 3)
#### * ENUM - limita as opções

#### SANTOS, Ozias Gonçalves dos. Banco de dados. São Paulo: Senac, 2026. Notas de aula.

#### Integrante: Maria Eduarda Soares
#### ANTHROPIC. Claude (modelo utilizado: Claude Sonnet 5.5). Ferramenta de inteligência artificial generativa.
#### Data de uso: 23 out. 2026.
#### Finalidade: verificação e revisão de textos feitos em estudos sobre modelo conceitual, lógico e físico, MER/DER.
#### Arquivos impactados: README.md (seção Modelagem)
