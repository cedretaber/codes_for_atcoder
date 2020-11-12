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
    int N; long K; get(N, K);
    long[] AS; get(AS);

    long[long] ms = [0: 1];
    long[] ns = [0];
    long r, s;
    foreach (i, a; AS) {
        s += a;

        auto n = (s - i.to!long - 1) % K;
        if (n < 0) n += K;
        ns ~= n;

        auto j = i.to!long + 1 - K;
        if (j >= 0) --ms[ns[j]];
        
        if (n in ms) r += ms[n];
        ++ms[n];
    }
    writeln(r);
}

/*


1 1
0 1 2

3 2 1 1
0 3 5 6 7
{0:1}
{0:1, 2:1}
{0:1, 2:1, 3:1}
{0:1, 2:1, 3:2}
{0:1, 2:1, 3:3}

5 4
1 4 2 3 5

0 1 5 7 10 15

{0:1}
{0:2}
{0:2, 3:1}
{0:3, 3:1}
{0:3, 3:1, 2:1}
{0:3, 3:1, 2:2}


8 4
4 2 4 2 4 2 4 2

0 2 0 2 0 2 0 2

0 0 2 2 0 0 2 2 0

{0:1}
{0:1, 3:1}
{0:2, 3:1}
{0:2, 3:1, 1:1}
{0:2, 3:1, 1:1}
{0:2, 3:2, 1:1}



10 7
14 15 92 65 35 89 79 32 38 46

0 1 1 2 0 5 2 4 3 4

0 0 1 2 4 4 2 4 1 4 1
2 4   1 1 1   1   1

1 1 0 6 4 4 6 4 0 4 0
  1 2           2 2 1

1 + 4*3/2 = 7
1 + 1 = 2
7 + 2 = 9

1 1 2
 2 3
  4


*/