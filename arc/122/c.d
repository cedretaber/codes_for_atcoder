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
    long[] F = [0, 1];
    foreach (i; 2..88) F ~= F[$ - 1] + F[$ - 2];

    long N; get(N);
    int s;
    foreach (i, f; F) {
        if (f > N) break;
        s = i.to!int;
    }
    int[] res;
    foreach (i; 0..s - 1) {
        if (N >= F[s - i]) {
            N -= F[s - i];
            res ~= (s - i - 1) % 2 == 1 ? 2 : 1;
        }
        res ~= (s - i - 1) % 2 == 1 ? 3 : 4;
    }
    writefln!"%d\n%(%d\n%)"(res.length, res);
}

/*

0 1 1 2 3 5 8 13

  x y
. 0 0
2 0 1
3 1 1
4 1 2
2 1 3
3 4 3

2 0 1
3 1 1

1 1 0
4 1 1
3 2 1


*/
