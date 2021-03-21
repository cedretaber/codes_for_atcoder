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
    int N; get(N);
    int[][] CS; get_lines(N, CS);

    int p, min_c = CS[0].minElement();
    foreach (i; 1..N) {
        auto c = CS[i].minElement();
        if (c < min_c) {
            min_c = c;
            p = i;
        }
    }
    foreach (i; 0..N) {
        auto d = CS[i][0] - CS[p][0];
        if (d < 0) return writeln("No");
        foreach (j; 1..N) if (CS[i][j] - CS[p][j] != d) return writeln("No");
    }
    int[] aa;
    foreach (i; 0..N) aa ~= CS[i][0] - CS[p][0];
    if (aa.minElement() < 0) return writeln("No");

    writeln("Yes");
    writefln!"%(%d %)"(aa);
    writefln!"%(%d %)"(CS[p]);
}

/*

4 3 5
2 1 3
3 2 4

2 1 3
4 3 5
3 2 4

0 0 0
2 2 2
1 1 1

2 0 1

*/
