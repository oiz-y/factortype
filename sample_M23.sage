import re

def factor_poly():
    file = open('output.txt', 'w')
    count = 0
    a = 15
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
    while a < 10000:
        # print(a)
        factor_type_dict = {}
        for p in range(5000):
            if not is_prime(p):
                continue
            R.<x> = PolynomialRing(GF(p))
            f = x^23 + x^20 + x^19 + x^18 + x^17 + x^16 + x^15 + x^14 + a
            factor_dict = get_factor_data(list(f.factor()), p)
            if not factor_dict:
                continue
            factor_type = ','.join([str(t[0]) for t in list(factor_dict.values())])
            if factor_type not in conj_type:
                file.write(str(f) + ' break ' + factor_type + '\n')
                break
            if factor_type in factor_type_dict:
                factor_type_dict[factor_type] += 1
            else:
                factor_type_dict[factor_type] = 1
            count += 1
        else:
            # print(str(f))
            # print_per(factor_type_dict, count)
            file.write(str(f) + '\n')
            for k, v in factor_type_dict.items():
                file.write(f'  タイプ:{k} 割合:{str(float(v / count))}\n')
            file.write('\n')
        a += 1
        #break
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


def print_per(factor_type_dict, count):
    for key, value in factor_type_dict.items():
        print(f'タイプ: {key}\n割合: {float(value / count)}\n')

if __name__ == '__main__':
    factor_poly()