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

int distribute(int s, int l)
{
    auto p = min(l, (s - 1) / 2);
    auto q = s - p - 1;
    return p * (p + 1) / 2 + q * (q + 1) / 2;
}

int oneside(int s, int n)
{
    return (s + n) * (s + n + 1) / 2 - n * (n + 1) / 2;
}

int stick(int s, int i)
{
    if (i < 0) {
        if (i + s <= 1) {
            return oneside(s, -i - s);
        } else {
            auto l = -i;
            auto r = s + i - 1;
            return l * (l + 1) / 2 + r * (r + 1) / 2;
        }
    } else {
        return oneside(s, i - 1);
    }
}

void main()
{
    int R, G, B; get(R, G, B);
    (-1000).iota(1001).map!(i =>
        stick(G, i) +
        ((i <= -99) ? oneside(R, -i - 100) : distribute(R, i + 99)) +
        ((i + G - 1 >= 99) ? oneside(B,  i + G - 1 - 100) : distribute(B, 99 - (i + G - 1)))
    ).minElement().writeln();
}

/*

0 1 2 3 4 5 6 7 8 9 10
5 4 3 2 1 0 1 2 3 4 5

*/
