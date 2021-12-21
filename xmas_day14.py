import math

elements = "NNCB"
official_elements = "KBKPHKHHNBCVCHPSPNHF"

rules = """CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C"""

official_rules = """OP -> H
CF -> C
BB -> V
KH -> O
CV -> S
FV -> O
FS -> K
KO -> C
PP -> S
SH -> K
FH -> O
NF -> H
PN -> P
BO -> H
OK -> K
PO -> P
SF -> K
BF -> P
HH -> S
KP -> H
HB -> N
NP -> V
KK -> P
PF -> P
BK -> V
OF -> H
FO -> S
VC -> P
FK -> B
NK -> S
CB -> B
PV -> C
CO -> N
BN -> C
HV -> H
OC -> N
NB -> O
CS -> S
HK -> C
VS -> F
BH -> C
PC -> S
KC -> O
VO -> P
FB -> K
BV -> V
VN -> N
ON -> F
VH -> H
CN -> O
HO -> O
SV -> O
SS -> H
KF -> N
SP -> C
NS -> V
SO -> F
BC -> P
HC -> C
FP -> H
OH -> S
OB -> S
HF -> V
SC -> B
SN -> N
VK -> C
NC -> V
VV -> S
SK -> K
PK -> K
PS -> N
KB -> S
KS -> C
NN -> C
OO -> C
BS -> B
NV -> H
FF -> P
FC -> N
OS -> H
KN -> N
VP -> B
PH -> N
NH -> S
OV -> O
FN -> V
CP -> B
NO -> V
CK -> C
VF -> B
HS -> B
KV -> K
VB -> H
SB -> S
BP -> S
CC -> F
HP -> B
PB -> P
HN -> P
CH -> O"""

# 🔥
elements = official_elements
rules = official_rules

# 🔥
steps = 40
# steps = 10
# steps = 4

corresp = {
    rule.split(" -> ")[0]: rule.split(" -> ")[1]
    for rule in rules.split("\n")
}
# print(f"{corresp=}")


def polym(elements):

    e_length = len(elements)
    new_elements = []
    for index, e in enumerate(elements):

        if index == (e_length - 1):

            # no pair
            continue

        pair = "".join([e, elements[index + 1]])
        # print(pair)
        new_elements.append(e)
        new_elements.append(corresp[pair])

    new_elements.append(elements[-1])

    return "".join(new_elements)


def ftable(elements):

    freq = {}
    for char in elements:
        if char in freq:
            freq[char] += 1
        else:
            freq[char] = 1

    return freq


def pair_ftable(elements):

    pair_ft = {}

    prev_char = ""
    for index, char in enumerate(elements):

        if index > 0:

            pair = prev_char + char

            if pair in pair_ft:
                pair_ft[pair] += 1
            else:
                pair_ft[pair] = 1

        prev_char = char

    return pair_ft


def increment_key_value(new_pair, new_count, nexxxt):

    if new_pair in nexxxt:
        nexxxt[new_pair] += new_count
    else:
        nexxxt[new_pair] = new_count


def next_freq(freq):

    nexxxt = {}

    # len of key is 2
    for key, value in freq.items():

        new_element = polym(key)[1]

        new_pair_left = key[0] + new_element
        new_pair_right = new_element + key[1]

        increment_key_value(new_pair_left, value, nexxxt)
        increment_key_value(new_pair_right, value, nexxxt)

    return nexxxt


# print(elements)

freq = pair_ftable(elements)
# print(f"{freq=}")

start_letter = elements[0]
end_letter = elements[-1]
# print(f"{start_letter=}")
# print(f"{end_letter=}")

for step in range(steps):

    # print(f"\n🥶step {step}\n")

    freq = next_freq(freq)

    last_table = {}

    for k, v in freq.items():
        increment_key_value(k[0], v / 2, last_table)
        increment_key_value(k[1], v / 2, last_table)

    increment_key_value(start_letter, 0.5, last_table)
    increment_key_value(end_letter, 0.5, last_table)

    # print(f"{step=}", f"{last_table=}")

max_e = max(last_table.values())
min_e = min(last_table.values())
print(max_e, min_e)
print(step, max_e - min_e)
