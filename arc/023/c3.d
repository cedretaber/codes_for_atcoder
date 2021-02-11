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

enum P = 10L^^9 + 7;

long modinv(long a, long m)
{
    long b = m, u = 1, v = 0;
    while (b) {
        auto t = a / b;
        a -= t * b; swap(a, b);
        u -= t * v; swap(u, v);
    }
    u %= m;
    if (u < 0) u += m;
    return u;
}

void main()
{
    int N; get(N);
    long[] AS; get(AS);

    long last_a, last_i = -1, cnt, res = 1;
    foreach (i, a; AS) {
        if (a > 0) {
            if (cnt > 0) {
                foreach (x; a - last_a..a - last_a + cnt) (res *= x + 1) %= P;
                foreach (x; 0..cnt) (res *= modinv(x + 1, P)) %= P;
            }
            last_i = i;
            last_a = a;
            cnt = 0;
        } else {
            cnt += 1;
        }
    }
    writeln(res);
}

/*

1 . . 3

1 1
1 2
1 3
2 2
2 3
3 3

1 * * * *

4C2 => 4 * 3 / 2 * 1 = 6


*/