```markdown
# Sistema de Gerenciamento de Oficina Mecânica

Este projeto consiste em um banco de dados MySQL para gerenciamento de uma oficina mecânica, com tabelas relacionais para clientes, veículos, serviços, peças, equipes e ordens de serviço.

## Estrutura do Banco de Dados

O banco de dados contém as seguintes tabelas principais:

- **Serviço**: Cadastro de serviços oferecidos pela oficina
- **Pessoa**: Dados pessoais (clientes e mecânicos)
- **Cliente**: Informações específicas de clientes
- **Veículo**: Veículos atendidos pela oficina
- **Equipe**: Grupos de trabalho dos mecânicos
- **Ordem de Serviço**: Registros de serviços realizados
- **Peças**: Peças em estoque na oficina
- **Mecânico**: Dados profissionais dos mecânicos
- **Serviços na OS**: Relacionamento entre serviços e ordens de serviço
- **Peças na OS**: Relacionamento entre peças e ordens de serviço

## Queries SQL Disponíveis

O sistema inclui exemplos de queries para:

1. **Consultas básicas**:
   - Listagem de clientes, veículos e serviços
   - Filtros por marca, valor e tipo de serviço

2. **Cálculos e atributos derivados**:
   - Valor total de peças em estoque
   - Tempo de cadastro dos clientes
   - Média de valores de mão de obra

3. **Ordenação de dados**:
   - Serviços por valor
   - Veículos por ano
   - Ordens de serviço por data

4. **Filtros em grupos**:
   - Marcas com múltiplos veículos
   - Serviços com valores acima da média
   - Peças com alto valor em estoque

5. **Consultas complexas com JOIN**:
   - Ordens de serviço com detalhes de cliente e veículo
   - Relatórios financeiros completos
   - Mecânicos e suas equipes

## Como Usar

1. Execute o script SQL para criar o banco de dados e tabelas
2. Insira os dados de exemplo fornecidos
3. Utilize as queries conforme necessidade ou adapte para seus requisitos específicos

## Exemplos de Uso

```sql
-- Consultar ordens de serviço em andamento
SELECT * FROM `Ordem de Serviço` WHERE Status = 'Em andamento';

-- Relatório de peças com baixo estoque
SELECT * FROM Peças WHERE `Quantidade estoque` < 10 ORDER BY `Quantidade estoque` ASC;
