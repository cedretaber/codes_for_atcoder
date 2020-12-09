import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void get(Args...)(ref Args args)
{
    import std.traits, std.meta, std.typecons;

    static if (Args.length == 1) {
        alias Arg = Args[0];
        
        static if (isArray!Arg) {
          static if (isSomeChar!(ElementType!Arg)) {
            args[0] = readln.chomp.to!Arg;
          } else {
            args[0] = readln.split.to!Arg;
          }
        } else static if (isTuple!Arg) {
            auto input = readln.split;
            static foreach (i; 0..Fields!Arg.length) {
                args[0][i] = input[i].to!(Fields!Arg[i]);
            }
        } else {
            args[0] = readln.chomp.to!Arg;
        }
    } else {
        auto input = readln.split;
        assert(input.length == Args.length);

        static foreach (i; 0..Args.length) {
            args[i] = input[i].to!(Args[i]);
        }
    }
}

void get_lines(Args...)(size_t N, ref Args args)
{
    import std.traits, std.range;

    static foreach (i; 0..Args.length) {
        static assert(isArray!(Args[i]));
        args[i].length = N;
    }

    foreach (i; 0..N) {
        static if (Args.length == 1) {
            get(args[0][i]);
        } else {
            auto input = readln.split;
            static foreach (j; 0..Args.length) {
                args[j][i] = input[j].to!(ElementType!(Args[j]));
            }
        }
    }
}
long P = 10^^9+7;

long pow(long x, long n) {
    long y = 1;
    while (n) {
        if (n%2 == 1) y = (y * x) % P;
        x = x^^2 % P;
        n /= 2;
    }
    return y;
}

alias AB = Tuple!(long, "a", long, "b", bool, "p");

void main()
{
    int N; get(N);
    long[AB] abm;
    long zero;
    foreach (_; 0..N) {
        long A, B; get(A, B);
        if (A == 0 && B == 0) {
            ++zero;
        } else if (A == 0) {
            ++abm[AB(0, 1, false)];
        } else if (B == 0) {
            ++abm[AB(1, 0, true)];
        } else {
            auto p = (A < 0 && B < 0) || (A > 0 && B > 0);
            A = abs(A); B = abs(B);
            auto d = gcd(A, B);
            A /= d; B /= d;
            ++abm[AB(A, B, p)];
        }
    }

    long r = 1;
    foreach (x, c; abm) {
        if (c == 0) continue;
        long q;
        (q += pow(2L, abm[x])) %= P;
        abm[x] = 0;
        auto y = AB(x.b, x.a, !x.p);
        if (y in abm && abm[y] != 0) {
            (q += pow(2L, abm[y]) + P - 1) %= P;
            abm[y] = 0;
        }
        (r *= q) %= P;
    }
    writeln((r + zero + P - 1) % P);
}

/*

2 1

-5 10

A_i : B_i = B_j : A_j

*/