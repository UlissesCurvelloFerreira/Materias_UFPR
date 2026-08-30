# multiAgents.py
# --------------
# Licensing Information:  You are free to use or extend these projects for
# educational purposes provided that (1) you do not distribute or publish
# solutions, (2) you retain this notice, and (3) you provide clear
# attribution to UC Berkeley, including a link to http://ai.berkeley.edu.
# 
# Attribution Information: The Pacman AI projects were developed at UC Berkeley.
# The core projects and autograders were primarily created by John DeNero
# (denero@cs.berkeley.edu) and Dan Klein (klein@cs.berkeley.edu).
# Student side autograding was added by Brad Miller, Nick Hay, and
# Pieter Abbeel (pabbeel@cs.berkeley.edu).


from util import manhattanDistance
from game import Directions
import random, util

from game import Agent
from pacman import GameState

class ReflexAgent(Agent):
    """
    A reflex agent chooses an action at each choice point by examining
    its alternatives via a state evaluation function.

    The code below is provided as a guide.  You are welcome to change
    it in any way you see fit, so long as you don't touch our method
    headers.
    """


    def getAction(self, gameState: GameState):
        """
        You do not need to change this method, but you're welcome to.

        getAction chooses among the best options according to the evaluation function.

        Just like in the previous project, getAction takes a GameState and returns
        some Directions.X for some X in the set {NORTH, SOUTH, WEST, EAST, STOP}
        """
        # Collect legal moves and successor states
        legalMoves = gameState.getLegalActions()

        # Choose one of the best actions
        scores = [self.evaluationFunction(gameState, action) for action in legalMoves]
        bestScore = max(scores)
        bestIndices = [index for index in range(len(scores)) if scores[index] == bestScore]
        chosenIndex = random.choice(bestIndices) # Pick randomly among the best

        "Add more of your code here if you want to"

        return legalMoves[chosenIndex]

    def evaluationFunction(self, currentGameState: GameState, action):
        """
        Design a better evaluation function here.

        The evaluation function takes in the current and proposed successor
        GameStates (pacman.py) and returns a number, where higher numbers are better.

        The code below extracts some useful information from the state, like the
        remaining food (newFood) and Pacman position after moving (newPos).
        newScaredTimes holds the number of moves that each ghost will remain
        scared because of Pacman having eaten a power pellet.

        Print out these variables to see what you're getting, then combine them
        to create a masterful evaluation function.
        """
        # Useful information you can extract from a GameState (pacman.py)
        successorGameState = currentGameState.generatePacmanSuccessor(action)
        newPos = successorGameState.getPacmanPosition()
        newFood = successorGameState.getFood()
        newGhostStates = successorGameState.getGhostStates()
        newScaredTimes = [ghostState.scaredTimer for ghostState in newGhostStates]

        "*** YOUR CODE HERE ***"

        # distância até a comida mais próxima
        foodList = newFood.asList()
        if foodList:
            minFoodDist = min([manhattanDistance(newPos, food) for food in foodList])
        else:
            minFoodDist = 1
        foodScore = 1.0 / minFoodDist

        # distância até o fantasma mais próximo
        minGhostDist = min([manhattanDistance(newPos, ghost.getPosition()) for ghost in newGhostStates])
        if minGhostDist <= 1 and max(newScaredTimes) == 0:
            ghostScore = -9999
        else:
            ghostScore = 1.0 / (minGhostDist + 1)

        return successorGameState.getScore() + 10 * foodScore + ghostScore
    

def scoreEvaluationFunction(currentGameState: GameState):
    """
    This default evaluation function just returns the score of the state.
    The score is the same one displayed in the Pacman GUI.

    This evaluation function is meant for use with adversarial search agents
    (not reflex agents).
    """
    return currentGameState.getScore()


class MultiAgentSearchAgent(Agent):
    """
    This class provides some common elements to all of your
    multi-agent searchers.  Any methods defined here will be available
    to the MinimaxPacmanAgent, AlphaBetaPacmanAgent & ExpectimaxPacmanAgent.

    You *do not* need to make any changes here, but you can if you want to
    add functionality to all your adversarial search agents.  Please do not
    remove anything, however.

    Note: this is an abstract class: one that should not be instantiated.  It's
    only partially specified, and designed to be extended.  Agent (game.py)
    is another abstract class.
    """

    def __init__(self, evalFn = 'scoreEvaluationFunction', depth = '2'):
        self.index = 0 # Pacman is always agent index 0
        self.evaluationFunction = util.lookup(evalFn, globals())
        self.depth = int(depth)


