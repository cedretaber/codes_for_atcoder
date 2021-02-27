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

void main()
{
    int K; get(K);
    int[10] cs;
    cs[] = K;
    char[] S, T; get(S); get(T);
    int[10] s, t;
    foreach (c; S[0..$-1]) {
        --cs[c - '0'];
        ++s[c - '0'];
    }
    foreach (c; T[0..$-1]) {
        --cs[c - '0'];
        ++t[c - '0'];
    }

    double r = 0;
    foreach (i; 1..10) foreach (j; 1..10) {
        if (i != j && (cs[i] == 0 || cs[j] == 0)) continue;
        if (i == j && cs[i] < 2) continue;
        ++s[i]; ++t[j];
        long a, b;
        foreach (x; 1..10) {
            a += x * 10L^^s[x];
            b += x * 10L^^t[x];
        }

        if (a > b) {
            if (i == j) {
                r += (cs[i].to!double / (9 * K - 8).to!double) * ((cs[i] - 1).to!double / (9 * K - 9).to!double);
            } else {
                r += (cs[i].to!double / (9 * K - 8).to!double) * (cs[j].to!double / (9 * K - 9).to!double);
            }
        }

        --s[i]; --t[j];
    }
    writefln!"%.12f"(r);
}
