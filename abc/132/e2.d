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
    auto G = new int[][N];
    while (M--) {
        int u, v; get(u, v);
        G[u-1] ~= v-1;
    }
    int S, T; get(S, T); --S; --T;

    auto memo = new int[][](N, 3);
    foreach (ref m; memo) m[] = int.max/3;

    memo[S][0] = 0;
    auto ss = [[S, 0]];
    while (!ss.empty) {
        auto i = ss[0][0];
        auto s = ss[0][1] + 1;
        ss.popFront();
        foreach (j; G[i]) if (memo[j][s%3] > s) {
            memo[j][s%3] = s;
            ss ~= [j, s];
        }
    }
    writeln(memo[T][0] == int.max/3 ? -1 : memo[T][0] / 3);
}