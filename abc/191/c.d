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
    char[][] F; get_lines(H, F);

    int n;
    foreach (i; 1..H-1) foreach (j; 1..W-1) if (F[i][j] == '#') {
        static foreach (d; [[1, 1], [-1, -1], [1, -1], [-1, 1]]) {{
            auto i1 = i+d[0];
            auto j1 = j+d[1];

            auto i2 = i+d[0];
            auto j2 = j;

            auto i3 = i;
            auto j3 = j+d[1];

            if (F[i1][j1] == '.' && F[i2][j2] == '.' && F[i3][j3] == '.') ++n;
            if (F[i1][j1] == '.' && F[i2][j2] == '#' && F[i3][j3] == '#') ++n;
        }}
    }
    writeln(n);
}


/*

.#.
###
.#.

*/