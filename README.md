# Yin Yang Puzzle

## Overview
This project is a **Yin Yang Puzzle Solver** that utilizes **Clingo** for logic-based puzzle solving. It provides a streamlined workflow using a **Makefile** to encode, solve, and display solutions efficiently.

## Description

The **Yin Yang Puzzle** is designed to solve puzzles from the `examples` folder. Each puzzle is stored in a text file called `dom<file_number>.txt`. 

The file contains a grid of cells representing the puzzle, with the following format:

  - `.` for an unknown cell.
  - `0` for a white cell.
  - `1` for a black cell.

Also included in the `examples` folder are the expected solutions for each puzzle, stored in text files called `sol<file_number>.txt`. 

The solutions are generated using **Clingo** and the following restrictions:

  - Each unknown cell must be either white or black.
  - The cells of the same color must be connected to each other in a single group.
  - Cannot have a 2x2 square of cells of the same color.

Additionally, for efficiency purposes, the solver includes the following restrictions to reduce the search space:
  
  - Cannot have a 2x2 cross of cells of opposite colors.
  - The count of changes of color, pathing the edge in a loop, must be equal or less than 2. This rule ensures that all cells of the same color that lay on the edge are connected through the edge.


## Usage
This project includes a **Makefile** with commands to run and test the solver. The following commands are available:

- **Encode Puzzle:**
  ```sh
  make encode <file_number>
  ```
  Converts the puzzle from `examples/dom<file_number>.txt` into a logic program stored in `dom<file_number>.lp`.

- **Decode Puzzle:**
  ```sh
  make decode <file_number>
  ```
  Encodes and solves the puzzle, saving the decoded solution in `sol<file_number>.txt`.

- **Display Solution:**
  ```sh
  make display <file_number>
  ```
  Encodes and solves the puzzle, then displays the solution in a graphical window.

- **Run Tests:**
  ```sh
  make test
  ```
  Uses the `scripts/test.sh` script to solve all puzzles in the `examples` folder via `make decode` and compares the results with expected solutions.

You can also add more puzzles to the `examples` folder and use the provided commands to solve them.

> [!NOTE]  
> If you are having trouble executing you might need to create a python3 virtual enviroment.
