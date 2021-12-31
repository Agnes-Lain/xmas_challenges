#target_area = "target area: x=20..30, y=-10..-5"

target_area = "target area: x=111..161, y=-154..-101"

# x_min = 20
# x_max = 30
# y_min = -10
# y_max = -5

x_min = 111
x_max = 161
y_min = -154
y_max = -101

prob_initial_x = 0
prob_initial_y = 0


def is_in_target(prob_x, prob_y):
    if (x_min <= prob_x <= x_max) and (y_min <= prob_y <= y_max):
        return True
    return False


def is_out(prob_x, prob_y):
    if prob_x > x_max or prob_y < y_min:
        return True
    return False


def get_next_position(prob_x, prob_y, velocity_x, velocity_y):

    prob_x += velocity_x
    prob_y += velocity_y

    if velocity_x > 0: velocity_x -= 1

    velocity_y -= 1

    return prob_x, prob_y, velocity_x, velocity_y


velocities = []
upmost_ys = []

for velocity_y in range(y_min * 2, -y_min * 2):
    for velocity_x in range(1, x_max * 2):

        new_velocity_x = velocity_x
        new_velocity_y = velocity_y

        prob_x, prob_y = prob_initial_x, prob_initial_y

        sum_y_max = 0

        while not is_out(prob_x, prob_y) and not is_in_target(prob_x, prob_y):

            prob_x, prob_y, new_velocity_x, new_velocity_y = get_next_position(
                prob_x, prob_y, new_velocity_x, new_velocity_y)

            if prob_y > sum_y_max:
                sum_y_max = prob_y

        if is_in_target(prob_x, prob_y):

            velocities.append((velocity_x, velocity_y))
            upmost_ys.append(sum_y_max)

print("✅", max(upmost_ys))
print("💥", len(velocities))
