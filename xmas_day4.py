import numpy as np


def is_board_winning(board, draws):
    for line in np.concatenate((board, board.transpose()), axis=0):
        if np.all(np.isin(line, draws)): return True

    return False


with open('raw_data/data_day4.csv') as file:
    lines = [line.strip() for line in file]

draws = np.array([int(draw) for draw in lines[0].split(",")])
boards = np.array([line.split() for line in lines[2:]
                   if line.strip() != ""]).astype(int).reshape(-1, 5, 5)

past_draws = []
for draw in draws:
    past_draws.append(draw)
    stack_to_delete = []
    for idx, board in enumerate(boards[:]):
        if is_board_winning(board, past_draws):
            flat = board.flatten()
            flat = np.sum(flat[np.isin(flat, past_draws, invert=True)])
            result = flat * draw
            stack_to_delete.append(idx)

    boards = np.delete(boards, stack_to_delete, 0)

print(result)