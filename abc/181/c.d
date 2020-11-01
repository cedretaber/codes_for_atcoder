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
    int[] xs, ys; get_lines(N, xs, ys);
    foreach (i; 0..N) foreach (j; 0..N) foreach (k; 0..N) if (i != j && j != k && i != k) {
        if (xs[k] * ys[j] - xs[k] * ys[i] - xs[i] * ys[j] == xs[j] * ys[k] - xs[i] * ys[k] - xs[j] * ys[i]) {
            writeln("Yes");
            return;
        }
    }
    writeln("No");
}

/*

x1 x2 x3
y1 y2 y3

(x2 - x1) : (y2 - y1) = (x3 - x1) : (y3 - y1)
(y2 - y1)(x3 - x1) = (x2 - x1)(y3 - y1)
x3y2 - x3y1 - x1y2 + x1y1 = x2y3 - x1y3 - x2y1 + x1y1
x3y2 - x3y1 - x1y2 = x2y3 - x1y3 - x2y1

*/