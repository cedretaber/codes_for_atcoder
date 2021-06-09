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
    int[] BB;
    int si, sj;
    foreach (i; 0..H) foreach (j, b; readln.split.to!(int[])) {
        BB ~= b;
        if (b == 0) {
            si = i.to!int;
            sj = j.to!int;
        }
    }
    alias L = immutable(int)[];
    alias S = Tuple!(L, "bb", int, "i", int, "j");
    int[L] memo;
    auto s = S(cast(L)BB, si, sj);
    memo[cast(L)BB] = 0;
    auto ss = [s];
    foreach (t; 0..12) {
        S[] tt;
        foreach (c; ss) {
            static foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {{
                auto i = c.i + d[0];
                auto j = c.j + d[1];
                if (0 <= i && i < H && 0 <= j && j < W) {
                    auto bb = c.bb.dup;
                    swap(bb[c.i * W + c.j], bb[i * W + j]);
                    if (cast(L)bb !in memo) {
                        memo[cast(L)bb] = t + 1;
                        tt ~= S(cast(L)bb, i, j);
                    }
                }
            }}
        }
        ss = tt;
    }

    auto aa = 1.iota(H * W).array ~ 0;
    if (aa in memo) return writeln(memo[cast(L)aa]);

    s = S(cast(L)aa, H - 1, W - 1);
    bool[L] memo2;
    memo2[cast(L)aa] = true;
    ss = [s];
    foreach (t; 0..12) {
        S[] tt;
        foreach (c; ss) {
            static foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {{
                auto i = c.i + d[0];
                auto j = c.j + d[1];
                if (0 <= i && i < H && 0 <= j && j < W) {
                    auto bb = c.bb.dup;
                    swap(bb[c.i * W + c.j], bb[i * W + j]);
                    if (cast(L)bb in memo) return writeln(t + memo[cast(L)bb] + 1);
                    if (cast(L)bb !in memo2) {
                        memo2[cast(L)bb] = true;
                        tt ~= S(cast(L)bb, i, j);
                    }
                }
            }}
        }
        ss = tt;
    }
}
