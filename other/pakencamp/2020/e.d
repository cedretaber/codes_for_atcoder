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
    long X, Y; get(X, Y);
    long A, B;
    if (X == 0 && Y == 0) {
        A = 42;
        B = 42;
    } else if (X == 0) {
        A = Y * 2;
        B = Y;
    } else if (Y == 0) {
        A = X;
        B = X * 2;
    } else if (X > Y) {
        A = X;
        B = X + Y;
    } else if (X < Y) {
        B = Y;
        A = X + Y;
    } else {
        return writeln(-1);
    }
    writeln(A, " ", B);
}

/*

A % B = X
B % A = Y
1 <= A, B <= 10^18

X > Y => A < B => A = X
X < Y => A > B => B = Y

*/