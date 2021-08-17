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
    int H, W; get(H, W);
    char[][] SS; get_lines(H, SS);

    auto DP = new int[][](H, W);
    foreach (ref dp; DP) dp[] = int.max / 3;
    DP[0][0] = 0;

    alias S = Tuple!(int, "i", int, "j", int, "d");
    auto Q = heapify!"a.d > b.d"([S(0, 0, 0)]);
    while (!Q.empty) with (Q.front) {
        Q.popFront();
        if (DP[i][j] < d) continue;
        static foreach (x; [[0, 1], [1, 0], [0, -1], [-1, 0]]) {{
            auto ii = i + x[0];
            auto jj = j + x[1];
            if (0 <= ii && ii < H && 0 <= jj && jj < W && SS[ii][jj] == '.' && DP[ii][jj] > d) {
                DP[ii][jj] = d;
                Q.insert(S(ii, jj, d));
            }
        }}
        static foreach (di; -2..3)
        static foreach (dj; -2..3)
        if (abs(di) != 2 || abs(dj) != 2) {
            auto ii = i + di;
            auto jj = j + dj;
            if (0 <= ii && ii < H && 0 <= jj && jj < W && DP[ii][jj] > d + 1) {
                DP[ii][jj] = d + 1;
                Q.insert(S(ii, jj, d + 1));
            }
        }
    }
    writeln(DP[H - 1][W - 1]);
}
