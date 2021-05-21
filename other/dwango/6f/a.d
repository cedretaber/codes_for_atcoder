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
    bool t;
    if (H > W) {
        swap(H, W);
        t = true;
    }
    if (H > 2 && !(H == 3 && W == 3)) return writeln("No");

    auto res = new int[][](H, W);
    if (H == 1) {
        auto r = W % 7;
        if (r != 0 && r != 2 && r != 5) return writeln("No");
        int i;
        if (r == 2) foreach (_; 0..2) res[0][i++] = 2;
        foreach (_o; 0..W / 7) {
            foreach (_; 0..5) res[0][i++] = 5;
            foreach (_; 0..2) res[0][i++] = 2;
        }
        if (r == 5) foreach (_; 0..5) res[0][i++] = 5;
    } else if (H == 2) {
        auto r = (W * 2) % 7;
        if (r != 0 && r != 2 && r != 5) return writeln("No");
        int i;
        if (r == 2) foreach (_; 0..2) {
            res[i % 2][i / 2] = 2;
            ++i;
        }
        foreach (_o; 0..(W * 2) / 7) {
            foreach (_; 0..5) {
                res[i % 2][i / 2] = 5;
                ++i;
            }
            foreach (_; 0..2) {
                res[i % 2][i / 2] = 2;
                ++i;
            }
        }
        if (r == 5) foreach (_; 0..5) {
            res[i % 2][i / 2] = 5;
            ++i;
        }
    } else {
        res = [
            [5, 5, 5],
            [2, 5, 2],
            [2, 5, 2]
        ];
    }

    if (t) {
        auto res2 = new int[][](W, H);
        foreach (i; 0..H) foreach (j; 0..W) res2[j][i] = res[i][j];
        res = res2;
    }
    writeln("Yes");
    foreach (line; res) {
        foreach (c; line) write(c);
        writeln("");
    }
}
