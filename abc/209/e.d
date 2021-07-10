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

int to_hash(string s)
{
    int h;
    foreach (c; s) {
        h *= 52;
        if (c >= 'a') {
            h += c - 'a' + 26;
        } else {
            h += c - 'A';
        }
    }
    return h;
}

void main()
{
    int N; get(N);
    int[][52 ^^ 3] G;
    int[52 ^^ 3] ds;
    int[] qs;
    foreach (_; 0..N) {
        string s; get(s);
        auto h = to_hash(s[0..3]);
        auto t = to_hash(s[$ - 3..$]);
        qs ~= t;
        G[t] ~= h;
        ++ds[h];
    }

    auto DP = new int[](52 ^^ 3);
    SList!int Q;
    foreach (i, d; ds) if (d == 0) {
        DP[i] = 1;
        Q.insert(i.to!int);
    }

    while (!Q.empty) {
        auto v = Q.front;
        Q.removeFront();
        foreach (u; G[v]) if (DP[u] == 0) {
            --ds[u];
            if (DP[v] == 1) {
                DP[u] = -1;
                Q.insert(u);
            } else if (ds[u] == 0) {
                DP[u] = 1;
                Q.insert(u);
            }
        }
    }

    foreach (q; qs) writeln(DP[q] == 1 ? "Takahashi" : DP[q] == -1 ? "Aoki" : "Draw");
}
