
class Cell:
    def __init__(self, x, y, map):
        self.x = x
        self.y = y
        self.map = map

    def __eq__(self, other):
        return self.x == other.x and self.y == other.y and \
               self.map == other.map

    def __repr__(self):
        return str((self.x, self.y))

    def __str__(self):
        return str((self.x, self.y))

    def __hash__(self):
        return hash((self.x, self.y))

    def distance(self):
        # Ejercicio 2: Agregar noción de información
        # self.map.goal_x = posición en x del Goal
        # self.map.goal_y = posición en y del Goal
        # self.x, self.y = posicion x, y del estado actual
        
        return abs(self.map.goal_x - self.x) + abs(self.map.goal_y - self.y)
        # return abs(self.map.goal_x - self.x)**0.5 + abs(self.map.goal_y - self.y)**0.5

    def successors(self):
        succ = []

        def keyfunc(s):
            return -s[0].distance()

        # Ejercicio: Agregar movimientos diagonales
        positions = [
                     (self.x,   self.y-1, 'norte'),
                     (self.x,   self.y+1, 'sur'),
                     (self.x+1, self.y,   'este'),
                     (self.x-1, self.y,   'oeste'),
                     (self.x-1, self.y-1,   'noroeste'),
                     (self.x-1, self.y+1,   'suroeste'),
                     (self.x+1, self.y-1,   'noreste'),
                     (self.x+1, self.y+1,   'sureste'),
                    #  (self.x-2, self.y-1,   'caballo_noroeste_1'),
                    #  (self.x-2, self.y+1,   'caballo_suroeste_1'),
                    #  (self.x+2, self.y-1,   'caballo_noreste_1'),
                    #  (self.x+2, self.y+1,   'caballo_sureste_1'),
                    #  (self.x-1, self.y-2,   'caballo_noroeste_2'),
                    #  (self.x-1, self.y+2,   'caballo_suroeste_2'),
                    #  (self.x+1, self.y-2,   'caballo_noreste_2'),
                    #  (self.x+1, self.y+2,   'caballo_sureste_2'),
                     ]

        for x, y, action in positions:
            if self.map.inside(x, y) and self.map.free(x, y): # si (x,y) está dentro del mapa y sin obstaculo
                succ.insert(0, (Cell(x, y, self.map), action))

#        succ.sort(key=keyfunc)
        return succ

    def is_goal(self):
        return self.x == self.map.goal_x and self.y == self.map.goal_y
