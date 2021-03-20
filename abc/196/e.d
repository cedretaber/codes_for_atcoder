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
    long[] aa; int[] tt; get_lines(N, aa, tt);
    long max_x = long.max / 3, min_x = long.min / 3;
    foreach_reverse (i; 0..N) {
        auto a = aa[i];
        auto t = tt[i];
        if (t == 1) {
            max_x -= a;
            min_x -= a;
        } else if (t == 2) {
            min_x = max(min_x, a);
            if (max_x < min_x) max_x = min_x;
        } else {
            max_x = min(max_x, a);
            if (min_x > max_x) min_x = max_x;
        }
    }
    long max_a = long.max / 3, min_a = long.min / 3, d = 0;
    foreach (i; 0..N) {
        auto a = aa[i];
        auto t = tt[i];
        if (t == 1) {
            max_a += a;
            min_a += a;
            d += a;
        } else if (t == 2) {
            min_a = max(min_a, a);
            if (max_a < min_a) max_a = min_a;
        } else {
            max_a = min(max_a, a);
            if (min_a > max_a) min_a = max_a;
        }
    }
    int Q; get(Q);
    long[] XS; get(XS);
    foreach (x; XS) {
        if (x >= max_x) {
            writeln(max_a);
        } else if (x <= min_x) {
            writeln(min_a);
        } else {
            writeln(x + d);
        }
    }
}

/*

3
-10 2
10 1
10 3
5
-15 -10 -5 0 5

min(10, max(-10, x) + 10)

.. -10
=> .. 0 (+ 10)
=> 10 .. 0 (+ 10)

-15 => -5 => 0
-10 => 0 => 0
-5 => 5 => 5
0 => 10 => 10
5 => 15 => 10


10..
=> 0..
=> 0..-10

*/
