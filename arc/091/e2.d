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
    int N, A, B; get(N, A, B);
    if (A > N || B > N) return writeln(-1);

    int[][] rr;
    int x;
    while (x < N) {
        int[] t;
        foreach (_; 0..A) if (x < N) t ~= ++x;
        rr ~= t;
    }
    if (rr.length > B) return writeln(-1);
    B -= rr.length;
    foreach (ref r; rr[1..$]) {
        if (B == 0) {
            break;
        } else if (B >= r.length - 1) {
            r.reverse();
            B -= r.length - 1;
        } else {
            r[0..B + 1].reverse();
            B = 0;
        }
    }
    if (B) return writeln(-1);

    writefln!"%(%d %)"(rr.reverse().joiner());
}
