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

enum EPS = 1e-10;

void main()
{
    int T; get(T); while (T--) {
        real a, b, c; get(a, b, c);
        auto x = b^^2 - 4 * a * c;
        if (a == 0 && b == 0) {
            writeln(c == 0 ? "3" : "0");
        } else if (a == 0) {
            writefln!"1 %.12f"(-c / b);
        } else if (abs(x) < EPS) {
            writefln!"1 %.12f"(-b / a / 2);
        } else if (x < 0) {
            writeln("0");
        } else {
            auto y = (-b - sqrt(x)) / (2 * a), z = (-b + sqrt(x)) / (2 * a);
            if (y > z) swap(y, z);
            writefln!"2 %.12f %.12f"(y, z);
        }
    }
}
