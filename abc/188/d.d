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

alias S = Tuple!(int, "a", int, "b", long, "c");

void main()
{
    int N; long C; get(N, C);
    S[] ss;
    int[] ts = [0];
    int[int] tm = [0:0];
    foreach (_; 0..N) {
        int a, b; long c; get(a, b, c); ++b;
        if (a !in tm) {
            tm[a] = 1;
            ts ~= a;
        }
        if (b !in tm) {
            tm[b] = 1;
            ts ~= b;
        }
        ss ~= S(a, b, c);
    }
    sort(ts);
    foreach (i, t; ts) tm[t] = i.to!int;
    auto cs = new long[](ts.length);
    foreach (s; ss) {
        cs[tm[s.a]] += s.c;
        cs[tm[s.b]] -= s.c;
    }
    long res;
    foreach (i; 1..ts.length-1) {
        cs[i] += cs[i-1];
        res += min(cs[i], C) * (ts[i+1] - ts[i]);
    }
    writeln(res);
}