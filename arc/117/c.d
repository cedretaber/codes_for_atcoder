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

enum i2c = "BWR";

void main()
{
    int N; get(N);
    char[] CC; get(CC);
    auto cc = CC.map!(c => c == 'B' ? 0 : c == 'W' ? 1 : 2).array();

    auto fs = new int[](N);
    foreach (i; 3..N) {
        fs[i] = fs[i - 1];
        auto n = i;
        while (n % 3 == 0) {
            ++fs[i];
            n /= 3;
        }
    }

    auto gs = new int[](N);
    gs[0] = 1;
    foreach (i; 1..N) {
        auto n = i;
        while (n % 3 == 0) n /= 3;
        gs[i] = (gs[i - 1] * n) % 3;
    }

    int s;
    foreach (i; 0..N) {
        if (fs[N - 1] - fs[i] - fs[N - 1 - i] == 0) {
            int r;
            if ((gs[N - 1] == 1 && (gs[i] * gs[N - 1 - i]) % 3 == 1) || (gs[N - 1] == 2 && (gs[i] * gs[N - 1 - i]) % 3 == 2)) {
                r = 1;
            } else {
                r = 2;
            }
            (s += cc[i] * r) %= 3;
        }
    }
    if (N % 2 == 0) s = (3 - s) % 3;
    writeln(i2c[s]);
}

/*

B=0 W=1 R=2

012 => 1*0 + 2*2 + 2*1 = 4 = 1

2200 => 1*2 + 3*2 + 3*0 + 1*0 = 8 = 2
N % 2 == 0 -> 3 - 2 = 1

*/
