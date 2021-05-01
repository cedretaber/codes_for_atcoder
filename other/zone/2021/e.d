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
    int R, C; get(R, C);
    long[][] AA; get_lines(R, AA);
    long[][] BB; get_lines(R, BB);

    auto DP = new long[][][](R, C, 2);
    foreach (ref dp1; DP) foreach (ref dp2; dp1) dp2[] = long.max / 3;

    alias S = tuple!(int, "r", int, "c", long, "cost", bool, "from_l");
    auto Q = heapify!"a.cost > b.cost"([S(0, 0, 0, false)]);
    while (!Q.empty) with (Q.front) {
        Q.popFront();
        if (DP[r][c][from_l ? 1 : 0] < cost) continue;

        if (c < C - 1 && DP[r][c + 1][0] > cost + AA[r][c]) {
            DP[r][c + 1][0] = cost + AA[r][c];
            Q.insert(S(r, c + 1, DP[r][c + 1][0], false));
        }
        if (c > 0 && DP[r][c - 1][0] > cost + AA[r][c - 1]) {
            DP[r][c - 1][0] = cost + AA[r][c - 1];
            Q.insert(S(r, c - 1, DP[r][c - 1][0], false));
        }
        if (r < R - 1 && DP[r + 1][c][0] > cost + BB[r][c]) {
            DP[r + 1][c][0] = cost + BB[r][c];
            Q.insert(S(r + 1, c, DP[r + 1][c][0], false));
        }
        if (r > 0 && DP[r - 1][c][1] > cost + 1 + (from_l ? 0 : 1)) {
            DP[r - 1][c][1] = cost + 1 + (from_l ? 0 : 1);
            Q.insert(S(r - 1, c, DP[r - 1][c][1], true));
        }
    }
    writeln(DP[R - 1][C - 1][0]);
}
