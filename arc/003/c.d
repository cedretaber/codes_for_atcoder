import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void get(Args...)(ref Args args)
{
    import std.traits, std.meta, std.typecons;

    static if (Args.length == 1) {
        alias Arg = Args[0];
        
        static if (isArray!Arg) {
            args[0] = readln.split.to!Arg;
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

alias S = Tuple!(int, "x", int, "y", int, "t");

void main()
{
    int N, M; get(N, M);
    auto MAP = new int[][](N, M);
    int sx, sy, gx, gy;
    foreach (i; 0..N) foreach (jj, c; readln.chomp) {
        auto j = jj.to!int;
        if (c == 's') {
            sx = j;
            sy = i;
            MAP[i][j] = 10;
        } else if (c == 'g') {
            gx = j;
            gy = i;
            MAP[i][j] = 10;
        } else if (c == '#') {
            MAP[i][j] = -1;
        } else {
            MAP[i][j] = c - '0';
        }
    }

    auto MT = new int[][](N, M);
    foreach (ref mt; MT) mt[] = int.max;
    MT[sy][sx] = 0;
    auto Q = heapify!"a.t > b.t"([S(sx, sy, 0)]);
    while (!Q.empty) {
        auto X = Q.front.x;
        auto Y = Q.front.y;
        auto t = Q.front.t+1;
        Q.popFront();
        static foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {{
            auto x = X+d[0];
            auto y = Y+d[1];
            if (0 <= x && x < M && 0 <= y && y < N && MAP[y][x] != -1 && MT[y][x] > t) {
                if (x == gx && y == gy) goto ok;
                MT[y][x] = t;
                Q.insert(S(x, y, t));
            }
        }}
    }
    writeln(-1);
    return;

    ok:
    double l = 0, r = 10;
    foreach (_; 0..50) {
        auto m = (l+r)/2;

        foreach (ref mt; MT) mt[] = int.max;
        MT[sy][sx] = 0;
        Q = heapify!"a.t > b.t"([S(sx, sy, 0)]);
        while (!Q.empty) {
            auto X = Q.front.x;
            auto Y = Q.front.y;
            auto t = Q.front.t+1;
            Q.popFront();
            static foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {{
                auto x = X+d[0];
                auto y = Y+d[1];
                if (0 <= x && x < M && 0 <= y && y < N && MAP[y][x] != -1 && MT[y][x] > t) {
                    if (x == gx && y == gy) {
                        MT[y][x] = t;
                    } else if (MAP[y][x].to!double * 0.99^^t >= m) {
                        MT[y][x] = t;
                        Q.insert(S(x, y, t));
                    }
                }
            }}
        }
        if (MT[gy][gx] == int.max) {
            r = m;
        } else {
            l = m;
        }
    }
    writefln!"%.12f"(l);
}