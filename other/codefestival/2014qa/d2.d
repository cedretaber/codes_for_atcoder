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

import core.bitop;

void main()
{
    char[] A; int K; get(A, K);
    auto N = A.to!long;
    auto r = long.max;
    foreach (b; 0..2^^10) if (popcnt(b) == K) {
        bool[10] bs;
        int min_n = -1, max_n, s_min = -1;
        foreach (i; 0..10) if ((1<<i) & b) {
            bs[i] = true;
            if (min_n != -1 && s_min == -1) s_min = i;
            if (min_n == -1) min_n = i;
            max_n = i;
        }

        long n;
        if (min_n == 0 && s_min != -1) {
            n = s_min;
            foreach (_; 0..A.length) n *= 10;
            r = min(r, n - N);
        } else if (min_n != 0) {
            n = min_n;
            foreach (_; 0..A.length) n = n * 10 + min_n;
            r = min(r, n - N);
        } else if (min_n == 0 && s_min == -1) {
            r = min(r, N);
            continue;
        }
        n = 0;
        if (A.length > 1) {
            n = max_n;
            foreach (_; 0..A.length - 2) n = n * 10 + max_n;
            r = min(r, N - n);
        }
        n = 0;
        foreach (i; 0..A.length + 1) {
            if (i == A.length) {
                r = 0;
                break;
            }
            auto x = A[i] - '0';
            foreach (j; x + 1..10) if (bs[j]) {
                auto m = n * 10 + j;
                foreach (_; i..A.length - 1) m = m * 10 + min_n;
                r = min(r, m - N);
            }
            foreach_reverse (j; 0..x) if (bs[j]) {
                auto m = n * 10 + j;
                foreach (_; i..A.length - 1) m = m * 10 + max_n;
                r = min(r, N - m);
            }
            if (bs[x]) {
                n = n * 10 + x;
            } else {
                break;
            }
        }
    }
    writeln(r);
}
