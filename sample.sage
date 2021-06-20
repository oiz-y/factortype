import re

def factor_poly():
    factor_type_dict = {}
    count = 0
    for p in range(10000):
        if not is_prime(p):
            continue
        R.<x> = PolynomialRing(GF(p))
        f = x^5 + 20 * x + 16
        factor_dict = get_factor_data(list(f.factor()), p)
        factor_type = str(list(factor_dict.values()))
        if factor_type in factor_type_dict:
            factor_type_dict[factor_type] += 1
        else:
            factor_type_dict[factor_type] = 1
        count += 1
    print_per(factor_type_dict, count)

def get_factor_data(factors, p):
    factor_dict = {}
    for f in factors:
        pol_deg = re.sub(r'[^\d]', '', str(f).split(' ')[0])
        if pol_deg == '':
            factor_dict[str(f[0])] = (1, f[1])
        else:
            factor_dict[str(f[0])] = (int(pol_deg), f[1])
    return factor_dict


def print_per(factor_type_dict, count):
    for key, value in factor_type_dict.items():
        print(f'タイプ: {key} 割合: {float(value / count)}')

if __name__ == '__main__':
    factor_poly()
