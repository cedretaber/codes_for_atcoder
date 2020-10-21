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

enum P = 10L^^9+7;

long pow(long x, long n) {
    long y = 1;
    while (n) {
        if (n%2 == 1) y = (y * x) % P;
        x = x^^2 % P;
        n /= 2;
    }
    return y;
}

long inv(long x)
{
    return pow(x, P-2);
}

void main()
{
    long L; get(L);
    if (L < 9) {
        writeln(0);
        return;
    }
    long res;
    auto s = (L-1) / 4 % P;
    auto t = (L-2) / 3 % P;
    (res += (s-1+P) % P * s % P * inv(2)) %= P;
    (res += (t-s+P) % P * ((2*L - 3*s - 3*t - 7) % P) % P * inv(2) % P) %= P;

    auto u = (L+1) / 3 % P;
    auto v = (L-2) / 2 % P;
    (res += (u-2+P) % P * ((u-3+P)%P) % P * inv(2) % P) %= P;
    (res += (v-u+P) % P * ((L-u-v-3) % P) % P) %= P; 
    writeln(res);
}

/*

  2 3 4 5 6 7 8 9
2 * + +   *
3 * * + +   * *
4 * * * + +   * * *
5 * * * * + +   * * * *
6 * * * * * + +   * * * * *


 9 10 11 12 13 14 15 16 17 18
 *           *
       *  *           *  *
             *  *  *

2,3,4 ->  9     13
3,4,5 -> 11 12     16 17
4,5,6 -> 13 14 15     19 20 21
5,6,7 -> 15 16 17 18     22 23 24 25
6,7,8 -> 17 18 19 20 21     25 26 27 28 29
7,8,9 -> 19 20 21 22 23 24     28 29 30 31 32 33
8.9.0 -> 21 22 23 24 25 26 27     31 32 33 34 35 36 37


+++++
+++
+

++++
++

++++++
++++
++

++++
+

++++++++
+++++
++

++++++
+++

*/