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

alias M = Tuple!(int, "s", int, "e");
alias S = Tuple!(int, "m", int, "i");

enum SIZE = 100000 + 2;

void main()
{
    int N; get(N);
    long[] HS; get(HS);
    auto MS = new M[][N];
    foreach (_; 0..N) {
        int m, S, E; get(m, S, E);
        MS[m - 1] ~= M(S, E);
    }

    auto ss = new S[][SIZE + 1];
    foreach (i, ref mm; MS) {
        sort!"a.e < b.e"(mm);
        foreach (j, m; mm) ss[m.s] ~= S(i.to!int, j.to!int);
    }

    auto DP = new long[](SIZE + 1);
    foreach (t; 0..SIZE) {
        DP[t + 1] = max(DP[t + 1], DP[t]);
        foreach (s; ss[t]) {
            long h;
            int i, e = t;
            foreach (m; MS[s.m][s.i..$]) if (m.s >= e) {
                h += HS[i++];
                e = m.e;
                DP[e] = max(DP[e], DP[t] + h);
            }
        }
    }
    writeln(DP[SIZE]);
}
