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
    int N; get(N);
    int[] ps; get(ps);
    ps = [-1] ~ ps.map!"a - 1"().array();
    auto T = new int[][N];
    foreach (i, p; ps) if (p >= 0) T[p] ~= i.to!int;

    auto cs = new int[](N);
    int count(int i) {
        int s = 1;
        foreach (j; T[i]) s += count(j);
        return cs[i] = s;
    }
    count(0);

    auto DP = new int[](N);
    bool solve(int i) {
        DP[i] = 1;
        if (T[i].empty) return true;

        int[] xs, ss;
        foreach (j; T[i]) {
            if (solve(j)) {
                xs ~= j;
            } else {
                ss ~= j;
            }
        }
        sort!((a, b) => DP[a] * 2 - cs[a] < DP[b] * 2 - cs[b])(xs);
        foreach (j, x; xs) {
            if (j % 2 == 0) {
                DP[i] += DP[x];
            } else {
                DP[i] += cs[x] - DP[x];
            }
        }
        foreach (j; ss) {
            if (cs[j] - DP[j] >= DP[j]) {
                DP[i] += DP[j];
            } else {
                DP[i] += (xs.length % 2 == 0 ? DP[j] : cs[j] - DP[j]);
            }
        }

        return xs.length % 2 == 0;
    }
    solve(0);
    writeln(DP[0]);
}