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
    char[][] CC; get_lines(N, CC);

    void transpose() {
        auto cc = new char[][](M, N);
        foreach (i; 0..N) foreach (j; 0..M) cc[j][N - i - 1] = CC[i][j];
        CC = cc;
        swap(N, M);
    }
    void rev_c() {
        foreach (i; 0..N) foreach (j; 0..M / 2) swap(CC[i][j], CC[i][M - j - 1]);
    }

    int res;
    void solve() {
        foreach (i; 0..N) foreach (j; 0..M) {
            void run() {
                int s, d;
                while (i + d < N && j + d < M) {
                    auto ii = i + d, jj = j;
                    for (;;) {
                        if (CC[ii][jj] == 'X') return;
                        s += CC[ii][jj] - '0';
                        if (ii == i) break;
                        --ii; ++jj;
                    }
                    res = max(res, s);
                    ++d;
                }
            }
            run();
        }
    }

    foreach (_; 0..4) {
        solve();
        rev_c();
        solve();
        rev_c();
        transpose();
    }
    writeln(res);
}