class MinimaxAgent(MultiAgentSearchAgent):
    """
    Your minimax agent (question 2)
    """

    def getAction(self, gameState: GameState):
        """
        Returns the minimax action from the current gameState using self.depth
        and self.evaluationFunction.

        Here are some method calls that might be useful when implementing minimax.

        gameState.getLegalActions(agentIndex):
        Returns a list of legal actions for an agent
        agentIndex=0 means Pacman, ghosts are >= 1

        gameState.generateSuccessor(agentIndex, action):
        Returns the successor game state after an agent takes an action

        gameState.getNumAgents():
        Returns the total number of agents in the game

        gameState.isWin():
        Returns whether or not the game state is a winning state

        gameState.isLose():
        Returns whether or not the game state is a losing state
        """
        "*** YOUR CODE HERE ***"
        
        def minimax(estado, agenteIndex, profundidade):
            # caso terminal
            if profundidade == self.depth or estado.isWin() or estado.isLose():
                return self.evaluationFunction(estado)

            numAgentes = estado.getNumAgents()

            # turno do Pacman (MAX)
            if agenteIndex == 0:
                valor = float("-inf")
                for acao in estado.getLegalActions(0):
                    sucessor = estado.generateSuccessor(0, acao)
                    valor = max(valor, minimax(sucessor, 1, profundidade))
                return valor

            # turno dos fantasmas (MIN)
            else:
                valor = float("inf")
                proximoAgente = (agenteIndex + 1) % numAgentes
                novaProfundidade = profundidade + 1 if proximoAgente == 0 else profundidade
                for acao in estado.getLegalActions(agenteIndex):
                    sucessor = estado.generateSuccessor(agenteIndex, acao)
                    valor = min(valor, minimax(sucessor, proximoAgente, novaProfundidade))
                return valor

        # Escolher ação que maximiza o resultado para o Pacman
        melhorValor = float("-inf")
        melhorAcao = None
        for acao in gameState.getLegalActions(0):
            sucessor = gameState.generateSuccessor(0, acao)
            valor = minimax(sucessor, 1, 0)
            if valor > melhorValor:
                melhorValor = valor
                melhorAcao = acao

        return melhorAcao


class AlphaBetaAgent(MultiAgentSearchAgent):
    """
    Your minimax agent with alpha-beta pruning (question 3)
    """

    def getAction(self, gameState: GameState):
        """
        Returns the minimax action using self.depth and self.evaluationFunction
        """
        "*** YOUR CODE HERE ***"

        def alphabeta(estado, agenteIndex, profundidade, alpha, beta):
            # Caso terminal
            if estado.isWin() or estado.isLose() or profundidade == self.depth:
                return self.evaluationFunction(estado)

            numAgentes = estado.getNumAgents()
            proximoAgente = (agenteIndex + 1) % numAgentes
            novaProfundidade = profundidade + 1 if proximoAgente == 0 else profundidade

            # MAX: Pacman
            if agenteIndex == 0:
                valor = float("-inf")
                for acao in estado.getLegalActions(agenteIndex):
                    sucessor = estado.generateSuccessor(agenteIndex, acao)
                    valor = max(valor, alphabeta(sucessor, proximoAgente, novaProfundidade, alpha, beta))
                    alpha = max(alpha, valor)
                    if alpha > beta:  # poda somente se estritamente maior
                        break
                return valor

            # MIN: Fantasmas
            else:
                valor = float("inf")
                for acao in estado.getLegalActions(agenteIndex):
                    sucessor = estado.generateSuccessor(agenteIndex, acao)
                    valor = min(valor, alphabeta(sucessor, proximoAgente, novaProfundidade, alpha, beta))
                    beta = min(beta, valor)
                    if alpha > beta:  # poda somente se estritamente maior
                        break
                return valor

        # Escolher ação do Pacman
        melhorValor = float("-inf")
        melhorAcao = None
        alpha, beta = float("-inf"), float("inf")

        for acao in gameState.getLegalActions(0):
            sucessor = gameState.generateSuccessor(0, acao)
            valor = alphabeta(sucessor, 1, 0, alpha, beta)
            if valor > melhorValor:
                melhorValor = valor
                melhorAcao = acao
            alpha = max(alpha, melhorValor)

        return melhorAcao


