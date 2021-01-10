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
    int N, M; get(N, M);
    long[] aa; get(aa);
    auto G = new int[][N];
    foreach (_; 0..M) {
        int X, Y; get(X, Y); --X; --Y;
        G[X] ~= Y;
    }
    auto memo = new long[](N);
    auto fs = new bool[](N);
    memo[] = -1;
    foreach (i; 0..N) if (!fs[i]) {
        long walk(int i) {
            if (!fs[i]) {
                fs[i] = true;
                auto max_a = long.min / 3;
                foreach (j; G[i]) max_a = max(max_a, walk(j));
                memo[i] = max_a;
            }
            return max(memo[i], aa[i]);
        }
        walk(i);
    }
    auto r = long.min / 3;
    foreach (i; 0..N) r = max(r, memo[i] - aa[i]);
    writeln(r);
}