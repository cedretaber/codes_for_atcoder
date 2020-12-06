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

    auto ans = 0.iota(H * W).array;
    ans = ans[1..$] ~ [0];

    int[] B;
    foreach (_; 0..H) B ~= readln.split.to!(int[]);

    if (B == ans) {
        writeln(0);
        return;
    }
    
    int[immutable(int[])] memo;
    memo[cast(immutable(int[]))B] = 0;

    int p;
    while (B[p] != 0) ++p;
    B = B ~ [p, 0];

    auto bs = [B];
    for (;;) {
        auto b = bs[0];
        bs.popFront();

        auto c = b[$-1];

        if (c == 12) break;

        auto i = b[$-2];
        auto x = i % W;
        auto y = i / W;

        static foreach (d; [[0,1], [1,0], [0,-1], [-1,0]]) {{
            auto xx = x + d[0];
            auto yy = y + d[1];
            if (0 <= xx && xx < W && 0 <= yy && yy < H) {
                auto j = yy * W + xx;
                auto bb = b.dup;
                swap(bb[i], bb[j]);

                auto key = cast(immutable(int[]))bb[0..H*W];

                if (key !in memo) {
                    if (key == ans) {
                        writeln(c + 1);
                        return;
                    }

                    memo[key] = c + 1;
                    bb[$-1] = c + 1;
                    bb[$-2] = j;
                    bs ~= bb;
                }
            }
        }}
    }

    bool[immutable(int[])] memo2;
    memo2[cast(immutable(int[]))ans] = true;
    bs = [ans ~ [H*W-1, 0]];
    for (;;) {
        auto b = bs[0];
        bs.popFront();

        auto c = b[$-1];
        auto i = b[$-2];
        auto x = i % W;
        auto y = i / W;

        static foreach (d; [[0,1], [1,0], [0,-1], [-1,0]]) {{
            auto xx = x + d[0];
            auto yy = y + d[1];
            if (0 <= xx && xx < W && 0 <= yy && yy < H) {
                auto j = yy * W + xx;
                auto bb = b.dup;
                swap(bb[i], bb[j]);

                auto key = cast(immutable(int[]))bb[0..H*W];

                if (key in memo) {
                    writeln(memo[key] + c + 1);
                    return;
                }

                if (key !in memo2) {
                    memo2[key] = true;
                    bb[$-1] = c + 1;
                    bb[$-2] = j;
                    bs ~= bb;
                }
            }
        }}
    }
}