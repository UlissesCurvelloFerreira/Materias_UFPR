
---
<blockquote style="border-left: 3px solid #c49600; padding-left: 15px; background: transparent;">
    <h2 style="margin: 0;"> Fluxo Básico do Git: </h2>
    <blockquote style="border-left: 3px solid #c49600; padding-left: 15px; background: transparent;">
    <strong>Adicionar um Arquivo ao Git:</strong>
    Nesta seção, apresento os comandos essenciais do Git, que serão explorados ao longo do texto de maneira mais aprofundada, revelando suas funcionalidades e aplicações em contextos específicos. <br> 

- `git add nomeDoArquivo` ou `git add .`: Adiciona as mudanças no arquivo ao "Index" do Git, preparando-as para serem commitadas. O ponto (.) significa adicionar todas as alterações.

- `git commit -m "msg de commit"`: Registra as mudanças no repositório Git com uma mensagem descritiva. A mensagem `-m` fornece um resumo conciso do que foi feito.

- `git push origin main`: Envia as alterações para o repositório remoto (como o GitHub). "origin" refere-se ao repositório online e "main" é a branch de destino. Use "master" se a branch principal for chamada assim.

- `git push`: Usado quando na branch principal. Envia as alterações para o GitHub sem especificar a branch, pois geralmente a branch principal é usada.

- `git pull`: Combina os comandos `git fetch` (para obter alterações do GitHub) e `git merge` (para incorporar as alterações em sua branch). Atualiza a branch local.

- `git pull origin main`: Puxa as atualizações da branch "main" no repositório remoto ("origin") para a branch local. Use "master" se aplicável.

- `git status`: Mostra se o arquivo foi ou não commitado, se foi ou não alterado e se foi ou não registrado no Git.

</blockquote>
<blockquote style="border-left: 5px solid green; padding-left: 15px; background-color: rgba(0, 128, 0, 0.1);">
    <strong style="color: green;">Nota:</strong>

O **git status** é crucial no controle de versão, proporcionando rápida visualização de alterações para evitar erros. Facilita a compreensão do estado atual do projeto e a identificação de problemas. Sua aplicação regular é essencial para acompanhar o progresso ao longo do tempo.
</blockquote>
</blockquote>
<br><br>

---
<blockquote style="border-left: 3px solid #c49600; padding-left: 15px; background: transparent;">
    <h2 style="margin: 0;">INSTALAÇÃO E CONFIGURAÇÕES:</h2>
    <blockquote style="border-left: 3px solid #c49600; padding-left: 15px; background: transparent;">
    <strong>AInstalação do Git:</strong>

Para instalar o Git em sua máquina Linux via terminal, utilize o seguinte comando:

- `sudo apt-get install git`: Instalação do Git.
    </blockquote>
    <br>
    <blockquote style="border-left: 3px solid #c49600; padding-left: 15px; background: transparent;">
<strong>Configuração de Variáveis:</strong>

Alguns parâmetros podem ser configurados para otimizar o uso do Git, como:

- `user.name`: Nome do usuário associado aos commits.
- `user.email`: Endereço de e-mail associado aos commits.
- `core.editor`: Editor de texto padrão para mensagens de commit.
    </blockquote>
    <br>
    <blockquote style="border-left: 3px solid #c49600; padding-left: 15px; background: transparent;">
<strong>Configuração das variáveis no diretório:</strong>

- `git config -l` ou `git config --list`: Exibe variáveis configuradas.

- `git config -l --global`: Exibe variáveis da configuração global.

- `git config -l --local`: Exibe variáveis do diretório atual.

- `git config user.name NOME`: Configuração do nome do usuário.

- `git config user.email novo_email`: Configuração do e-mail.

- `git config core.editor novoEditor`: Configuração do editor de texto.
    </blockquote>
    <br>
    <blockquote style="border-left: 3px solid #c49600; padding-left: 15px; background: transparent;">
