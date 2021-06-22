import re
import random

def factor_poly():
    file = open('output.txt', 'w')
    a = 0
    deg = 23
    conj_type = [
        '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1',
        '1,11,11',
        '1,1,1,1,1,1,1,2,2,2,2,2,2,2,2',
        '1,1,1,2,2,4,4,4,4',
        '1,2,4,8,8',
        '1,1,7,7,7',
        '2,7,14',
        '1,1,1,1,1,3,3,3,3,3,3',
        '1,1,1,5,5,5,5',
        '3,5,15',
        '1,2,2,3,3,6,6',
        '23'
    ]
    while a < 1000000:
        count = 0
        coef = random.sample(range(-100000000, 100000000), deg)
        factor_type_dict = {}
        for p in range(1000):
            if not is_prime(p):
                continue
            R.<x> = PolynomialRing(GF(p))
            f = 0
            for i in range(deg):
                f += coef[i] * x^i
            f += x^deg
            factor_dict = get_factor_data(list(f.factor()), p)
            if not factor_dict:
                continue
            factor_type = ','.join([str(t[0]) for t in list(factor_dict.values())])
            if factor_type not in conj_type:
                file.write(f'{str(coef)} prime:{p} decomposition type:{factor_type}\n')
                break
            if factor_type in factor_type_dict:
                factor_type_dict[factor_type] += 1
            else:
                factor_type_dict[factor_type] = 1
            count += 1
        else:
            file.write(str(coef) + '\n')
            for k, v in factor_type_dict.items():
                file.write(f'  decomposition type:{k} ratio:{str(float(v / count))}\n')
            file.write('\n')
        a += 1
    file.close()

def get_factor_data(factors, p):
    factor_dict = {}
    for f in factors:
        pol_deg = re.sub(r'[^\d]', '', str(f).split(' ')[0])
        if f[1] > 1:
            return None
        if pol_deg == '':
            factor_dict[str(f[0])] = (1, f[1])
        else:
            factor_dict[str(f[0])] = (int(pol_deg), f[1])
    return factor_dict

if __name__ == '__main__':
    factor_poly()
