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

void main()
{
    int H, W, h, w; get(H, W, h, w);
    if (H%h == 0 && W%w == 0) {
        writeln("No");
        return;
    }
    writeln("Yes");

    bool T;
    if (W%w == 0) {
        T = true;
        swap(H, W);
        swap(h, w);
    }

    auto ss = new int[](W+1);
    foreach (i; 0..w) {
        foreach (j; 0..W) {
            if (i+w*j > W) break;
            ss[i+w*j] = -j;
        }
    }
    for (int i = W, j = 1; i >= 0; i -= w, ++j) {
        ss[i] = j;
    }
    int[] as;
    foreach (i; 0..W) as ~= ss[i+1] - ss[i];

    if (T) {
        foreach (a; as) {
            foreach (_; 1..H) write(a, " ");
            writeln(a);
        }
    } else {
        foreach (_; 0..H) writefln!"%(%s %)"(as);
    }
}

/*

H=10 W=7 h=4 w=3

0 0 4 -1 -1 3 -2 -2 2 -3 -3 1
0 4 -5 0 4 -5 0 4 -5 0 4


*/