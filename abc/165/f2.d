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
    int[] as; get(as);
    auto T = new int[][N];
    foreach (_; 0..N-1) {
        int u, v; get(u, v); --u; --v;
        T[u] ~= v;
        T[v] ~= u;
    }

    auto res = new int[](N);
    auto DP = new int[](N);
    void solve(int i, int p, int c) {
        auto a = as[i];
        if (c == 0 || DP[c-1] < a) {
            DP[c++] = a;
            res[i] = c;
            foreach (j; T[i]) if (j != p) solve(j, i, c);
        } else {
            res[i] = c;
            int r;
            if (DP[0] < a) {
                int l;
                r = c-1;
                while (l+1 < r) {
                    auto m = (l+r)/2;
                    if (DP[m] < a) {
                        l = m;
                    } else {
                        r = m;
                    }
                }
            }
            auto b = DP[r];
            DP[r] = a;
            foreach (j; T[i]) if (j != p) solve(j, i, c);
            DP[r] = b;
        }
    }
    solve(0, -1, 0);
    writefln!"%(%d\n%)"(res);
}