# valueIterationAgents.py
# -----------------------
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


# valueIterationAgents.py
# -----------------------
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


import mdp, util

from learningAgents import ValueEstimationAgent
import collections



class ValueIterationAgent(ValueEstimationAgent):
    """
        * Please read learningAgents.py before reading this.*

        A ValueIterationAgent takes a Markov decision process
        (see mdp.py) on initialization and runs value iteration
        for a given number of iterations using the supplied
        discount factor.
    """
    def __init__(self, mdp, discount = 0.9, iterations = 100):
        """
          Your value iteration agent should take an mdp on
          construction, run the indicated number of iterations
          and then act according to the resulting policy.

          Some useful mdp methods you will use:
              mdp.getStates()
              mdp.getPossibleActions(state)
              mdp.getTransitionStatesAndProbs(state, action)
              mdp.getReward(state, action, nextState)
              mdp.isTerminal(state)
        """
        self.mdp = mdp
        self.discount = discount
        self.iterations = iterations
        self.values = util.Counter() # A Counter is a dict with default 0
        self.runValueIteration()

    def runValueIteration(self):
        # Write value iteration code here
        "*** YOUR CODE HERE ***"
        for i in range(self.iterations):
            novoValores = util.Counter()
            for estado in self.mdp.getStates():
                if self.mdp.isTerminal(estado):
                    novoValores[estado] = 0
                    continue
                qValores = [self.computeQValueFromValues(estado, a) for a in self.mdp.getPossibleActions(estado)]
                novoValores[estado] = max(qValores) if qValores else 0
            self.values = novoValores


    def getValue(self, state):
        """
          Return the value of the state (computed in __init__).
        """
        return self.values[state]


    def computeQValueFromValues(self, state, action):
        """
          Compute the Q-value of action in state from the
          value function stored in self.values.
        """
        "*** YOUR CODE HERE ***"
        q = 0
        for proximoEstado, prob in self.mdp.getTransitionStatesAndProbs(state, action):
            recompensa = self.mdp.getReward(state, action, proximoEstado)
            q += prob * (recompensa + self.discount * self.values[proximoEstado])
        return q
        

    def computeActionFromValues(self, state):
        """
          The policy is the best action in the given state
          according to the values currently stored in self.values.

          You may break ties any way you see fit.  Note that if
          there are no legal actions, which is the case at the
          terminal state, you should return None.
        """
        "*** YOUR CODE HERE ***"
        acoes = self.mdp.getPossibleActions(state)
        if not acoes:
            return None
        melhoresAcoes = []
        melhorValor = float("-inf")
        for acao in acoes:
            q = self.computeQValueFromValues(state, acao)
            if q > melhorValor:
                melhorValor = q
                melhoresAcoes = [acao]
            elif q == melhorValor:
                melhoresAcoes.append(acao)
        # desempate determinístico: pega a primeira ação da lista
        return melhoresAcoes[0]

    def getPolicy(self, state):
        return self.computeActionFromValues(state)

    def getAction(self, state):
        "Returns the policy at the state (no exploration)."
        return self.computeActionFromValues(state)

    def getQValue(self, state, action):
        return self.computeQValueFromValues(state, action)




class PrioritizedSweepingValueIterationAgent(ValueIterationAgent):
    """
        * Please read learningAgents.py before reading this.*

        A PrioritizedSweepingValueIterationAgent takes a Markov decision process
        (see mdp.py) on initialization and runs prioritized sweeping value iteration
        for a given number of iterations using the supplied parameters.
    """
    def __init__(self, mdp, discount = 0.9, iterations = 100, theta = 1e-5):
        """
          Your prioritized sweeping value iteration agent should take an mdp on
          construction, run the indicated number of iterations,
          and then act according to the resulting policy.
        """
        self.theta = theta
        ValueIterationAgent.__init__(self, mdp, discount, iterations)

    def runValueIteration(self):
        "*** YOUR CODE HERE ***"
        
        # 1. Calcular predecessores de todos os estados
        predecessors = dict()
        for state in self.mdp.getStates():
            predecessors[state] = set()
        for state in self.mdp.getStates():
            for action in self.mdp.getPossibleActions(state):
                for nextState, prob in self.mdp.getTransitionStatesAndProbs(state, action):
                    if prob > 0:
                        predecessors[nextState].add(state)

        # 2. Inicializa a fila de prioridades
        priorityQueue = util.PriorityQueue()

        # 3. Para cada estado não terminal
        for state in self.mdp.getStates():
            if not self.mdp.isTerminal(state):
                # Calcula a diferença entre valor atual e valor Q máximo
                maxQ = max([self.computeQValueFromValues(state, action) 
                            for action in self.mdp.getPossibleActions(state)])
                diff = abs(self.values[state] - maxQ)
                # Insere na fila com prioridade -diff
                priorityQueue.update(state, -diff)

        # 4. Itera sobre self.iterations
        for i in range(self.iterations):
            if priorityQueue.isEmpty():
                break
            state = priorityQueue.pop()
            if not self.mdp.isTerminal(state):
                # Atualiza valor de s
                maxQ = max([self.computeQValueFromValues(state, action) 
                            for action in self.mdp.getPossibleActions(state)])
                self.values[state] = maxQ

            # Atualiza predecessores
            for p in predecessors[state]:
                if not self.mdp.isTerminal(p):
                    maxQ_p = max([self.computeQValueFromValues(p, action) 
                                  for action in self.mdp.getPossibleActions(p)])
                    diff = abs(self.values[p] - maxQ_p)
                    if diff > self.theta:
                        priorityQueue.update(p, -diff)