<strong>Aumentando a Produtividade com Aliases:</strong>

Para otimizar o uso do Git, podemos criar aliases para comandos frequentes:
- `git config --local alias.COMANDO 'O_QUE_QUERO_QUE_EXECUTE'`: Cria um alias para um comando Git.
    - Exemplo: `git COMANDO`. Executará o comando O_QUE_QUERO_QUE_EXECUTE;

- `git config --local alias.COMANDO '!O_QUE_QUERO_QUE_EXECUTE'`: Cria um alias para um comando externo.
    - Usar '!' indica que é um comando externo, como um comando do shell.

- `git config --unset ALIAS_NOME_DA_VARIAVEL`: Apaga um alias.
    </blockquote>
</blockquote>
<br><br>


---
<blockquote style="border-left: 3px solid #c49600; padding-left: 15px; background: transparent;">
<h2 style="margin: 0;">VISUALIZAÇÃO DO HISTÓRICO DE COMMITS:</h2>
    <blockquote style="border-left: 3px solid #c49600; padding-left: 15px; background: transparent;">
<strong>Exibição do Histórico:</strong>

- `git log`: Exibe o histórico de todas as modificações de um arquivo.

- `git log -p`: Mostra o histórico do que mudou em cada alteração de commit.

- `git log -p -2`: Mostra os dois últimos registros.

- `git log --stat`: Exibe quais arquivos foram alterados e como foram modificados. Exemplo: (1 file change, 1 insertion, 1 deletion)

- `git log -- arquivoEspecifico.txt`: Monitora um arquivo específico, exibindo somente o histórico desse arquivo.

- `git log --graph`: Exibe um pequeno gráfico das branches.

- `git log --oneline`: Exibição resumida dos commits em uma linha.

- `git log --author=NOME_DO_AUTOR`: Separa os commits por autor.

- `git log --grep="palavra"`: Filtra os commits que têm a mensagem/palavra especificada.
    </blockquote>
    <br>

    <blockquote style="border-left: 3px solid #c49600; padding-left: 15px; background: transparent;">
<strong>Edição do Histórico de Commits:</strong>

- `git commit --amend`: Edita a mensagem do último commit do histórico.

- `git commit --amend --no-edit`: Altera o conteúdo sem modificar a mensagem do commit.

- `git rebase -i HEAD~4`: Edita os últimos 4 commits de forma interativa.

- `git add -u`: Adiciona todos os arquivos já rastreados pelo Git.
    </blockquote>

    <br>
    <blockquote style="border-left: 3px solid #c49600; padding-left: 15px; background: transparent;">
<strong>Uso de Tags para Organização:</strong>

- `git tag -a nomeDaTag -m "msg da tag"`: Marca um commit específico com uma tag.

- `git tag`: Exibe todas as tags criadas.

- `git checkout nomeDaTag`: Volta para uma versão marcada por uma tag.

- `git show --tags`: Exibe o conteúdo de cada commit referenciado por uma tag.

- `git tag -n`: Exibe uma lista de tags e o título de commit passado na criação da tag.

- `git tag -n10`: Exibe o contexto/explicação de cada commit tag.

- `git tag -d nomeDaTag`: Apaga uma tag.

- `git push --tags`: Envia todas as tags para o repositório no GitHub.
    </blockquote>

    <br>
    <blockquote style="border-left: 3px solid #c49600; padding-left: 15px; background: transparent;">
<strong>Adicionando Coautores no Commit:</strong>

- `Co-authored-by: nome email`: Adicionar coautor para um commit é usado passando-a como mensagem de commit. Exemplo: `git commit -m "Comentário da atualização feita Co-authored-by: nome email"`. Esta palavra é interpretada pelo Git, ou seja, é uma palavra especial. Após isso, será informado no commit quem é o coautor. Conseguimos ver isso através de `git log -1`. Bom saber para usar em grupos no GitHub, onde também é mostrado o autor e coautor.
    </blockquote>
