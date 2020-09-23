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

alias C = Tuple!(int, "x", int, "y", int, "h");

void main()
{
    int W, H, N; get(W, H, N);
    C[] cs;
    auto MAP = new int[][](H, W);
    foreach (_; 0..N) {
        C c; get(c);
        if (MAP[c.y][c.x] < c.h) {
            MAP[c.y][c.x] = c.h;
            cs ~= c;
        }
    }
    auto Q = heapify!"a.h < b.h"(cs);
    while (!Q.empty) {
        auto X = Q.front.x;
        auto Y = Q.front.y;
        auto h = Q.front.h-1;
        Q.popFront();
        static foreach (dx; [-1,0,1]) static foreach (dy; [-1,0,1]) {{
            auto x = X+dx;
            auto y = Y+dy;
            if (0 <= x && x < W && 0 <= y && y < H && MAP[y][x] < h) {
                MAP[y][x] = h;
                if (h > 1) Q.insert(C(x, y, h));
            }
        }}
    }
    writeln(reduce!((a, line) => a + line.sum)(0L, MAP));
}