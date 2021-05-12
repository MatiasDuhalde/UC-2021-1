"""
This module parses contains functions used to parse the input of a DIMACS file,
into a format manageable by the solvers.
"""


class Formula:
    """
    Stores the info a of a Formula, usually extracted directly from a text file.

    Attributes:
        formula_type (str): The type of formula to store. Currently only cnf is
            supported
        nprops (int): The number of propositions in the formula
        nclauses (int): The number of clauses in the formula
    """

    def __init__(
        self, formula_type='cnf', nprops=0, nclauses=0,
        clauses=None, props=None, strict_headers=True
    ):
        self.formula_type = formula_type
        self.nprops = nprops
        self.nclauses = nclauses
        self.clauses = clauses if clauses is not None else set()
        self.clauses_count = len(self.clauses)
        self.props = props if props is not None else set()
        self.strict_headers = strict_headers

    def add_clause(self, clause: tuple):
        """
        Arguments:
            clause: The clause to add to the formula in list format
        """
        new_clauses = self.clauses.union({clause})
        self.clauses_count += 1
        new_props = self.props.copy()
        for prop in clause:
            new_props.add(abs(prop))
        if self.clauses_count > self.nclauses:
            if self.strict_headers:
                raise ValueError(
                    "Error: The number of clauses exceeds the limit")
            self.nclauses = len(new_clauses)
        if len(new_props) > self.nprops:
            if self.strict_headers:
                raise ValueError(
                    "Error: The number of propositions exceeds the limit")
            self.nprops = len(new_props)
        self.clauses = new_clauses
        self.props = new_props

    @classmethod
    def dimacs(cls, file_path: str, strict_headers: bool = False):
        """
        Wrapper for calling dimacs
        Use help(dimacs) for more information
        """
        return dimacs(file_path, strict_headers)

    def fuerzabruta(self) -> int:
        """
        Wrapper for calling fuerzabruta
        Use help(fuerzabruta) for more information
        """
        return fuerzabruta(self)

    def mejorado(self) -> int:
        """
        Wrapper for calling mejorado
        Use help(mejorado) for more information
        """
        return mejorado(self)

    def evaluate(self, valuation: dict[int, bool]) -> int:
        """
        Evaluates the formula with the provided valuation and returns the value
        of the formula
        Arguments:
            valuation: The dictionary describing the valuation. The key a : True
                evaluates to the proposition a to True
        """
        # Validate valuation
        for prop in self.props:
            if valuation.get(prop) is None:
                print("Error: Invalid valuation")
                return 0
        # Solve
        for clause in self.clauses:
            clause_is_true = False
            for prop in clause:
                value = valuation[abs(prop)]
                if prop < 0:
                    value = not value
                if value:
                    # If one prop is true -> The entire clause is true
                    clause_is_true = True
                    break
            # If one clause is false -> The entire formula is false
            if not clause_is_true:
                return 0
        return 1


def dimacs(file_path: str, strict_headers: bool = False) -> Formula:
    """
    Parses a text file into a Formula

    Arguments:
        file_path: The path to the dimacs formula file, usually with .cnf
            extension type
        strict_headers: If the headers in the file should be immutable in case
            they contradict the rest of the info in the file
    Returns: An instance of Formula containing the data extracted from the text
        file
    """
    formula = Formula(strict_headers=strict_headers)
    try:
        line_number = 1
        with open(file_path) as dimacs_file:
            reading_headers = True
            end_found = False
            # Get first line
            line = dimacs_file.readline().rstrip()
            while line:
                # Try to find the p line first
                if reading_headers:
                    starting = line.split(' ', 1)
                    # Ignore if starting is 'c'
                    if starting[0] == 'p':
                        reading_headers = False
                        formula_type, nprops, nclauses = starting[1].split()
                        formula.formula_type = formula_type
                        formula.nprops = int(nprops)
                        formula.nclauses = int(nclauses)
                # If already found, try to parse file
                else:
                    line_data = line.split()
                    if end_found:
                        if line_data[0] == '0':
                            break
                        raise ValueError('Error: Invalid EOF')
                    if line_data[0] == '%':
                        end_found = True
                    # Assume its a number, otherwise it will raise a ValueError
                    else:
                        found_zero = False
                        clause = []
                        for number in line_data:
                            parsed_number = int(number)
                            if parsed_number == 0:
                                found_zero = True
                                break
                            clause.append(parsed_number)
                        if not found_zero:
                            raise ValueError("Error: Found EOL before 0 character")
                        formula.add_clause(tuple(clause))
                # Get next line
                line_number += 1
                line = dimacs_file.readline().rstrip()
            if reading_headers:
                raise ValueError(
                    "Error: Could not find headers (p line) in file")
            if not end_found:
                raise ValueError("Error: Could not find a valid EOF")
            if not strict_headers:
                formula.nprops = len(formula.props)
            if len(formula.props) < formula.nprops:
                raise ValueError(
                    f"Error: Expected {formula.nprops} propositions, found {len(formula.props)}")
            if formula.clauses_count < formula.nclauses:
                raise ValueError(
                    f"Error: Expected {formula.nclauses} clauses, found {len(formula.clauses)}")
            return formula
    except FileNotFoundError as err:
        print(err)
    except IndexError:
        print("Error: Could not parse file, wrong format", f"\nProblem in line: {line_number}")
    except ValueError as err:
        print(err, f"\nProblem in line: {line_number}")
    return None


def fuerzabruta(formula: Formula) -> int:
    """
    Checks satisfactifility of formula, using a bruteforce algorithm.

    Arguments:
        formula: The instance of the formula to solve.
    """
    def rec(current_valuation, index):
        if len(current_valuation.keys()) < formula.nprops:
            if rec({**current_valuation, list(formula.props)[index]: True}, index+1):
                return 1
            if rec({**current_valuation, list(formula.props)[index]: False}, index+1):
                return 1
            return 0
        return formula.evaluate(current_valuation)
    return rec(dict(), 0)


def mejorado(formula):
    """
    Checks satisfactifility of formula, using an enhanced algorithm.

    Arguments:
        formula: The instance of the formula to solve.
    """
    return formula


if __name__ == '__main__':
    # 20props satisfacibles
    # for i in range(1, 21):
    #     result = dimacs(f'Datos T5/20props satisfacibles/uf20-0{i}.cnf')
    #     print(fuerzabruta(result))
    # 50props satisfacibles
    # for i in range(1, 11):
    #     result = dimacs(f'Datos T5/50props insatisfacibles/uuf50-0{i}.cnf')
    #     print(fuerzabruta(result))
    #     break
    # # 50props insatisfacivles
    # for i in range(1, 11):
    #     result = dimacs(f'Datos T5/50props satisfacivles/uf50-0{i}.cnf')
    result = dimacs('unsat_test.cnf')
    print(fuerzabruta(result))
