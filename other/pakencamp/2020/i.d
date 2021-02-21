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
    int sx, sy, gx, gy; get(sy, sx, gy, gx); --sx; --sy; --gx; --gy;
    char[][] MAP; get_lines(H, MAP);

    auto DP = new int[][][](H, W, 2);
    foreach (ref dp1; DP) foreach (ref dp2; dp1) dp2[] = int.max / 3;
    DP[sy][sx][] = 0;

    alias U = Tuple!(int, "x", int, "y", int, "d", int, "c");
    auto ss = [U(sx, sy, 0, 0), U(sx, sy, 1, 0)];
    while (!ss.empty) with (ss.front) {
        ss.popFront();
        if (DP[y][x][d] < c) continue;
        static foreach (n; [1, -1]) {
            if (d == 0) {
                auto xx = x + n;
                if (0 <= xx && xx < W && MAP[y][xx] == '.' && DP[y][xx][1] > c + 1) {
                    DP[y][xx][1] = c + 1;
                    ss ~= U(xx, y, 1, c + 1);
                }
            } else {
                auto yy = y + n;
                if (0 <= yy && yy < H && MAP[yy][x] == '.' &&  DP[yy][x][0] > c + 1) {
                    DP[yy][x][0] = c + 1;
                    ss ~= U(x, yy, 0, c + 1);
                }
            }
        }
    }
    auto r = DP[gy][gx].minElement();
    writeln(r == int.max / 3 ? -1 : r);
}