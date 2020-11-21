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

alias P = Tuple!(int, "to", int , "c");

void main()
{
    int N, M; get(N, M);
    auto G = new P[][N];
    foreach (_; 0..M) {
        int u, v, c; get(u, v, c);
        G[u-1] ~= P(v-1, c);
        G[v-1] ~= P(u-1, c);
    }

    auto res = new int[](N);
    void walk(int i, int p, int x) {
        if (x > 0) {
            res[i] = x;
            foreach (n; G[i]) if (n.to != p && res[n.to] == 0) {
                if (n.c == x) {
                    walk(n.to, i, -x);
                } else {
                    walk(n.to, i, n.c);
                }
            }
        } else {
            res[i] = -1;
            bool[int] memo;
            memo[-x] = true;
            x = 1;
            while (x in memo) ++x;
            foreach (n; G[i]) if (n.to != p && res[n.to] == 0) {
                memo[n.c] = true;
                while (x in memo) ++x;
                walk(n.to, i, n.c);
            }
            res[i] = x;
        }
    }
    walk(0, -1, 0);
    writefln!"%(%d\n%)"(res);
}