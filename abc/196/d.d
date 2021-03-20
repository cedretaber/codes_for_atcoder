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

import core.bitop;

void main()
{
    int H, W, A, B; get(H, W, A, B);
    auto DP = new int[][](A + 1, 2 ^^ (H * W));
    DP[0][0] = 1;
    foreach (n; 0..A) {
        foreach (b; 0..2 ^^ (H * W)) {
            foreach (i; 0..H) foreach (j; 0..W) {
                uint p = (1U << (i * W + j));
                static foreach (d; [[0,1], [1,0]]) {{
                    auto ii = i + d[0];
                    auto jj = j + d[1];
                    if (0 <= ii && ii < H && 0 <= jj && jj < W) {
                        auto q = p | (1U << (ii * W + jj));
                        if (!(b & q)) {
                            DP[n + 1][b | q] += DP[n][b];
                        }
                    }
                }}
            }
        }
    }
    int r;
    foreach (b, c; DP[A]) if (popcnt(b) == H * W - B) r += c;
    int d = 1;
    foreach (i; 2..A + 1) d *= i;
    writeln(r / d);
}
