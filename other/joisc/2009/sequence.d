import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;
import core.bitop;

void get(Args...)(ref Args args)
{
    import std.traits, std.meta, std.typecons;

    static if (Args.length == 1) {
        alias Arg = Args[0];
        
        static if (isArray!Arg) {
            args[0] = readln.split.to!Arg;
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

void main()
{
    int M; get(M);
    long p, q; get(p); get(q);
    long[] AS; get_lines(M, AS);
    uint A;
    foreach (i, a; AS) if (a%2) A |= 1<<i;
 
    if (A == 0) {
        writeln(0);
        return;
    }
 
    uint next(uint X) {
        uint Y;
        auto flip = !!(X & (1<<(M-1)));
        while (X) {
            Y ^= X;
            X = (X<<1) & ((1<<M)-1);
        }
        return flip ? (~Y & ((1<<M)-1)) : Y;
    }
 
    auto memo = new bool[](1<<M);
    uint X = A;
    long ss, k;
    for (;;) {
        if (memo[X]) break;
        ++k;
        memo[X] = true;
        ss += popcnt(X);
        X = next(X);
    }
 
    auto len = M.to!long * k;
    long count(long p) {
        if (p <= 0) return 0;
 
        long r = p/len*ss;
        p %= len;
        if (p) {
            uint X = A;
            while (p >= M) {
                r += popcnt(X);
                X = next(X);
                p -= M;
            }
            if (p) r += popcnt(X & ((1<<p)-1));
        }
        return r;
    }
    writeln(count(q) - count(p-1));
}

/*

a1 a2 a3 a4 a5 ... an

an^a1 an^a1^a2 an^a1^a2^a3 an^a1^a2^a3^a4 ... a1^a2^a3^...an-1



an^a1 ^ a1^a2^a3^a4^..an-1 = an^a2^a3^a4^...


*/