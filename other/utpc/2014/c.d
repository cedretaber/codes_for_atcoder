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
    auto g1 = new int[](N);
    auto g2 = new int[][N];
    foreach (_; 0..N) {
        int A, B; get(A, B); --A; --B;

        ++g1[A];
        ++g1[B];

        g2[A] ~= B;
        g2[B] ~= A;
    }

    auto min_r = g1.minElement() == 1 ? 1 : 2;

    auto cs = new int[](N);
    bool check(int i, int p, int c) {
        auto d = c == 1 ? 2 : 1;
        if (cs[i] == 0) {
            cs[i] = c;
            foreach (j; g2[i]) if (j != p && check(j, i, d)) return true;
            return false;
        } else {
            return cs[i] != c;
        }
    }
    auto max_r = N - (check(0, -1, 1) ? 1 : 0);

    writeln(min_r, " ", max_r);
}