class ExpectimaxAgent(MultiAgentSearchAgent):
    """
      Your expectimax agent (question 4)
    """

    def getAction(self, gameState: GameState):
        """
        Returns the expectimax action using self.depth and self.evaluationFunction

        All ghosts should be modeled as choosing uniformly at random from their
        legal moves.
        """
        "*** YOUR CODE HERE ***"
        def expectimax(estado, agenteIndex, profundidade):
            # Caso terminal
            if estado.isWin() or estado.isLose() or profundidade == self.depth:
                return self.evaluationFunction(estado)

            numAgentes = estado.getNumAgents()
            proximoAgente = (agenteIndex + 1) % numAgentes
            novaProfundidade = profundidade + 1 if proximoAgente == 0 else profundidade

            acoesLegais = estado.getLegalActions(agenteIndex)

            # MAX: Pacman
            if agenteIndex == 0:
                valor = float("-inf")
                for acao in acoesLegais:
                    sucessor = estado.generateSuccessor(agenteIndex, acao)
                    valor = max(valor, expectimax(sucessor, proximoAgente, novaProfundidade))
                return valor

            # Expectativa: Fantasmas agem aleatoriamente
            else:
                soma = 0
                for acao in acoesLegais:
                    sucessor = estado.generateSuccessor(agenteIndex, acao)
                    soma += expectimax(sucessor, proximoAgente, novaProfundidade)
                return soma / len(acoesLegais) if acoesLegais else 0

        # Escolher ação do Pacman com maior valor expectimax
        melhorValor = float("-inf")
        melhorAcao = None
        for acao in gameState.getLegalActions(0):
            sucessor = gameState.generateSuccessor(0, acao)
            valor = expectimax(sucessor, 1, 0)
            if valor > melhorValor:
                melhorValor = valor
                melhorAcao = acao

        return melhorAcao


def betterEvaluationFunction(currentGameState: GameState):
    """
    Your extreme ghost-hunting, pellet-nabbing, food-gobbling, unstoppable
    evaluation function (question 5).

    DESCRIPTION: <write something here so we know what you did>
    """
    "*** YOUR CODE HERE ***"
    pacmanPos = currentGameState.getPacmanPosition()
    foodGrid = currentGameState.getFood()
    ghostStates = currentGameState.getGhostStates()
    capsules = currentGameState.getCapsules()

    # Pontuação base do jogo
    score = currentGameState.getScore()

    # Distância até a comida mais próxima
    foodList = foodGrid.asList()
    if foodList:
        minFoodDist = min([manhattanDistance(pacmanPos, food) for food in foodList])
        foodScore = 1.0 / minFoodDist
    else:
        foodScore = 0

    # Distância e efeito dos fantasmas
    ghostScore = 0
    for ghost in ghostStates:
        ghostDist = manhattanDistance(pacmanPos, ghost.getPosition())
        if ghost.scaredTimer > 0:
            # Fantasma assustado: incentivo a persegui-lo
            ghostScore += 2.0 / (ghostDist + 1)
        else:
            # Fantasma ativo: penalidade se muito próximo
            if ghostDist <= 1:
                return -float("inf")  # morte iminente
            ghostScore -= 1.0 / ghostDist

    # Incentivo a pegar cápsulas
    capsuleScore = sum([1.0 / (manhattanDistance(pacmanPos, cap) + 1) for cap in capsules])

    # Penalidade pela quantidade de comida restante (quanto menos, melhor)
    foodRemainingScore = -len(foodList)

    # Combina todos os fatores
    return score + 10 * foodScore + 5 * ghostScore + 3 * capsuleScore + foodRemainingScore
    



# Abbreviation
better = betterEvaluationFunction
