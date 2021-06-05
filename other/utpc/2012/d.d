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

import std.complex;

void main()
{
    int N; get(N);
    Complex!double[] AA, BB;
    foreach (i; 0..N * 2) {
        double x, y; get(x, y);
        auto c = complex(x, y);
        if (i < N) {
            AA ~= c;
        } else {
            BB ~= c;
        }
    }

    auto f(Complex!double z) {
        auto s = 0.5;
        auto p = (BB[1] - BB[0]).arg - (AA[1] - AA[0]).arg;
        return (z - AA[0]) * fromPolar(0.5, p) + BB[0];
    }

    auto z = AA[0];
    foreach (_; 0..1000) z = f(z);
    writefln!"%.12f %.12f"(z.re, z.im);
}
