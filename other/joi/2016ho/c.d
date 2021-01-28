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

alias P = Tuple!(int, "u", int, "v");
alias E = Tuple!(int, "i", int, "to");
alias S = Tuple!(int, "i", int, "c");

void main()
{
    int N, M, Q; get(N, M, Q);
    auto H = new E[][N];
    P[] ps;
    foreach (i; 0..M) {
        int u, v; get(u, v); --u; --v;
        H[u] ~= E(i, v);
        H[v] ~= E(i, u);
        ps ~= P(u, v);
    }

    auto DP = new int[](N);
    DP[] = int.max; DP[0] = 0;
    auto us = new int[](M);
    us[] = -1;
    auto q1 = [S(0, 0)];
    while (!q1.empty) {
        auto i = q1.front.i;
        auto c = q1.front.c;
        q1.popFront();
        foreach (e; H[i]) if (DP[e.to] >= c + 1) {
            us[e.i] = e.to;
            if (DP[e.to] > c + 1) {
                DP[e.to] = c + 1;
                q1 ~= S(e.to, c + 1);
            }
        }
    }
    auto vs = new bool[](M);
    int[] rs;
    foreach (_; 0..Q) {
        int R; get(R); --R;
        vs[R] = true;
        rs ~= R;
    }

    auto G = new int[][N];
    foreach (i; 0..M) {
        if (us[i] == -1 || vs[i]) continue;
        with (ps[i]) {
            if (u == us[i]) swap(u, v);
            G[u] ~= v;
        }
    }

    auto h = N - 1;
    DP[] = 0; DP[0] = 1;
    void run(int s) {
        auto Q = [s];
        while (!Q.empty) {
            auto i = Q.front;
            Q.popFront();
            foreach (j; G[i]) if (DP[j] == 0) {
                --h;
                DP[j] = 1;
                Q ~= j;
            }
        }
    }
    run(0);

    auto res = new int[](Q);
    foreach_reverse (x, r; rs) {
        res[x] = h;

        if (us[r] == -1) continue;

        with (ps[r]) {
            if (u == us[r]) swap(u, v);
            if (DP[u] == 0) {
                G[u] ~= v;
            } else if (DP[v] == 0) {
                --h;
                DP[v] = 1;
                run(v);
            }
        }
    }
    writefln!"%(%d\n%)"(res);
}