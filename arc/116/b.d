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

enum P = 998244353L;

void main()
{
    int N; get(N);
    long[] AA; get(AA);
    sort(AA);

    long res, d;
    foreach (a; AA) {
        (res += a * (d + a) % P) %= P;
        (d *= 2) %= P;
        (d += a) %= P;
    }
    writeln(res);
}


/*

3
2 4 3
2 3 4

Ai * ∑[j = i -> N]{ Aj * 2^(j-i-1) }

2 * (2 + 3 + 4 * 2) = 2 * (2 + 3 + 8) = 26
3 * (3 + 4) = 21
4 * (4) = 16
=> 63

2 * 2 = 4
3 * (2 + 3) = 15
4 * (2 * 2 + 3 + 4) = 4 * 11 = 44
=> 63

*/
