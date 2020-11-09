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
    long[] AS; get_lines(N, AS);

    long s, x = 1;
    foreach (i, a; AS) {
        s += (a-1) / x;
        if (a == x || i == 0) ++x;
    }
    writeln(s);
}

/*

15
3 -> 1 * 2 -> 1
1 -> 0 -> 1
4 -> 3 * 1 -> 1
1 -> 0 -> 1
5 -> 2 * 2 -> 1
9 -> 2 * 4 -> 1
2 -> 0 -> 2
6 -> 5 * 1 -> 1
5 -> 3 * 1 -> 2
3 -> 0 -> 3
5 -> 4 * 1 -> 1
8 -> 7 * 1 -> 1
9 -> 4 * 2 -> 1
7 -> 6 * 1 -> 1
9 -> 4 * 2 -> 1


*/