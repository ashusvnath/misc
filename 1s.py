_0_10 = ["(1-1)", "1", "(1+1)", "f(s(11))", "c(s(11))", "(c(s(11))+1)", "f(s(11))!", "(f(s(11))!+1)", "(11-f(s(11)))", "(11-1-1)", "(11-1)"]

def expr(n):
    if n < 11:
        return _0_10[n]
    _1s = int("1" * len(str(n)))
    t = int(n / _1s)
    r = n - (_1s * t)
    r1 = (n - (_1s * (t + 1))) * -1
    e = " + {}"
    if r1 < r:
        t, r, e = t + 1, r1, " - ({})"
    return str(_1s) + (" * {}".format(_0_10[t]) if t > 1 else "") + (e.format(expr(r)) if r > 0 else "")

print("Expression: {}".format(expr(int(input("Enter the number: ")))))
