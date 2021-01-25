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

alias X = Tuple!(int, "i", int, "x");

void main()
{
    int N; get(N);
    X[] xs;
    auto aa = new int[](N * N);
    foreach (ii, x; readln.split.to!(int[])) {
        auto i = ii.to!int + 1;
        aa[x-1] = i;
        xs ~= X(i, x);
    }
    sort!"a.x < b.x"(xs);
    int[] bb;
    foreach (x; xs) foreach (_; 1..x.i) bb ~= x.i;
    foreach (x; xs) foreach (_; x.i..N) bb ~= x.i;

    auto cs = new int[](N + 1);
    foreach (ref a; aa) {
        if (a == 0) {
            a = bb.front;
            ++cs[bb.front];
            bb.popFront();
        } else {
            if (cs[a] != a - 1) return writeln("No");
        }
    }

    writefln!"Yes\n%(%d %)"(aa);
}


/*

3
1 5 9


1 2 3 3 2 1 1 2 3


2
4 1

2 * * 1



3
1 8 6

1 1 1 3 3 3 2 2 2


3
7 5 3

3 3 3 2 2 2 1 1 1

*/