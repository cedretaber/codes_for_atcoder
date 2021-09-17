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
    int N, K; long P; get(N, K, P);
    long[] AA; get(AA);

    long[][21] xx, yy;
    foreach (b; 0..1 << min(20, N)) {
        long p;
        foreach (i; 0..20) if (b & (1 << i)) p += AA[i];
        xx[popcnt(b)] ~= p;
    }

    if (N <= 20) return writeln(xx[K].count!(x => x <= P));
    
    foreach (ref xs; xx) sort(xs);

    foreach (b; 0..1 << (N - 20)) {
        long p;
        foreach (i; 0..20) if (b & (1 << i)) p += AA[20 + i];
        yy[popcnt(b)] ~= p;
    }

    long res;
    foreach (k, ys; yy) if (k <= K && K - k <= 20) foreach (y; ys) {
        auto xs = xx[K - k];
        if (xs.empty || y + xs[0] > P) {
            continue;
        } else {
            int l, r = xs.length.to!int;
            while (l + 1 < r) {
                auto m = (l + r) / 2;
                if (y + xs[m] <= P) {
                    l = m;
                } else {
                    r = m;
                }
            }
            res += r;
        }
    }
    writeln(res);
}
