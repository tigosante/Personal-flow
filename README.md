# Personal Flow: Aplicativo de tarefas inteligente
    Autor: Tiago dos Santos Silva
    e-mail: tsilvasantos38@gmail.com


# IESB - Projeto Integrador I
    O objetivo da disciplina é incentivar os alunos a usarem os conhecimentos adquiridos ao decorrer do curso para desenvolverem aplicações.

# Objetivo Geral
    O presente trabalho tem por objetivo, com a implementação do aplicativo chamado Personal Flow, extinguir barreiras do dia a dia, tornando a leitura de uma notificação mais precisa, informativa e geradora de ações positivas para quem a recebe. Além disso, o aplicativo oferecerá um diferencial, que será a criação parcialmente automática de tarefas recorrentes da rotina do usuário. O objetivo dessa criação é oferecer da melhor forma possível a praticidade nas mãos do cliente.

# Utilização das ferramentas na criação do aplicativo Personal Flow:
    A aplicação do Personal Flow foi feita utilizando um framework chamado Flutter, que utiliza a linguagem de programação Dart. No Flutter é possível utilizar o mesmo código para desenvolver um aplicativo para Android e para IOS.

    O aplicativo Personal Flow foi criado utilizando o algoritmo de estrutura de dados chamado de árvore de decisão. Foi escolhido esse algoritmo com o intuito de obter respostas precisas e objetivas quanto à sugestão de tarefas recorrentes, em que o usuário já havia criado 3 ou mais vezes, oferecendo a criação parcialmente automática da mesma.

    A árvore de decisão oferece facilidade de montagem, visto que, é feita uma pergunta relacionada ao problema dado, e no caso desse projeto, sempre há duas opções de respostas para a pergunta feita, eliminando sempre 50%  de possibilidades de decisão final.
    Utilizando a estrutura lógica do algoritmo de árvore de decisão, será feita a sugestão de tarefas do aplicativo:

    Na criação de uma tarefa, o usuário poderá deixá-la sem data ou programá-la para uma data/hora específica. Portanto, a árvore de decisão começa sendo dividida em duas alternativas: se a tarefa contém uma data programada ou não. Caso a mesma já tenha sido programada pelo usuário, então ela não é sugerida posteriormente, visto que já tem uma repetição solicitada. Caso contrário, conforme forem sendo criadas as tarefas, elas serão guardadas em arquivo para serem comparadas posteriormente com as condições citadas a seguir:

    Após verificar a condição de serem programadas ou não, as tarefas começam sendo dividas em dois tipos: simples e composta. A tarefa simples contém apenas a mesma criada com um título. Já a composta é constituída de uma tarefa principal contendo subtarefas dentro da mesma. Nesse caso, a principal somente se dá como concluída após todas as subtarefas estarem concluídas também.

    Dentre outras condições na árvore de decisão, tem-se: comparação de igualdade de títulos entre as tarefas, verificação do percentual de conclusão ou não das mesmas e igualdade de datas, como serão explicados abaixo:
    Para realizar a comparação de igualdade de títulos das tarefas, simples e compostas, todas as letras da string informada são alteradas de minúsculas para maiúsculas. 	Após isso, são removidos todos os caracteres especiais, como pontos, vírgulas, espaços, entre outros. O título tratado é guardado dentro da tarefa ou subtarefa informada.

        A verificação do percentual de conclusão de uma tarefa composta é feita da seguinte maneira: utiliza-se a soma de todas as subtarefas, multiplicando este resultado por 0,7. Feito isso, o aplicativo verifica se o resultado é maior ou igual à soma de todas as subtarefas concluídas do grupo.

        A aplicação também verifica se as datas das tarefas simples ou subtarefas de um grupo são iguais. Caso sejam, o mesmo guardará esta data que se repete para sugeri-la ao usuário. A comparação não leva em consideração a hora,  e a sugestão de tal tarefa pode ocorrer sem data, caso não haja datas iguais entre as tarefas comparadas.