</blockquote>
<br><br>

---
<blockquote style="border-left: 3px solid #c49600; padding-left: 15px; background: transparent;">
<h2 style="margin: 0;">VOLTA EM COMMITS FEITOS - MUITO IMPORTANTE:</h2>

<blockquote style="border-left: 5px solid yellow; padding-left: 15px; background-color: rgba(255, 255, 0, 0.1);">
    <strong style="color: yellow;">Nota:</strong>

A flexibilidade de voltar ou avançar em commits no Git é essencial para corrigir erros, explorar soluções alternativas, e implementar funcionalidades progressivamente. Isso simplifica o gerenciamento de código, promovendo agilidade e adaptação às necessidades do projeto.
</blockquote>

- **`git checkout xxxxxxxxxxx`**: Muda/Volta/Retrocede para o commit anterior. O "xxx..." representa o número hash do commit, que pode ser copiado/exibido com `git log`.

- **`git diff`**: Mostra as alterações no arquivo, indicando quais linhas foram modificadas ou apagadas. Isso é feito antes de realizar o commit.

- **`git checkout master`**: Move para o topo do branch master. 
NOTA AAAAAAAAAAAAAAAAA

</blockquote>
<br><br>
 
---
<blockquote style="border-left: 3px solid #c49600; padding-left: 15px; background: transparent;">
<h2 style="margin: 0;">CRIAÇÃO DE NOVOS RAMOS</h2>
A manipulação de branches no Git é crucial para o desenvolvimento de software eficiente. Permite o trabalho paralelo, isola funcionalidades, facilita testes e experimentos, simplifica a reversão de alterações e promove uma colaboração organizada. O uso adequado de branches no Git é essencial para manter um histórico de desenvolvimento limpo e facilitar a implementação de novas funcionalidades sem comprometer o código principal. Abaixo listo algumas funcionalidades.

<br>

- **`git checkout -b NOME_DA_BRANCH`**: Cria um novo ramo/branch, mudando para a nova branch criada agora.

- **`git checkout master`**: Volta para a branch master.

- **`git branch`**: Exibe uma lista de todas as ramificações em determinada pasta.

- **`git branch -v`**: Exibe o último commit de cada ramo.

- **`git branch -vv`**: Mostra que a branch origin/master está monitorando a branch master local.

- **`git remote`**: Mostra o nome "origin", que é uma referência ao repositório remoto.

- **`git remote -v`**: Mostra um origin (link de e-mails), um alias para o repositório remoto.

- **`git fetch`**: Baixa as alterações para o versionador, sem incorporá-las na branch.

  - **`git fetch origin main`**: Baixa as alterações, mas não incorpora na branch principal.

    - **`git merge origin/main`**: Incorpora as alterações da branch remota na branch local.

- **Comentário**: O comando git pull faz os dois de uma vez só (fetch e marge). Pode ser desmembrado em comandos git que fazem partes do processo. Logo, usar git fetch origin main; git merge origin/master é equivalente a git pull.

- **`git merge NOME_DA_BRANCH`**: Usa este comando para incorporar um ramo à master, abrindo o editor para comentar a alteração. O comando "git log --graph" é útil para visualizar as alterações.


<blockquote style="border-left: 5px solid red; padding-left: 15px; background-color: rgba(255, 0, 0, 0.1);">
    <strong style="color: red;">Atenção:</strong>


<font color="blue">Este texto está em azul</font>

    
Utilizar o "git merge" pode gerar complicações com conflitos, especialmente em colaborações, e o "git fetch" traz alterações do servidor sem mesclá-las automaticamente, potencialmente bagunçando o histórico. Se não estivermos atentos a esses riscos, o código pode se tornar desorganizado, tornando a resolução de conflitos uma tarefa complicada.
</blockquote>

</blockquote>
