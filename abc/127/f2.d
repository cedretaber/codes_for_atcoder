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
    int Q; get(Q);
    long B, L, U, M;
    auto ls = heapify!"a < b"(Array!long());
    auto us = heapify!"a > b"(Array!long());
    {
        long x, a, b; get(x, a, b);
        M = a;
        B = b;
    }
    while (--Q) {
        auto ii = readln.split.to!(long[]);
        if (ii[0] == 1) {
            auto a = ii[1];
            auto b = ii[2];
            B += b;
            if (a >= M) {
                us.insert(a);
                U += a - M;
            } else {
                ls.insert(a);
                L += M - a;
            }
            if (us.length > ls.length + 1) {
                auto m = us.front;
                auto d = m - M;
                ls.insert(M);
                M = m;
                L += d * ls.length;
                U -= d * us.length;
                us.popFront();
            } else if (ls.length > us.length) {
                auto m = ls.front;
                auto d = M - m;
                us.insert(M);
                M = m;
                L -= d * ls.length;
                U += d * us.length;
                ls.popFront();
            }
        } else {
            writeln(M, " ", L + U + B);
        }
    }
}